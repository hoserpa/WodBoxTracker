import path from "node:path";
import { readFile, writeFile } from "node:fs/promises";

const root = process.cwd();
const envText = await readFile(path.join(root, ".env"), "utf8");
const env = Object.fromEntries(
  envText
    .split(/\r?\n/)
    .filter((line) => line && !line.trim().startsWith("#"))
    .map((line) => {
      const i = line.indexOf("=");
      return [
        line.slice(0, i).trim(),
        line
          .slice(i + 1)
          .trim()
          .replace(/^["']|["']$/g, ""),
      ];
    }),
);

const url = env.VITE_SUPABASE_URL;
const key = env.VITE_SUPABASE_ANON_KEY;
if (!url || !key) throw new Error("Faltan VITE_SUPABASE_URL o VITE_SUPABASE_ANON_KEY en .env");

const headers = { apikey: key, Authorization: `Bearer ${key}` };
const get = async (pathname) => {
  const res = await fetch(`${url}/rest/v1/${pathname}`, { headers });
  if (!res.ok) throw new Error(`${res.status} ${await res.text()}`);
  return res.json();
};

const RIR_BY_RPE = { 6: 4, 7: 3, 8: 2 };
const RPE_RE = /RPE([678])\s*x\s*(\d+)/gi;

const parseReps = (value, count) => {
  const text = String(value ?? "").trim();
  if (/^\d+$/.test(text)) return Array(count).fill(Number(text));
  if (/^\d+(-\d+)+$/.test(text)) return text.split("-").map(Number);
  return null;
};

const parseTarget = (row) => {
  if (!["principal", "secundario"].includes(row.tipo_ejercicio)) return null;
  const obs = row.observaciones ?? "";
  const matches = [...obs.matchAll(RPE_RE)];
  if (matches.length !== 3) return null;

  const rpes = matches.map((m) => Number(m[1]));
  if (rpes.join(",") !== "6,7,8") return null;

  const counts = matches.map((m) => Number(m[2]));
  const total = counts.reduce((sum, n) => sum + n, 0);
  const reps = parseReps(row.repeticiones, total);
  if (!reps || reps.length !== total || total !== Number(row.series)) return null;

  const firstPart = obs.split("|")[0].trim();
  const tempo = /^Tempo\b/i.test(firstPart) ? firstPart : null;

  let offset = 0;
  const groups = matches.map((match, index) => {
    const rpe = Number(match[1]);
    const count = counts[index];
    const groupReps = reps.slice(offset, offset + count);
    offset += count;
    const sameReps = groupReps.every((rep) => rep === groupReps[0]);
    const observaciones = `RIR${RIR_BY_RPE[rpe]} RPE${rpe}${tempo ? ` - ${tempo}` : ""}`;
    return {
      rows: sameReps
        ? [{ series: count, repeticiones: String(groupReps[0]), observaciones }]
        : groupReps.map((rep) => ({ series: 1, repeticiones: String(rep), observaciones })),
    };
  });

  return groups.flatMap((group) => group.rows);
};

const sqlString = (value) => (value == null ? "NULL" : `'${String(value).replaceAll("'", "''")}'`);

const semanas = await get("semanas?select=id&rutina_id=eq.3&order=id");
const semanaIds = semanas.map((s) => s.id).join(",");
const dias = await get(`dias?select=id&semana_id=in.(${semanaIds})&order=id`);
const diaIds = dias.map((d) => d.id);
const series = await get(
  `series?select=id,dia_id,ejercicio_id,series,repeticiones,observaciones,tipo_ejercicio,orden&dia_id=in.(${diaIds.join(",")})&order=dia_id,orden,id`,
);

const byDay = new Map();
for (const row of series) {
  if (!byDay.has(row.dia_id)) byDay.set(row.dia_id, []);
  byDay.get(row.dia_id).push(row);
}

const statements = [];
const skipped = [];
let converted = 0;
let inserted = 0;

for (const [diaId, rows] of byDay) {
  const expanded = [];
  let touched = false;

  for (const row of rows) {
    const groups = parseTarget(row);
    if (!groups) {
      if (
        ["principal", "secundario"].includes(row.tipo_ejercicio) &&
        /RPE[678]\s*x\s*\d+/i.test(row.observaciones ?? "")
      ) {
        skipped.push(row.id);
      }
      expanded.push({ source: row, first: true, data: row, unchanged: true });
      continue;
    }

    touched = true;
    converted += 1;
    groups.forEach((group, index) => {
      expanded.push({
        source: row,
        first: index === 0,
        data: { ...row, ...group },
        unchanged: false,
      });
    });
  }

  if (!touched) continue;

  expanded.forEach((item, index) => {
    const orden = index;
    if (item.unchanged) {
      statements.push(`UPDATE series SET orden = ${orden} WHERE id = ${item.source.id};`);
    } else if (item.first) {
      statements.push(
        `UPDATE series SET series = ${item.data.series}, repeticiones = ${sqlString(
          item.data.repeticiones,
        )}, observaciones = ${sqlString(item.data.observaciones)}, orden = ${orden} WHERE id = ${
          item.source.id
        };`,
      );
    } else {
      inserted += 1;
      statements.push(
        `INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES (${diaId}, ${
          item.source.ejercicio_id
        }, ${item.data.series}, ${sqlString(item.data.repeticiones)}, ${sqlString(
          item.data.observaciones,
        )}, ${sqlString(item.source.tipo_ejercicio)}, ${orden});`,
      );
    }
  });
}

const dayList = [...byDay.keys()].join(",");
const header = [
  "-- Conversión de Fuerza Pliometría al formato de series de Hipertrofia",
  "-- Generado por scripts/generate-fuerza-pliometria-conversion.mjs",
  `-- Filas comprimidas convertidas: ${converted}; filas nuevas insertadas: ${inserted}`,
  "-- Ejecutar en el SQL Editor de Supabase",
  "",
  "BEGIN;",
  "",
];

const footer = [
  "",
  "COMMIT;",
  "",
  "-- Verificación:",
  "SELECT dia_id, id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden",
  "FROM series",
  `WHERE dia_id IN (${dayList})`,
  "ORDER BY dia_id, orden;",
  "",
];

await writeFile(
  path.join(root, "import_bd", "convert_fuerza_pliometria_series.sql"),
  [...header, ...statements, ...footer].join("\n"),
);

console.log(`Días afectados: ${[...byDay.keys()].join(", ")}`);
console.log(`Filas convertidas: ${converted}`);
console.log(`Filas insertadas: ${inserted}`);
if (skipped.length) {
  throw new Error(
    `Filas con distribución RPE no reconocida (${skipped.length}): ${skipped.join(", ")}`,
  );
}

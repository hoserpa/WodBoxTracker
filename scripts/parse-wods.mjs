import { readFileSync, writeFileSync, mkdirSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, "..");
const SRC = path.join(ROOT, "wods.txt");
const OUT_DIR = path.join(ROOT, "src", "data");
const OUT_FILE = path.join(OUT_DIR, "wods.json");

const num = (v) => parseInt(v, 10);

const stripJunkTail = (s) => s.replace(/[\s(]+$/, "").trim();

const MAX_UNIT = {
  rep: "reps",
  cal: "calories",
  calorie: "calories",
  mt: "meters",
  meter: "meters",
  step: "steps",
};

const WORD_NUMBERS = {
  one: 1,
  two: 2,
  three: 3,
  four: 4,
  five: 5,
  six: 6,
  seven: 7,
  eight: 8,
  nine: 9,
  ten: 10,
};

function normalizeHeader(s) {
  let t = s.toLowerCase().trim();
  t = t.replace(/[.,:]+\s*$/, "");
  t = t.replace(/\bfounds?\b/g, "rounds");
  t = t.replace(/\breounds\b/g, "rounds");
  t = t.replace(/\btimem\b/g, "time");
  t = t.replace(/\btim\b/g, "time");
  t = t.replace(/^or\s+time/, "for time");
  t = t.replace(/^fir\s+tune$/, "for time");
  t = t.replace(/\bfo\s+time\b/g, "for time");
  t = t.replace(/^fir\s+/, "for ");
  t = t.replace(/\bamrp\b/g, "amrap");
  for (const [word, n] of Object.entries(WORD_NUMBERS)) {
    t = t.replace(new RegExp(`^${word}\\s+`), `${n} `);
  }
  t = t.replace(/\s+/g, " ");
  return t;
}

function unitIsMinutes(u) {
  return /^min/i.test(u);
}

function secondsOf(value, unit) {
  return /^min/i.test(unit) ? value * 60 : value;
}

function parseHeader(lineRaw) {
  let teamSize = null;
  const raw = lineRaw.trim();
  const teamMatch = raw.match(/^te[a-z]{0,3}s?\s+of\s+(\d+)\s+(?:complete\s+)?(.+)$/i);
  let s = raw;
  if (teamMatch) {
    teamSize = num(teamMatch[1]);
    s = teamMatch[2].trim();
  }
  s = normalizeHeader(s);

  let m;
  if ((m = s.match(/^amrap$/))) {
    return { type: "amrap", duration: null, rounds: null, team_size: teamSize };
  }
  if (
    (m = s.match(
      /^amrap\s*(?:in\s+|for\s+|for\s+time\s+)?(\d+)\s*([a-z.*]+)(?:\s+of)?[:.]?\s*$/,
    )) &&
    unitIsMinutes(m[2])
  ) {
    return { type: "amrap", duration: num(m[1]), rounds: null, team_size: teamSize };
  }
  if (
    (m = s.match(
      /^(\d+)\s+rounds?\s+for\s+time[,]?(?:\s+(\d+)\s*([a-z.*]+))?(?:\s+of)?[:\s]*$/,
    )) &&
    (m[2] === undefined || unitIsMinutes(m[3]))
  ) {
    return {
      type: "rounds_for_time",
      duration: m[2] ? num(m[2]) : null,
      rounds: num(m[1]),
      team_size: teamSize,
    };
  }
  if (
    (m = s.match(/^(\d+)\s+rounds?\s+(\d+)\s*([a-z.*]+)$/)) &&
    unitIsMinutes(m[3])
  ) {
    return {
      type: "rounds_for_time",
      duration: num(m[2]),
      rounds: num(m[1]),
      team_size: teamSize,
    };
  }
  if (
    (m = s.match(/^(\d+)\s+rounds?\s+for\s+(\d+)\s*([a-z.*]+)$/)) &&
    unitIsMinutes(m[3])
  ) {
    return {
      type: "rounds_for_time",
      duration: num(m[2]),
      rounds: num(m[1]),
      team_size: teamSize,
    };
  }
  if ((m = s.match(/^(\d+)\s+rounds?\s*(?:of)?[:.]?\s*$/))) {
    return {
      type: "rounds_for_time",
      duration: null,
      rounds: num(m[1]),
      team_size: teamSize,
    };
  }
  if ((m = s.match(/^for\s+time(?:\s+(\d+)\s*([a-z.*]+))?[:,]?\s*$/)) && (m[1] === undefined || unitIsMinutes(m[2]))) {
    return {
      type: "for_time",
      duration: m[1] ? num(m[1]) : null,
      rounds: null,
      team_size: teamSize,
    };
  }
  if ((m = s.match(/^emom\s+(\d+)\s*([a-z.]+)/)) && unitIsMinutes(m[2])) {
    return { type: "emom", duration: num(m[1]), rounds: null, team_size: teamSize };
  }
  if ((m = s.match(/^emom\s+(\d+)\s+rounds?$/))) {
    return { type: "emom", duration: num(m[1]), rounds: null, team_size: teamSize };
  }
  if (/^emom\s+as\s+long\s+as\s+possible$/.test(s)) {
    return { type: "emom", duration: null, rounds: null, team_size: teamSize };
  }
  if (
    (m = s.match(
      /^every\s+(\d+)\s*(minutes?|seconds?|min)\s+for\s+(?:time\s+)?(\d+)\s*minutes?(?:\s*\((\d+)\s*rounds?\))?$/,
    ))
  ) {
    const intervalMin = /^sec/i.test(m[2]) ? num(m[1]) / 60 : num(m[1]);
    const total = num(m[3]);
    return {
      type: "intervals",
      duration: null,
      rounds: null,
      interval_minutes: intervalMin,
      interval_rounds: m[4] ? num(m[4]) : Math.round(total / intervalMin),
      team_size: teamSize,
    };
  }
  if (
    (m = s.match(/^every\s+(\d+)\s*(minutes?|seconds?)\s+for\s+(\d+)\s+rounds?$/))
  ) {
    return {
      type: "intervals",
      duration: null,
      rounds: null,
      interval_minutes: /^sec/i.test(m[2]) ? num(m[1]) / 60 : num(m[1]),
      interval_rounds: num(m[3]),
      team_size: teamSize,
    };
  }
  if ((m = s.match(/^(?:for\s+)?(\d+)\s+cycles?\s+amrap\s+(\d+)/))) {
    return {
      type: "intervals",
      duration: null,
      rounds: null,
      interval_minutes: num(m[2]),
      interval_rounds: num(m[1]),
      team_size: teamSize,
    };
  }
  if ((m = s.match(/^(\d+)\s+rounds?\s+for\s+amrap\s+(\d+)/))) {
    return {
      type: "intervals",
      duration: null,
      rounds: null,
      interval_minutes: num(m[2]),
      interval_rounds: num(m[1]),
      team_size: teamSize,
    };
  }
  if (teamSize !== null) {
    return null;
  }
  if ((m = s.match(/^(\d+)\s*([a-z.*]+)$/)) && unitIsMinutes(m[2])) {
    return { type: "amrap", duration: num(m[1]), rounds: null, team_size: null };
  }
  return null;
}

function parseItem(lineRaw) {
  const line = lineRaw.trim();
  let m;
  if ((m = line.match(/^max\s+(.+)$/i))) {
    let body = m[1];
    let seconds;
    const timeMatch = body.match(/\s+(?:for\s+)?(\d+)\s*(seconds?|minutes?)$/i);
    if (timeMatch) {
      seconds = secondsOf(num(timeMatch[1]), timeMatch[2]);
      body = body.slice(0, timeMatch.index);
    }
    const unitMatch = body.match(/^(rep?s?|cal(?:orie)?s?|mt|meters?|steps)\b\s*/i);
    let unit = "reps";
    if (unitMatch) {
      const key = unitMatch[1].toLowerCase().replace(/s$/, "");
      unit = MAX_UNIT[key] ?? "reps";
      body = body.slice(unitMatch[0].length);
    }
    body = body.replace(/^of\s+/i, "").trim();
    const item = { exercise: stripJunkTail(body), max_rep: true, unit };
    if (seconds !== undefined) item.seconds = seconds;
    return item;
  }
  if ((m = line.match(/^(\d+)\s*(seconds?|minutes?)\s+rest!?$/i))) {
    return { exercise: "rest", seconds: secondsOf(num(m[1]), m[2]), rest_item: true };
  }
  if ((m = line.match(/^(\d+)\s+seconds?\s+(.+)$/i))) {
    return { exercise: stripJunkTail(m[2]), seconds: num(m[1]) };
  }
  if ((m = line.match(/^(\d+(?:-\d+)*)\s?m(?:t)?\s+(.+)$/i))) {
    const dist = m[1].split("-").map(num);
    const item = { exercise: stripJunkTail(m[2]) };
    if (dist.length === 1) item.distance_m = dist[0];
    else item.distance_m = dist;
    return item;
  }
  if ((m = line.match(/^(\d+)\s+(.+)$/))) {
    return { exercise: stripJunkTail(m[2]), reps: num(m[1]) };
  }
  return { exercise: stripJunkTail(line) };
}

function parseScheme(lineRaw) {
  const line = lineRaw.trim();
  let m =
    line.match(/^(.+?)\s+reps?(?:\s+rounds)?(?:\s+for\s+time)?\s+of:?(?:\s+(.+))?$/i) ??
    line.match(/^(.+?)\s+reps?(?:\s+rounds)?\s+for\s+time$/i);
  if (!m) return null;
  const cleaned = m[1].replace(/\.{2,}\s*$/, "").replace(/~/g, "-").trim();
  if (!/^[\d,\s-]+$/.test(cleaned)) return null;
  return { scheme: m[1].trim(), inline: m[2] ? stripJunkTail(m[2]) : null };
}

function splitChunks(lines) {
  const chunks = [];
  let cur = [];
  for (const raw of lines) {
    const line = raw.trim();
    if (!line) continue;
    if (line === "|") {
      chunks.push(cur);
      cur = [];
      continue;
    }
    cur.push(line);
  }
  if (cur.length) chunks.push(cur);
  return chunks.filter((c) => c.length > 0);
}

function parseChunk(lines, state) {
  const { warnings } = state;
  const wodId = state.nextId++;
  const blocks = [];
  let type = null;
  let duration = null;
  let rounds = null;
  let intervalMinutes = null;
  let intervalRounds = null;
  let teamSize = null;
  const repSchemes = [];
  const notes = [];
  let curBlock = null;
  let pendingScheme = null;
  let itemCount = 0;
  let lastWasRest = false;

  function flush() {
    if (!curBlock) return;
    if (curBlock.items.length > 0 || curBlock.rest || curBlock.label !== "work") {
      blocks.push(curBlock);
    }
    curBlock = null;
  }

  function openWork() {
    if (curBlock && ["work", "then", "remaining_time"].includes(curBlock.label)) {
      return curBlock;
    }
    flush();
    curBlock = { label: "work", items: [] };
    lastWasRest = false;
    return curBlock;
  }

  function startSegment(header) {
    flush();
    pendingScheme = null;
    curBlock = { label: "work", items: [] };
    if (header.type) curBlock.type = header.type;
    if (header.duration != null) curBlock.duration = header.duration;
    if (header.rounds != null) curBlock.rounds = header.rounds;
    if (header.interval_minutes != null) curBlock.interval_minutes = header.interval_minutes;
    if (header.interval_rounds != null) curBlock.interval_rounds = header.interval_rounds;
    lastWasRest = false;
  }

  function finish() {
    flush();
    if (type === null) {
      warnings.push({ id: wodId, line: lines[0], reason: "sin cabecera reconocida" });
    }
    const out = { id: wodId, type };
    if (duration != null) out.duration = duration;
    if (rounds != null) out.rounds = rounds;
    if (intervalMinutes != null) out.interval_minutes = intervalMinutes;
    if (intervalRounds != null) out.interval_rounds = intervalRounds;
    if (teamSize != null) out.team_size = teamSize;
    if (repSchemes.length > 0) out.rep_schemes = repSchemes;
    if (notes.length > 0) out.notes = notes;
    out.blocks = blocks;
    if (itemCount === 0) {
      warnings.push({ id: wodId, reason: "wod sin ejercicios" });
    }
    return out;
  }

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    let m;

    const hdr = parseHeader(line);
    if (hdr) {
      const hasContent = itemCount > 0 || type !== null;
      if (hasContent) {
        if (!lastWasRest) {
          warnings.push({
            id: wodId,
            line,
            reason: "cabecera intermedia sin rest previo: se fusiona como segmento",
          });
        }
        startSegment(hdr);
        continue;
      }
      type = hdr.type;
      duration = hdr.duration;
      rounds = hdr.rounds;
      teamSize = hdr.team_size;
      if (hdr.interval_minutes != null) intervalMinutes = hdr.interval_minutes;
      if (hdr.interval_rounds != null) intervalRounds = hdr.interval_rounds;
      continue;
    }

    if ((m = line.match(/^\*+\s*(.+)$/))) {
      notes.push(m[1].trim());
      continue;
    }

    if ((m = line.match(/^(\d+)\s*(seconds?|minutes?)\s+rest!?$/i))) {
      flush();
      pendingScheme = null;
      blocks.push({
        label: "rest",
        rest: true,
        seconds: secondsOf(num(m[1]), m[2]),
        items: [],
      });
      lastWasRest = true;
      continue;
    }

    if ((m = line.match(/^rest\s+(\d+)\s*(seconds?|minutes?)!?$/i))) {
      flush();
      pendingScheme = null;
      blocks.push({
        label: "rest",
        rest: true,
        seconds: secondsOf(num(m[1]), m[2]),
        items: [],
      });
      lastWasRest = true;
      continue;
    }

    if (/^rest$/i.test(line)) {
      flush();
      pendingScheme = null;
      blocks.push({ label: "rest", rest: true, items: [] });
      lastWasRest = true;
      continue;
    }

    if ((m = line.match(/^cash\s+(in|out):\s*(.+)$/i))) {
      flush();
      pendingScheme = null;
      curBlock = { label: `cash_${m[1].toLowerCase()}`, items: [] };
      curBlock.items.push(parseItem(m[2]));
      itemCount++;
      lastWasRest = false;
      continue;
    }

    if ((m = line.match(/^then\s+(.+)$/i))) {
      flush();
      pendingScheme = null;
      const r = m[1].match(/^(\d+)\s+rounds?$/i);
      const rt = m[1].match(/^(\d+)\s*(seconds?|minutes?)\s+rest$/i);
      if (r) {
        curBlock = { label: "then", rounds: num(r[1]), items: [] };
        lastWasRest = false;
      } else if (rt) {
        blocks.push({
          label: "rest",
          rest: true,
          seconds: secondsOf(num(rt[1]), rt[2]),
          items: [],
        });
        curBlock = null;
        lastWasRest = true;
      } else if (/^amrap$/i.test(m[1])) {
        curBlock = { label: "then", items: [] };
        lastWasRest = false;
      } else {
        curBlock = { label: "then", items: [parseItem(m[1])] };
        itemCount++;
        lastWasRest = false;
      }
      continue;
    }

    if ((m = line.match(/^min\s+(\d+):\s*(.+)$/i))) {
      flush();
      pendingScheme = null;
      curBlock = { label: `min_${num(m[1])}`, items: [] };
      const body = m[2].replace(/!+$/, "").trim();
      if (/^rest$/i.test(body)) curBlock.rest = true;
      else {
        curBlock.items.push(parseItem(body));
        itemCount++;
      }
      lastWasRest = false;
      continue;
    }

    if (/^in the remaining time$/i.test(line)) {
      flush();
      pendingScheme = null;
      curBlock = { label: "remaining_time", items: [] };
      lastWasRest = false;
      continue;
    }

    const sc = parseScheme(line);
    if (sc) {
      pendingScheme = sc.scheme;
      repSchemes.push(sc.scheme);
      if (sc.inline) {
        const item = parseItem(sc.inline);
        item.scheme = sc.scheme;
        openWork().items.push(item);
        itemCount++;
      }
      continue;
    }

    const item = parseItem(line);
    if (!item.exercise) {
      warnings.push({ id: wodId, line, reason: "línea vacía tras limpiar" });
      continue;
    }
    if (pendingScheme) item.scheme = pendingScheme;
    openWork().items.push(item);
    itemCount++;
  }

  return [finish()];
}

async function main() {
  const raw = readFileSync(SRC, "utf8").replace(/^\uFEFF/, "");
  const lines = raw.split(/\r?\n/);
  const chunks = splitChunks(lines);
  const separatorCount = lines.filter((l) => l.trim() === "|").length;

  const state = { warnings: [], nextId: 1 };
  const wods = [];
  for (const chunk of chunks) wods.push(...parseChunk(chunk, state));

  const byType = {};
  for (const w of wods) {
    const key = w.type ?? "desconocido";
    byType[key] = (byType[key] ?? 0) + 1;
  }
  const totalItems = wods.reduce(
    (acc, w) => acc + w.blocks.reduce((a, b) => a + b.items.length, 0),
    0,
  );

  mkdirSync(OUT_DIR, { recursive: true });
  let json = JSON.stringify(wods, null, 2);
  if (Buffer.byteLength(json, "utf8") > 15 * 1024 * 1024) {
    json = JSON.stringify(wods);
  }
  writeFileSync(OUT_FILE, json, "utf8");

  console.log(`WODs en txt (separadores '|'): ${separatorCount}`);
  console.log(`WODs parseados: ${wods.length}`);
  console.log(`Items de ejercicio totales: ${totalItems}`);
  console.log("Por tipo:", JSON.stringify(byType));
  console.log(
    `Salida: ${OUT_FILE} (${(Buffer.byteLength(json, "utf8") / 1024 / 1024).toFixed(2)} MB)`,
  );

  if (state.warnings.length > 0) {
    console.warn(`\nWarnings (${state.warnings.length}):`);
    for (const w of state.warnings) {
      console.warn(`  - wod ${w.id}: ${w.reason}${w.line ? ` | "${w.line}"` : ""}`);
    }
  } else {
    console.log("\nSin warnings.");
  }
}

main();

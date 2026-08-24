const MAX_PREFIX = {
  reps: "max rep",
  calories: "max cal",
  meters: "max mt",
  steps: "max steps",
};

const BLOCK_LABELS = {
  cash_in: "Cash in",
  cash_out: "Cash out",
  remaining_time: "En el tiempo restante",
};

export function formatWodTipo(wod) {
  switch (wod.type) {
    case "amrap":
      return `AMRAP · ${wod.duration ?? "?"} min`;
    case "rounds_for_time":
      return `${wod.rounds ?? "?"} rondas for time${
        wod.duration ? ` · cap ${wod.duration} min` : ""
      }`;
    case "for_time":
      return `For Time${wod.duration ? ` · cap ${wod.duration} min` : ""}`;
    case "emom":
      return `EMOM · ${wod.duration ?? "?"} min`;
    case "intervals":
      return `Every ${wod.interval_minutes} min × ${wod.interval_rounds} rondas`;
    default:
      return "WOD";
  }
}

function formatItem(item) {
  const prefixParts = [];

  if (item.max_rep) {
    prefixParts.push(MAX_PREFIX[item.unit] ?? "max rep");
  }
  if (item.reps != null) {
    prefixParts.push(String(item.reps));
  } else if (item.distance_m != null) {
    prefixParts.push(
      Array.isArray(item.distance_m)
        ? `${item.distance_m.join("-")} mt`
        : `${item.distance_m} mt`,
    );
  } else if (item.seconds != null && !item.max_rep) {
    prefixParts.push(`${item.seconds} seconds`);
  }

  let text = [...prefixParts, item.exercise].join(" ");

  if (item.max_rep && item.seconds != null) {
    text +=
      item.seconds % 60 === 0 ? ` · ${item.seconds / 60} min` : ` · ${item.seconds} s`;
  }

  if (item.scheme) {
    text =
      !item.reps && !item.distance_m && !item.seconds && !item.max_rep
        ? `${item.scheme} ${text}`
        : `${text} (${item.scheme})`;
  }

  return text;
}

function formatBlockLabel(block) {
  if (block.label === "then") {
    return block.rounds != null
      ? `Then · ${block.rounds} rondas`
      : "Then";
  }
  if (block.label?.startsWith("min_")) {
    return `Minuto ${block.label.slice(4)}`;
  }
  return BLOCK_LABELS[block.label] ?? null;
}

export function formatWodSecciones(wod) {
  const secciones = [];

  for (const block of wod.blocks ?? []) {
    if (block.rest) {
      secciones.push({
        label: null,
        lines: [
          block.seconds
            ? `— Descanso ${Math.round(block.seconds / 60)} min —`
            : "— Descanso —",
        ],
      });
      continue;
    }

    secciones.push({
      label: formatBlockLabel(block),
      lines: (block.items ?? []).map(formatItem),
    });
  }

  return secciones.filter((s) => s.lines.length > 0 || s.label);
}

const rpeTable = [
  { reps: 1, rpe: 10, percentage: 100 },
  { reps: 2, rpe: 9.5, percentage: 95 },
  { reps: 3, rpe: 9, percentage: 92 },
  { reps: 4, rpe: 8.5, percentage: 89 },
  { reps: 5, rpe: 8, percentage: 86 },
  { reps: 6, rpe: 7.5, percentage: 83 },
  { reps: 7, rpe: 7, percentage: 80 },
  { reps: 8, rpe: 6.5, percentage: 75 },
  { reps: 9, rpe: 6, percentage: 75 },
];

export function extraerRPE(observaciones) {
  if (!observaciones) return null;
  const match = observaciones.match(/RPE(\d+)/i);
  return match ? parseInt(match[1], 10) : null;
}

export function calcularPesoSugerido(rm, repeticiones, rpe) {
  if (!rm || !repeticiones || !rpe) return null;

  const reps = parseInt(repeticiones, 10);
  if (isNaN(reps) || reps < 1) return null;

  const targetRpe = parseFloat(rpe);
  if (isNaN(targetRpe) || targetRpe < 6 || targetRpe > 10) return null;

  let lower = rpeTable[0];
  let upper = rpeTable[rpeTable.length - 1];

  for (let i = 0; i < rpeTable.length - 1; i++) {
    if (targetRpe >= rpeTable[i].rpe && targetRpe <= rpeTable[i + 1].rpe) {
      lower = rpeTable[i];
      upper = rpeTable[i + 1];
      break;
    }
  }

  let percentage;
  if (lower.rpe === upper.rpe) {
    percentage = lower.percentage;
  } else {
    const ratio = (targetRpe - lower.rpe) / (upper.rpe - lower.rpe);
    percentage =
      lower.percentage + ratio * (upper.percentage - lower.percentage);
  }

  let repsLower = rpeTable[0];
  let repsUpper = rpeTable[rpeTable.length - 1];

  for (let i = 0; i < rpeTable.length - 1; i++) {
    if (reps >= rpeTable[i].reps && reps <= rpeTable[i + 1].reps) {
      repsLower = rpeTable[i];
      repsUpper = rpeTable[i + 1];
      break;
    }
  }

  let repsPercentage;
  if (repsLower.reps === repsUpper.reps) {
    repsPercentage = repsLower.percentage;
  } else {
    const ratio = (reps - repsLower.reps) / (repsUpper.reps - repsLower.reps);
    repsPercentage =
      repsLower.percentage +
      ratio * (repsUpper.percentage - repsLower.percentage);
  }

  const finalPercentage = (percentage * repsPercentage) / 100;
  const pesoSugerido = (rm * finalPercentage) / 100;

  return Math.round(pesoSugerido * 2) / 2;
}

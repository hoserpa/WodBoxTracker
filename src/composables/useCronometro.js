import { computed, onUnmounted, ref, unref } from "vue";

export function useCronometro(segundosIniciales) {
  const estado = ref("idle");
  const transcurrido = ref(0);

  let intervalo = null;
  let marcaTiempo = null;
  let acumuladoMs = 0;

  const descendente = computed(() => unref(segundosIniciales) != null);

  const segundosActuales = computed(() => {
    if (!descendente.value) return Math.floor(transcurrido.value);
    const restante = unref(segundosIniciales) - transcurrido.value;
    return Math.max(0, Math.ceil(restante));
  });

  const display = computed(() => {
    const s = segundosActuales.value;
    const h = Math.floor(s / 3600);
    const m = Math.floor((s % 3600) / 60);
    const sec = s % 60;
    const pad = (n) => String(n).padStart(2, "0");
    return h > 0 ? `${h}:${pad(m)}:${pad(sec)}` : `${pad(m)}:${pad(sec)}`;
  });

  const pararIntervalo = () => {
    if (intervalo) {
      clearInterval(intervalo);
      intervalo = null;
    }
  };

  function iniciar() {
    if (estado.value === "running" || estado.value === "finished") return;
    marcaTiempo = Date.now();
    estado.value = "running";
    intervalo = setInterval(() => {
      transcurrido.value = (acumuladoMs + (Date.now() - marcaTiempo)) / 1000;
      if (descendente.value && transcurrido.value >= unref(segundosIniciales)) {
        transcurrido.value = unref(segundosIniciales);
        pararIntervalo();
        estado.value = "finished";
      }
    }, 250);
  }

  function pausar() {
    if (estado.value !== "running") return;
    pararIntervalo();
    acumuladoMs += Date.now() - marcaTiempo;
    marcaTiempo = null;
    estado.value = "paused";
  }

  function detener() {
    if (estado.value === "idle") return;
    pararIntervalo();
    marcaTiempo = null;
    acumuladoMs = 0;
    transcurrido.value = 0;
    estado.value = "idle";
  }

  onUnmounted(detener);

  return { display, estado, iniciar, pausar, detener };
}

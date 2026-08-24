<script setup>
import { computed } from "vue";
import { useRouter } from "vue-router";
import { useWodDelDia } from "@/composables/useWodDelDia";
import { useCronometro } from "@/composables/useCronometro";
import { formatWodTipo, formatWodSecciones } from "@/utils/wodFormatter";
import "dseg/css/dseg.css";

const router = useRouter();
const { wod, isLoading, error } = useWodDelDia();

const segundosIniciales = computed(() =>
  wod.value?.duration != null ? wod.value.duration * 60 : null,
);

const { display, estado, iniciar, pausar, detener } =
  useCronometro(segundosIniciales);

const tipo = computed(() => (wod.value ? formatWodTipo(wod.value) : ""));
const secciones = computed(() => (wod.value ? formatWodSecciones(wod.value) : []));

const finalizado = computed(() => estado.value === "finished");
const corriendo = computed(() => estado.value === "running");
const enMarcha = computed(() => estado.value !== "idle");

const modoCronometro = computed(() =>
  segundosIniciales.value != null ? "Timecap" : "Tiempo",
);

const volver = () => router.push("/");
</script>

<template>
  <div class="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900">
    <header class="bg-white/10 backdrop-blur-md border-b border-white/10">
      <div class="max-w-3xl mx-auto py-4 px-4 flex items-center gap-3">
        <button
          @click="volver"
          class="p-2 rounded-xl bg-white/10 hover:bg-white/20 transition-all duration-300"
          aria-label="Volver"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="h-6 w-6 text-white"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M15 19l-7-7 7-7"
            />
          </svg>
        </button>
        <h1 class="text-xl font-bold text-white">WOD del día</h1>
      </div>
    </header>

    <main class="max-w-3xl mx-auto py-8 px-4 flex flex-col gap-8">
      <div v-if="isLoading" class="flex justify-center py-24">
        <div
          class="animate-spin rounded-full h-12 w-12 border-4 border-emerald-500 border-t-transparent"
        ></div>
      </div>

      <div
        v-else-if="error"
        class="bg-red-500/20 border border-red-500/50 text-red-200 px-6 py-4 rounded-2xl backdrop-blur-sm text-center"
      >
        No se pudo cargar el WOD del día
      </div>

      <template v-else-if="wod">
        <div
          class="bg-black border border-white/10 rounded-2xl px-4 py-10 sm:py-14 text-center shadow-2xl shadow-red-500/10"
        >
          <p
            :class="[
              'font-dseg select-none leading-none text-red-500',
              finalizado ? 'animate-pulse' : '',
              'text-[22vw] sm:text-7xl md:text-8xl',
            ]"
          >
            {{ display }}
          </p>
          <p class="mt-4 text-xs font-bold uppercase tracking-[0.3em] text-white/40">
            {{ modoCronometro }}
          </p>
        </div>

        <div class="flex justify-center gap-6">
          <button
            @click="iniciar"
            :disabled="corriendo || finalizado"
            aria-label="Iniciar"
            class="w-16 h-16 rounded-full bg-emerald-500 hover:bg-emerald-600 disabled:opacity-30 disabled:hover:bg-emerald-500 disabled:cursor-not-allowed flex items-center justify-center shadow-lg shadow-emerald-500/30 transition-all duration-300 active:scale-95"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="h-7 w-7 text-white ml-1"
              fill="currentColor"
              viewBox="0 0 24 24"
            >
              <path d="M8 5v14l11-7z" />
            </svg>
          </button>

          <button
            @click="pausar"
            :disabled="!corriendo"
            aria-label="Pausar"
            class="w-16 h-16 rounded-full bg-amber-500 hover:bg-amber-600 disabled:opacity-30 disabled:hover:bg-amber-500 disabled:cursor-not-allowed flex items-center justify-center shadow-lg shadow-amber-500/30 transition-all duration-300 active:scale-95"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="h-7 w-7 text-white"
              fill="currentColor"
              viewBox="0 0 24 24"
            >
              <path d="M6 5h4v14H6zM14 5h4v14h-4z" />
            </svg>
          </button>

          <button
            @click="detener"
            :disabled="!enMarcha && !finalizado"
            aria-label="Detener"
            class="w-16 h-16 rounded-full bg-red-500 hover:bg-red-600 disabled:opacity-30 disabled:hover:bg-red-500 disabled:cursor-not-allowed flex items-center justify-center shadow-lg shadow-red-500/30 transition-all duration-300 active:scale-95"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="h-6 w-6 text-white"
              fill="currentColor"
              viewBox="0 0 24 24"
            >
              <rect x="6" y="6" width="12" height="12" rx="1" />
            </svg>
          </button>
        </div>

        <div
          class="rounded-2xl bg-white/10 backdrop-blur-sm border border-white/10 p-6"
        >
          <p
            class="inline-block mb-4 text-xs font-bold uppercase tracking-wide text-emerald-300 bg-emerald-500/20 px-2 py-0.5 rounded-md"
          >
            {{ tipo }}
          </p>

          <div v-for="(seccion, i) in secciones" :key="i" :class="i > 0 ? 'mt-4' : ''">
            <p
              v-if="seccion.label"
              class="text-emerald-300/90 text-xs font-bold uppercase tracking-wide mb-1"
            >
              {{ seccion.label }}
            </p>
            <p
              v-for="(linea, j) in seccion.lines"
              :key="j"
              class="text-white/80 text-sm"
            >
              {{ linea }}
            </p>
          </div>
        </div>
      </template>
    </main>
  </div>
</template>

<style scoped>
.font-dseg {
  font-family: "DSEG7-Classic", monospace;
  font-weight: bold;
  font-style: italic;
  text-shadow:
    0 0 12px rgba(239, 68, 68, 0.55),
    0 0 45px rgba(239, 68, 68, 0.25);
}
</style>

<script setup>
import { computed } from "vue";
import { useRouter } from "vue-router";
import { useWodDelDia } from "@/composables/useWodDelDia";
import { formatWodTipo, formatWodSecciones } from "@/utils/wodFormatter";

const router = useRouter();
const { wod, isLoading, error } = useWodDelDia();

const irAlWod = () => router.push("/wod");

const tipo = computed(() => (wod.value ? formatWodTipo(wod.value) : ""));
const secciones = computed(() => (wod.value ? formatWodSecciones(wod.value) : []));
</script>

<template>
  <button
    type="button"
    @click="irAlWod"
    class="group relative overflow-hidden rounded-2xl bg-white/10 backdrop-blur-sm border border-white/10 p-6 text-left transition-all duration-300 hover:bg-white/20 hover:scale-[1.01] hover:shadow-2xl hover:shadow-emerald-500/20 w-full"
  >
    <div
      class="absolute inset-0 bg-gradient-to-br opacity-0 group-hover:opacity-100 transition-opacity duration-500 from-emerald-500 to-teal-600"
    ></div>

    <div v-if="isLoading" class="relative flex justify-center py-10">
      <div
        class="animate-spin rounded-full h-10 w-10 border-4 border-emerald-500 border-t-transparent"
      ></div>
    </div>

    <div
      v-else-if="error"
      class="relative bg-red-500/20 border border-red-500/50 text-red-200 px-6 py-4 rounded-2xl"
    >
      No se pudo cargar el WOD del día
    </div>

    <div v-else-if="wod" class="relative">
      <div class="flex items-center gap-3 mb-3">
        <div
          class="w-12 h-12 rounded-xl bg-gradient-to-br from-emerald-500 to-teal-600 flex items-center justify-center shadow-lg shrink-0"
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
              d="M13 10V3L4 14h7v7l9-11h-7z"
            />
          </svg>
        </div>
        <div>
          <h3 class="text-xl font-bold text-white">WOD del día</h3>
          <p
            class="inline-block mt-1 text-xs font-bold uppercase tracking-wide text-emerald-300 bg-emerald-500/20 px-2 py-0.5 rounded-md"
          >
            {{ tipo }}
          </p>
        </div>
      </div>

      <div
        v-for="(seccion, i) in secciones"
        :key="i"
        :class="i > 0 ? 'mt-3' : ''"
      >
        <p
          v-if="seccion.label"
          class="text-emerald-300/90 text-xs font-bold uppercase tracking-wide mb-1"
        >
          {{ seccion.label }}
        </p>
        <p v-for="(linea, j) in seccion.lines" :key="j" class="text-white/80 text-sm">
          {{ linea }}
        </p>
      </div>
    </div>
  </button>
</template>

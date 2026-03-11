<script setup>
/* global confirm setTimeout */
import { ref, computed, onMounted } from "vue";
import { useRouter } from "vue-router";
import { halterofiliaService } from "@/services/halterofilia_entrenamiento";

const router = useRouter();
const loading = ref(true);
const error = ref("");
const eliminarLoading = ref(null);
const mensajeExito = ref("");

const fechaInicio = ref("");
const fechaFin = ref("");
const entrenamientos = ref([]);

const goBack = () => {
  router.push("/halterofilia");
};

const formatearFecha = (fecha) => {
  if (!fecha) return "";
  const date = new Date(fecha);
  return date.toLocaleDateString("es-ES", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  });
};

const filteredEntrenamientos = computed(() => {
  if (!fechaInicio.value && !fechaFin.value) {
    return entrenamientos.value;
  }

  return entrenamientos.value.filter((ent) => {
    const fechaEnt = new Date(ent.fecha);
    fechaEnt.setHours(0, 0, 0, 0);

    let incluir = true;

    if (fechaInicio.value) {
      const inicio = new Date(fechaInicio.value);
      inicio.setHours(0, 0, 0, 0);
      incluir = incluir && fechaEnt >= inicio;
    }

    if (fechaFin.value) {
      const fin = new Date(fechaFin.value);
      fin.setHours(23, 59, 59, 999);
      incluir = incluir && fechaEnt <= fin;
    }

    return incluir;
  });
});

const eliminarEntrenamiento = async (id) => {
  if (!confirm("¿Estás seguro de que quieres eliminar este entrenamiento?")) {
    return;
  }

  try {
    eliminarLoading.value = id;
    await halterofiliaService.delete(id);
    mensajeExito.value = "Entrenamiento eliminado correctamente";
    setTimeout(() => {
      mensajeExito.value = "";
    }, 3000);
    await cargarEntrenamientos();
  } catch (err) {
    error.value = "Error al eliminar entrenamiento";
    console.error(err);
  } finally {
    eliminarLoading.value = null;
  }
};

const cargarEntrenamientos = async () => {
  try {
    loading.value = true;
    error.value = "";
    const data = await halterofiliaService.getAll();
    entrenamientos.value = data;
  } catch (err) {
    error.value = "Error al cargar entrenamientos";
    console.error(err);
  } finally {
    loading.value = false;
  }
};

onMounted(async () => {
  await cargarEntrenamientos();
});
</script>

<template>
  <div
    class="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900"
  >
    <header class="bg-white/10 backdrop-blur-md border-b border-white/10">
      <div class="max-w-7xl mx-auto py-5 px-4">
        <h1 class="text-2xl font-bold text-white flex items-center gap-3">
          <img
            src="/icon.png"
            alt="WodBox"
            class="h-10 w-10 rounded-xl shadow-lg"
          />
          <span
            class="bg-gradient-to-r from-violet-400 to-cyan-400 bg-clip-text text-transparent"
          >
            Box Tracker
          </span>
        </h1>
      </div>
    </header>

    <main class="max-w-7xl mx-auto py-8 px-4">
      <button
        @click="goBack"
        class="flex items-center gap-2 text-white/60 hover:text-white mb-6 transition-colors"
      >
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="h-5 w-5"
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
        Volver
      </button>

      <div class="flex items-center gap-3 mb-8">
        <div
          class="w-1 h-8 bg-gradient-to-b from-amber-500 to-orange-500 rounded-full"
        ></div>
        <h2 class="text-2xl font-bold text-white">Historial Halterofilia</h2>
      </div>

      <div
        v-if="mensajeExito"
        class="bg-green-500/20 border border-green-500/50 text-green-200 px-4 py-3 rounded-lg mb-6"
      >
        {{ mensajeExito }}
      </div>

      <div
        class="bg-white/10 backdrop-blur-sm border border-white/10 rounded-2xl p-4 mb-6"
      >
        <h3 class="text-white font-medium mb-4">Filtrar por fecha</h3>
        <div class="grid grid-cols-2 gap-4">
          <div>
            <label class="block text-white/60 text-sm mb-1">Desde</label>
            <input
              v-model="fechaInicio"
              type="date"
              class="w-full px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white focus:outline-none focus:border-amber-500"
            />
          </div>
          <div>
            <label class="block text-white/60 text-sm mb-1">Hasta</label>
            <input
              v-model="fechaFin"
              type="date"
              class="w-full px-3 py-2 bg-white/10 border border-white/20 rounded-lg text-white focus:outline-none focus:border-amber-500"
            />
          </div>
        </div>
      </div>

      <div v-if="loading" class="flex justify-center py-16">
        <div
          class="animate-spin rounded-full h-12 w-12 border-4 border-amber-500 border-t-transparent"
        ></div>
      </div>

      <div
        v-else-if="filteredEntrenamientos.length === 0"
        class="text-center py-16"
      >
        <p class="text-white/60 text-lg">No hay entrenamientos</p>
      </div>

      <div v-else class="space-y-4">
        <div
          v-for="entrenamiento in filteredEntrenamientos"
          :key="entrenamiento.id"
          class="bg-white/10 backdrop-blur-sm border border-white/10 rounded-2xl p-4"
        >
          <div class="flex items-center justify-between mb-4">
            <div>
              <p class="text-white font-bold">
                {{ formatearFecha(entrenamiento.fecha) }}
              </p>
              <p class="text-white/60 text-sm">
                {{ entrenamiento.ejercicios?.length || 0 }} ejercicios
              </p>
            </div>
            <button
              @click="eliminarEntrenamiento(entrenamiento.id)"
              :disabled="eliminarLoading === entrenamiento.id"
              class="p-2 text-red-400 hover:text-red-300 disabled:opacity-50"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-5 w-5"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
                />
              </svg>
            </button>
          </div>

          <div v-if="entrenamiento.notas" class="mb-3">
            <p class="text-white/60 text-sm italic">
              {{ entrenamiento.notas }}
            </p>
          </div>

          <div class="space-y-3">
            <div
              v-for="ejercicio in entrenamiento.ejercicios"
              :key="ejercicio.id"
              class="bg-white/5 rounded-xl p-3"
            >
              <p class="text-white font-medium text-sm">
                {{ ejercicio.nombre_ejercicio }}
              </p>
              <div class="mt-2 space-y-1">
                <div
                  v-for="ronda in ejercicio.rondas"
                  :key="ronda.id"
                  class="text-white/60 text-xs flex flex-wrap gap-x-2"
                >
                  <span>{{ ronda.repeticiones }} rep</span>
                  <span>x</span>
                  <span>{{ ronda.series }} series</span>
                  <span>@</span>
                  <span>{{ ronda.porcentaje }}%</span>
                  <span class="text-amber-300">({{ ronda.peso }} kg)</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

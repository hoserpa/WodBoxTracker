<script setup>
import { onMounted, ref, computed } from "vue";
import { useRoute, useRouter } from "vue-router";
import { rutinaService } from "@/services/rutina";
import { semanaService } from "@/services/semana";
import { diaService } from "@/services/dia";
import { serieService } from "@/services/serie";

const route = useRoute();
const router = useRouter();

const rutinaId = computed(() => route.params.rutinaId);
const semanaId = computed(() => route.params.semanaId);
const diaId = computed(() => route.params.diaId);

const rutina = ref(null);
const semana = ref(null);
const dia = ref(null);
const series = ref([]);
const loading = ref(true);
const error = ref("");

const tipoLabels = {
  principal: "Ejercicios Principales",
  secundario: "Ejercicios Secundarios",
  calentamiento: "Calentamiento",
  core: "Core",
};

const tiposEnDia = computed(() => {
  const tipos = new Set(series.value.map((s) => s.tipo_ejercicio));
  const orden = ["calentamiento", "principal", "secundario", "core"];
  return orden.filter((t) => tipos.has(t));
});

const ejerciciosPorTipo = computed(() => {
  const grouped = {};
  tiposEnDia.value.forEach((tipo) => {
    const seriesTipo = series.value.filter((s) => s.tipo_ejercicio === tipo);
    const ejercicioMap = {};

    seriesTipo.forEach((s) => {
      const ejId = s.ejercicio_id;
      if (!ejercicioMap[ejId]) {
        ejercicioMap[ejId] = {
          nombre: s.ejercicio?.nombre,
          series: [],
        };
      }
      ejercicioMap[ejId].series.push(s);
    });

    grouped[tipo] = Object.values(ejercicioMap);
  });
  return grouped;
});

const selectedTipo = ref(null);

onMounted(async () => {
  await loadData();
});

const loadData = async () => {
  try {
    loading.value = true;
    error.value = "";

    const [rutinaData, semanaData, diaData, seriesData] = await Promise.all([
      rutinaService.getById(rutinaId.value),
      semanaService.getById(semanaId.value),
      diaService.getById(diaId.value),
      serieService.getByDia(diaId.value),
    ]);

    rutina.value = rutinaData;
    semana.value = semanaData;
    dia.value = diaData;
    series.value = seriesData;
  } catch (err) {
    error.value = "Error al cargar datos";
    console.error(err);
  } finally {
    loading.value = false;
  }
};

const selectTipo = (tipo) => {
  selectedTipo.value = tipo;
};

const goBack = () => {
  if (selectedTipo.value) {
    selectedTipo.value = null;
  } else {
    router.push(`/rutina/${rutinaId.value}/semana/${semanaId.value}`);
  }
};
</script>

<template>
  <div class="min-h-screen bg-gray-100 pb-20">
    <header class="bg-white shadow sticky top-0 z-10">
      <div class="px-4 py-4">
        <button @click="goBack" class="text-indigo-600 font-medium">
          ← Volver
        </button>
        <h1 class="text-xl font-bold text-gray-900 mt-2">
          {{ dia?.nombre || `Día ${dia?.numero}` }}
        </h1>
        <p class="text-sm text-gray-600">
          {{ rutina?.nombre }} - Semana {{ semana?.numero }}
        </p>
      </div>
    </header>

    <main class="p-4">
      <div v-if="loading" class="text-center py-8">
        <p class="text-gray-500">Cargando...</p>
      </div>

      <div
        v-else-if="error"
        class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded"
      >
        {{ error }}
      </div>

      <div v-else>
        <!-- Lista de tipos -->
        <div v-if="!selectedTipo" class="space-y-3">
          <button
            v-for="tipo in tiposEnDia"
            :key="tipo"
            @click="selectTipo(tipo)"
            class="w-full bg-white p-4 rounded-lg shadow text-left hover:bg-gray-50 active:bg-gray-100 transition-colors"
          >
            <h3 class="text-lg font-semibold text-gray-900">
              {{ tipoLabels[tipo] }}
            </h3>
            <p class="text-sm text-gray-500 mt-1">
              {{ ejerciciosPorTipo[tipo]?.length }} ejercicio{{
                ejerciciosPorTipo[tipo]?.length !== 1 ? "s" : ""
              }}
            </p>
          </button>
        </div>

        <!-- Ejercicios del tipo seleccionado -->
        <div v-else>
          <h2 class="text-lg font-bold text-gray-800 mb-4">
            {{ tipoLabels[selectedTipo] }}
          </h2>

          <div class="space-y-4">
            <div
              v-for="ejercicio in ejerciciosPorTipo[selectedTipo]"
              :key="ejercicio.nombre"
              class="bg-white p-4 rounded-lg shadow"
            >
              <h3 class="font-semibold text-gray-900 text-lg">
                {{ ejercicio.nombre }}
              </h3>

              <div class="mt-3 space-y-2">
                <div
                  v-for="serie in ejercicio.series"
                  :key="serie.id"
                  class="flex items-center justify-between bg-gray-50 p-3 rounded"
                >
                  <div class="flex items-center gap-3">
                    <span class="font-bold text-indigo-600 text-lg">
                      {{ serie.series }}x{{ serie.repeticiones }}
                    </span>
                  </div>
                  <div class="text-right">
                    <p v-if="serie.observaciones" class="text-sm text-gray-600">
                      {{ serie.observaciones }}
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

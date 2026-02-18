<script setup>
import { onMounted, ref, computed } from "vue";
import { useRoute, useRouter } from "vue-router";
import { rutinaService } from "@/services/rutina";
import { semanaService } from "@/services/semana";
import { diaService } from "@/services/dia";
import { serieService } from "@/services/serie";
import { registroService } from "@/services/registro";
import { diaCompletadoService } from "@/services/diaCompletado";

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
const registros = ref({});
const saving = ref({});
const completado = ref(false);

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
    const seriesTipo = series.value
      .filter((s) => s.tipo_ejercicio === tipo)
      .sort((a, b) => a.orden - b.orden);

    const ejercicioArray = [];
    const ejercicioMap = {};

    seriesTipo.forEach((s) => {
      const ejId = s.ejercicio_id;
      if (!ejercicioMap[ejId]) {
        const newEjercicio = {
          nombre: s.ejercicio?.nombre,
          series: [],
        };
        ejercicioMap[ejId] = newEjercicio;
        ejercicioArray.push(newEjercicio);
      }
      ejercicioMap[ejId].series.push(s);
    });

    grouped[tipo] = ejercicioArray;
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

    if (seriesData.length > 0) {
      const serieIds = seriesData.map((s) => s.id);
      const registrosData = await registroService.getBySeries(serieIds);
      registros.value = registrosData;
    }

    const completadoData = await diaCompletadoService.getByDia(diaId.value);
    completado.value = !!completadoData;
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

const canRecordWeight = (tipo) => {
  return tipo === "principal" || tipo === "secundario";
};

const getRegistro = (serieId) => {
  return registros.value[serieId];
};

const saveWeight = async (serieId, peso) => {
  if (!peso || isNaN(peso)) return;

  saving.value[serieId] = true;
  try {
    const existing = registros.value[serieId];
    if (existing) {
      const updated = await registroService.update(existing.id, peso);
      registros.value[serieId] = updated;
    } else {
      const saved = await registroService.save(serieId, peso);
      registros.value[serieId] = saved;
    }
  } catch (err) {
    console.error("Error saving weight:", err);
  } finally {
    saving.value[serieId] = false;
  }
};

const toggleCompletado = async () => {
  try {
    await diaCompletadoService.toggle(diaId.value);
    completado.value = !completado.value;
  } catch (err) {
    console.error("Error toggling completion:", err);
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
        <div class="flex items-center justify-between mt-2">
          <h1 class="text-xl font-bold text-gray-900">
            {{ dia?.nombre || `Día ${dia?.numero}` }}
          </h1>
          <button
            @click="toggleCompletado"
            class="flex items-center gap-2 px-3 py-1.5 rounded-full text-sm font-medium border"
            :class="
              completado
                ? 'bg-green-100 border-green-300 text-green-700'
                : 'bg-gray-100 border-gray-300 text-gray-500 hover:bg-gray-200'
            "
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="h-5 w-5"
              viewBox="0 0 20 20"
              fill="currentColor"
            >
              <path
                fill-rule="evenodd"
                d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z"
                clip-rule="evenodd"
              />
            </svg>
            {{ completado ? "Completado" : "Marcar hecho" }}
          </button>
        </div>
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
              <h3
                class="font-semibold text-gray-900 text-lg flex items-center gap-2"
              >
                {{ ejercicio.nombre }}
                <a
                  v-if="ejercicio.series[0]?.ejercicio?.url"
                  :href="ejercicio.series[0].ejercicio.url"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="text-indigo-600 hover:text-indigo-800"
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
                      d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"
                    />
                  </svg>
                </a>
              </h3>

              <div class="mt-3 space-y-2">
                <div
                  v-for="serie in ejercicio.series"
                  :key="serie.id"
                  class="bg-gray-50 p-3 rounded"
                >
                  <div class="flex items-center justify-between">
                    <div class="flex items-center gap-3">
                      <span class="font-bold text-indigo-600 text-lg">
                        {{ serie.series }}x{{ serie.repeticiones }}
                      </span>
                    </div>
                    <div
                      v-if="canRecordWeight(selectedTipo)"
                      class="flex items-center gap-2"
                    >
                      <input
                        type="number"
                        step="0.5"
                        :placeholder="getRegistro(serie.id)?.peso || 'kg'"
                        class="w-20 px-2 py-1 text-center border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-indigo-500"
                        @change="
                          (e) =>
                            saveWeight(serie.id, parseFloat(e.target.value))
                        "
                      />
                      <span class="text-sm text-gray-500">kg</span>
                    </div>
                  </div>
                  <p
                    v-if="serie.observaciones"
                    class="text-sm text-gray-600 mt-1"
                  >
                    {{ serie.observaciones }}
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

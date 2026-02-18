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

const tipoColors = {
  principal: "from-violet-500 to-purple-600",
  secundario: "from-cyan-500 to-blue-600",
  calentamiento: "from-orange-500 to-amber-600",
  core: "from-rose-500 to-red-600",
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
  <div
    class="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 pb-24"
  >
    <header
      class="bg-white/10 backdrop-blur-md border-b border-white/10 sticky top-0 z-20"
    >
      <div class="px-4 py-4">
        <button
          @click="goBack"
          class="text-violet-400 font-medium hover:text-violet-300 transition-colors flex items-center gap-2 mb-3"
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
        <div class="flex items-center justify-between">
          <div>
            <h1 class="text-xl font-bold text-white">
              {{ dia?.nombre || `Día ${dia?.numero}` }}
            </h1>
            <p class="text-white/50 text-sm">
              {{ rutina?.nombre }} - Semana {{ semana?.numero }}
            </p>
          </div>
          <button
            @click="toggleCompletado"
            class="flex items-center gap-2 px-4 py-2 rounded-full text-sm font-bold transition-all duration-300"
            :class="
              completado
                ? 'bg-gradient-to-r from-green-500 to-emerald-600 text-white shadow-lg shadow-green-500/30'
                : 'bg-white/10 border border-white/20 text-white/70 hover:bg-white/20'
            "
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
                d="M5 13l4 4L19 7"
              />
            </svg>
            {{ completado ? "Hecho" : "Completar" }}
          </button>
        </div>
      </div>
    </header>

    <main class="p-4 max-w-3xl mx-auto">
      <div v-if="loading" class="flex justify-center py-16">
        <div
          class="animate-spin rounded-full h-12 w-12 border-4 border-violet-500 border-t-transparent"
        ></div>
      </div>

      <div
        v-else-if="error"
        class="bg-red-500/20 border border-red-500/50 text-red-200 px-6 py-4 rounded-2xl backdrop-blur-sm"
      >
        {{ error }}
      </div>

      <div v-else>
        <div v-if="!selectedTipo" class="space-y-4">
          <button
            v-for="tipo in tiposEnDia"
            :key="tipo"
            @click="selectTipo(tipo)"
            class="w-full group relative overflow-hidden rounded-2xl bg-white/10 backdrop-blur-sm border border-white/10 p-5 text-left transition-all duration-300 hover:scale-[1.02] hover:shadow-2xl"
          >
            <div
              :class="[
                'absolute inset-0 bg-gradient-to-br opacity-0 group-hover:opacity-100 transition-opacity duration-500',
                tipoColors[tipo],
              ]"
            ></div>
            <div class="relative flex items-center justify-between">
              <div>
                <h3 class="text-xl font-bold text-white">
                  {{ tipoLabels[tipo] }}
                </h3>
                <p class="text-white/60 text-sm mt-1">
                  {{ ejerciciosPorTipo[tipo]?.length }} ejercicio{{
                    ejerciciosPorTipo[tipo]?.length !== 1 ? "s" : ""
                  }}
                </p>
              </div>
              <div
                :class="[
                  'w-12 h-12 rounded-xl bg-gradient-to-br flex items-center justify-center shadow-lg',
                  tipoColors[tipo],
                ]"
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
                    d="M9 5l7 7-7 7"
                  />
                </svg>
              </div>
            </div>
          </button>
        </div>

        <div v-else>
          <button
            @click="selectedTipo = null"
            class="flex items-center gap-2 text-violet-400 font-medium mb-4 hover:text-violet-300 transition-colors"
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

          <div
            :class="[
              'inline-block px-4 py-2 rounded-xl bg-gradient-to-r mb-4',
              tipoColors[selectedTipo],
            ]"
          >
            <h2 class="text-lg font-bold text-white">
              {{ tipoLabels[selectedTipo] }}
            </h2>
          </div>

          <div class="space-y-4">
            <div
              v-for="ejercicio in ejerciciosPorTipo[selectedTipo]"
              :key="ejercicio.nombre"
              class="rounded-2xl bg-white/10 backdrop-blur-sm border border-white/10 overflow-hidden"
            >
              <div class="p-4 border-b border-white/10">
                <h3
                  class="font-bold text-white text-lg flex items-center gap-2"
                >
                  {{ ejercicio.nombre }}
                  <a
                    v-if="ejercicio.series[0]?.ejercicio?.url"
                    :href="ejercicio.series[0].ejercicio.url"
                    target="_blank"
                    rel="noopener noreferrer"
                    class="text-violet-400 hover:text-violet-300 transition-colors"
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
              </div>

              <div class="divide-y divide-white/10">
                <div
                  v-for="serie in ejercicio.series"
                  :key="serie.id"
                  class="p-3 flex items-center justify-between gap-2"
                >
                  <div class="flex items-center gap-2 min-w-0">
                    <div
                      class="w-auto h-10 px-3 rounded-xl bg-gradient-to-br from-violet-500 to-purple-600 flex items-center justify-center shadow-lg shrink-0"
                    >
                      <span
                        class="text-white font-bold text-sm whitespace-nowrap"
                        >{{ serie.series }}x{{ serie.repeticiones }}</span
                      >
                    </div>
                    <p
                      v-if="serie.observaciones"
                      class="text-white/50 text-xs truncate"
                    >
                      {{ serie.observaciones }}
                    </p>
                  </div>
                  <div
                    v-if="canRecordWeight(selectedTipo)"
                    class="flex items-center gap-2 shrink-0"
                  >
                    <input
                      type="number"
                      step="0.5"
                      :placeholder="
                        getRegistro(serie.id)?.peso
                          ? `${getRegistro(serie.id).peso} kg`
                          : 'kg'
                      "
                      class="w-20 px-2 py-1.5 text-center text-sm bg-white/10 border border-white/20 rounded-lg text-white placeholder-white/40 focus:outline-none focus:ring-2 focus:ring-violet-500"
                      @change="
                        (e) => saveWeight(serie.id, parseFloat(e.target.value))
                      "
                    />
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

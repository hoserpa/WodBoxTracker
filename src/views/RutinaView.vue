<script setup>
import { onMounted, ref, computed } from "vue";
import { useRoute, useRouter } from "vue-router";
import { rutinaService } from "@/services/rutina";
import { semanaService } from "@/services/semana";
import { diaCompletadoService } from "@/services/diaCompletado";

const route = useRoute();
const router = useRouter();

const rutinaId = computed(() => route.params.rutinaId);
const rutina = ref(null);
const semanas = ref([]);
const loading = ref(true);
const error = ref("");
const semanasCompletas = ref(new Set());

onMounted(async () => {
  await loadData();
});

const loadData = async () => {
  try {
    loading.value = true;
    error.value = "";

    const [rutinaData, semanasData] = await Promise.all([
      rutinaService.getById(rutinaId.value),
      semanaService.getByRutina(rutinaId.value),
    ]);

    rutina.value = rutinaData;
    semanas.value = semanasData;

    const completados = await diaCompletadoService.getByRutina(rutinaId.value);

    const completadosPorSemana = {};
    const diasPorSemana = {};

    completados.forEach((d) => {
      const semana = semanasData.find((s) => s.id === d.semana_id);
      if (semana) {
        if (!completadosPorSemana[semana.numero]) {
          completadosPorSemana[semana.numero] = 0;
        }
        completadosPorSemana[semana.numero]++;

        if (!diasPorSemana[semana.numero]) {
          diasPorSemana[semana.numero] = new Set();
        }
        diasPorSemana[semana.numero].add(d.dia_id);
      }
    });

    semanasData.forEach((s) => {
      const diasEnSemana = diasPorSemana[s.numero]?.size || 0;
      if (completadosPorSemana[s.numero] === diasEnSemana && diasEnSemana > 0) {
        semanasCompletas.value.add(s.id);
      }
    });
  } catch (err) {
    error.value = "Error al cargar datos";
    console.error(err);
  } finally {
    loading.value = false;
  }
};

const selectSemana = (semanaId) => {
  router.push(`/rutina/${rutinaId.value}/semana/${semanaId}`);
};

const goBack = () => {
  router.push("/");
};

const getSemanaGradient = (index) => {
  const gradients = [
    "from-violet-500 to-purple-600",
    "from-cyan-500 to-blue-600",
    "from-orange-500 to-red-500",
    "from-green-500 to-teal-600",
    "from-pink-500 to-rose-600",
    "from-indigo-500 to-blue-600",
    "from-amber-500 to-yellow-600",
    "from-emerald-500 to-green-600",
  ];
  return gradients[index % gradients.length];
};
</script>

<template>
  <div
    class="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900"
  >
    <header class="bg-white/10 backdrop-blur-md border-b border-white/10">
      <div class="px-4 py-5">
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
        <h1 class="text-2xl font-bold text-white">{{ rutina?.nombre }}</h1>
        <p class="text-white/60 text-sm mt-1">Selecciona una semana</p>
      </div>
    </header>

    <main class="p-4 max-w-7xl mx-auto">
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

      <div
        v-else
        class="grid gap-3 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5"
      >
        <button
          v-for="(semana, index) in semanas"
          :key="semana.id"
          @click="selectSemana(semana.id)"
          class="group relative overflow-hidden rounded-xl transition-all duration-300 hover:scale-[1.02] hover:shadow-xl"
          :class="
            semanasCompletas.has(semana.id)
              ? 'bg-gradient-to-br from-green-500 to-emerald-600 shadow-lg shadow-green-500/30'
              : 'bg-white/10 backdrop-blur-sm border border-white/10 hover:bg-white/20'
          "
        >
          <div class="relative p-4">
            <div class="flex items-center justify-between mb-2">
              <div
                class="w-10 h-10 rounded-xl flex items-center justify-center shadow-lg"
                :class="
                  semanasCompletas.has(semana.id)
                    ? 'bg-white/20'
                    : `bg-gradient-to-br ${getSemanaGradient(index)}`
                "
              >
                <span class="text-lg font-bold text-white">{{
                  semana.numero
                }}</span>
              </div>
              <div
                v-if="semanasCompletas.has(semana.id)"
                class="w-6 h-6 rounded-full bg-white/20 flex items-center justify-center"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-4 w-4 text-white"
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
              </div>
            </div>
            <h3
              class="text-sm font-semibold"
              :class="
                semanasCompletas.has(semana.id) ? 'text-white' : 'text-white'
              "
            >
              Semana {{ semana.numero }}
            </h3>
            <p
              class="text-xs mt-0.5"
              :class="
                semanasCompletas.has(semana.id)
                  ? 'text-white/80'
                  : 'text-white/50'
              "
            >
              {{
                semanasCompletas.has(semana.id)
                  ? "Completada"
                  : "Toca para entrenar"
              }}
            </p>
          </div>
          <div
            class="absolute -bottom-3 -right-3 w-12 h-12 rounded-full bg-white/5 group-hover:bg-white/10 transition-colors"
          ></div>
        </button>
      </div>

      <div v-if="!loading && semanas.length === 0" class="text-center py-16">
        <p class="text-white/60 text-lg">No hay semanas disponibles</p>
      </div>
    </main>
  </div>
</template>

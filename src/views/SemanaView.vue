<script setup>
import { onMounted, ref, computed } from "vue";
import { useRoute, useRouter } from "vue-router";
import { rutinaService } from "@/services/rutina";
import { semanaService } from "@/services/semana";
import { diaService } from "@/services/dia";
import { diaCompletadoService } from "@/services/diaCompletado";

const route = useRoute();
const router = useRouter();

const rutinaId = computed(() => route.params.rutinaId);
const semanaId = computed(() => route.params.semanaId);
const rutina = ref(null);
const semana = ref(null);
const dias = ref([]);
const loading = ref(true);
const error = ref("");
const diasCompletados = ref(new Set());

onMounted(async () => {
  await loadData();
});

const loadData = async () => {
  try {
    loading.value = true;
    error.value = "";

    const [rutinaData, semanaData, diasData] = await Promise.all([
      rutinaService.getById(rutinaId.value),
      semanaService.getById(semanaId.value),
      diaService.getBySemana(semanaId.value),
    ]);

    rutina.value = rutinaData;
    semana.value = semanaData;
    dias.value = diasData;

    const completados = await diaCompletadoService.getBySemana(semanaId.value);
    diasCompletados.value = new Set(completados.map((d) => d.dia_id));
  } catch (err) {
    error.value = "Error al cargar datos";
    console.error(err);
  } finally {
    loading.value = false;
  }
};

const selectDia = (diaId) => {
  router.push(
    `/rutina/${rutinaId.value}/semana/${semanaId.value}/dia/${diaId}`,
  );
};

const goBack = () => {
  router.push(`/rutina/${rutinaId.value}`);
};

const getDiaGradient = (index) => {
  const gradients = [
    "from-violet-500 to-purple-600",
    "from-cyan-500 to-blue-600",
    "from-orange-500 to-red-500",
    "from-green-500 to-teal-600",
    "from-pink-500 to-rose-600",
    "from-indigo-500 to-blue-600",
    "from-amber-500 to-yellow-600",
  ];
  return gradients[index % gradients.length];
};

const getDayIcon = (nombre) => {
  const dayName = (nombre || "").toLowerCase();
  if (dayName.includes("pierna") || dayName.includes("leg")) return "🦵";
  if (dayName.includes("pecho") || dayName.includes("chest")) return "💪";
  if (dayName.includes("espalda") || dayName.includes("back")) return "🔙";
  if (dayName.includes("hombro") || dayName.includes("shoulder")) return "💪";
  if (dayName.includes("brazo") || dayName.includes("arm")) return "💪";
  if (dayName.includes("cardio")) return "❤️";
  if (dayName.includes("core")) return "🔥";
  return "🏋️";
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
        <p class="text-violet-400 text-sm mt-1">Semana {{ semana?.numero }}</p>
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

      <div v-else class="grid gap-4 sm:grid-cols-2">
        <button
          v-for="(dia, index) in dias"
          :key="dia.id"
          @click="selectDia(dia.id)"
          class="group relative overflow-hidden rounded-2xl transition-all duration-300 hover:scale-[1.02] hover:shadow-2xl"
          :class="
            diasCompletados.has(dia.id)
              ? 'bg-gradient-to-br from-green-500 to-emerald-600 shadow-lg shadow-green-500/30'
              : 'bg-white/10 backdrop-blur-sm border border-white/10 hover:bg-white/20'
          "
        >
          <div class="relative p-5 flex items-center gap-4">
            <div
              class="w-14 h-14 rounded-2xl flex items-center justify-center shadow-lg text-3xl"
              :class="
                diasCompletados.has(dia.id)
                  ? 'bg-white/20'
                  : `bg-gradient-to-br ${getDiaGradient(index)}`
              "
            >
              {{ getDayIcon(dia.nombre) }}
            </div>
            <div class="flex-1 text-left">
              <h3 class="text-lg font-bold text-white">
                {{ dia.nombre || `Día ${dia.numero}` }}
              </h3>
              <p
                class="text-sm"
                :class="
                  diasCompletados.has(dia.id)
                    ? 'text-white/80'
                    : 'text-white/50'
                "
              >
                {{
                  diasCompletados.has(dia.id)
                    ? "Completado"
                    : "Toca para entrenar"
                }}
              </p>
            </div>
            <div
              v-if="diasCompletados.has(dia.id)"
              class="w-10 h-10 rounded-full bg-white/20 flex items-center justify-center"
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
                  d="M5 13l4 4L19 7"
                />
              </svg>
            </div>
          </div>
        </button>
      </div>

      <div v-if="!loading && dias.length === 0" class="text-center py-16">
        <p class="text-white/60 text-lg">No hay días disponibles</p>
      </div>
    </main>
  </div>
</template>

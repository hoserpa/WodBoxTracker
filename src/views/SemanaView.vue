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
</script>

<template>
  <div class="min-h-screen bg-gray-100">
    <header class="bg-white shadow">
      <div class="px-4 py-4">
        <button @click="goBack" class="text-indigo-600 font-medium">
          ← Volver
        </button>
        <h1 class="text-xl font-bold text-gray-900 mt-2">Días</h1>
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
        <h2 class="text-lg font-semibold text-gray-800 mb-2">
          {{ rutina?.nombre }}
        </h2>
        <h3 class="text-md text-gray-600 mb-4">Semana {{ semana?.numero }}</h3>

        <div class="space-y-3">
          <button
            v-for="dia in dias"
            :key="dia.id"
            @click="selectDia(dia.id)"
            class="w-full p-4 rounded-lg shadow text-left hover:bg-gray-50 active:bg-gray-100 transition-colors flex items-center justify-between"
            :class="
              diasCompletados.has(dia.id)
                ? 'bg-green-50 border-l-4 border-green-500'
                : 'bg-white'
            "
          >
            <div>
              <h3
                class="text-lg font-semibold"
                :class="
                  diasCompletados.has(dia.id)
                    ? 'text-green-700'
                    : 'text-gray-900'
                "
              >
                {{ dia.nombre || `Día ${dia.numero}` }}
              </h3>
            </div>
            <div
              v-if="diasCompletados.has(dia.id)"
              class="flex items-center gap-1 text-green-600"
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
              <span class="text-sm font-medium">Hecho</span>
            </div>
          </button>
        </div>
      </div>
    </main>
  </div>
</template>

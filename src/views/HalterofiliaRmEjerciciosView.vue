<script setup>
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { userRmService } from "@/services/user_rm";

const router = useRouter();
const ejercicios = ref([]);
const loading = ref(true);
const error = ref("");
const saving = ref({});

const goToOpciones = () => {
  router.push("/opciones");
};

const goBack = () => {
  router.push("/halterofilia");
};

const formatDate = (dateStr) => {
  if (!dateStr) return "";
  const date = new Date(dateStr);
  return date.toLocaleDateString("es-ES", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  });
};

const saveRm = async (ejercicio) => {
  if (!ejercicio.rmInput || ejercicio.rmInput <= 0) return;

  saving.value[ejercicio.id] = true;
  try {
    await userRmService.upsert(ejercicio.id, ejercicio.rmInput);
    ejercicio.rm = ejercicio.rmInput;
    ejercicio.fecha = new Date().toISOString();
  } catch (err) {
    error.value = "Error al guardar RM";
    console.error(err);
  } finally {
    saving.value[ejercicio.id] = false;
  }
};

onMounted(async () => {
  try {
    loading.value = true;
    ejercicios.value = await userRmService.getHalterofilia();
    ejercicios.value.forEach((e) => {
      e.rmInput = e.rm;
    });
  } catch (err) {
    error.value = "Error al cargar ejercicios";
    console.error(err);
  } finally {
    loading.value = false;
  }
});
</script>

<template>
  <div
    class="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900"
  >
    <header class="bg-white/10 backdrop-blur-md border-b border-white/10">
      <div
        class="max-w-7xl mx-auto py-5 px-4 flex justify-between items-center"
      >
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
        <button
          @click="goToOpciones"
          class="p-2 rounded-xl bg-white/10 hover:bg-white/20 transition-all duration-300"
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
              d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"
            />
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
            />
          </svg>
        </button>
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
          class="w-1 h-8 bg-gradient-to-b from-cyan-500 to-blue-500 rounded-full"
        ></div>
        <h2 class="text-2xl font-bold text-white">RM Ejercicios Halterofilia</h2>
      </div>

      <div v-if="loading" class="flex justify-center py-16">
        <div
          class="animate-spin rounded-full h-12 w-12 border-4 border-cyan-500 border-t-transparent"
        ></div>
      </div>

      <div
        v-else-if="error"
        class="bg-red-500/20 border border-red-500/50 text-red-200 px-6 py-4 rounded-2xl backdrop-blur-sm"
      >
        {{ error }}
      </div>

      <div v-else class="space-y-3">
        <div
          v-for="ejercicio in ejercicios"
          :key="ejercicio.id"
          class="bg-white/5 backdrop-blur-sm border border-white/10 rounded-xl p-4 flex flex-col sm:flex-row sm:items-center gap-4"
        >
          <div class="flex-1">
            <h3 class="text-white font-semibold text-lg">
              {{ ejercicio.nombre }}
            </h3>
            <p v-if="ejercicio.fecha" class="text-white/50 text-sm">
              Última marca: {{ ejercicio.rm }} kg -
              {{ formatDate(ejercicio.fecha) }}
            </p>
          </div>

          <div class="flex items-center gap-3">
            <input
              v-model="ejercicio.rmInput"
              type="number"
              step="0.5"
              min="0"
              placeholder="RM (kg)"
              class="w-28 bg-white/10 border border-white/20 rounded-lg px-3 py-2 text-white placeholder-white/40 focus:outline-none focus:border-cyan-500"
            />
            <button
              @click="saveRm(ejercicio)"
              :disabled="saving[ejercicio.id]"
              class="px-4 py-2 bg-cyan-500 hover:bg-cyan-600 disabled:opacity-50 text-white rounded-lg font-medium transition-colors"
            >
              {{ saving[ejercicio.id] ? "..." : "Guardar" }}
            </button>
          </div>
        </div>
      </div>

      <div v-if="!loading && ejercicios.length === 0" class="text-center py-16">
        <p class="text-white/60 text-lg">No hay ejercicios halterofilia</p>
      </div>
    </main>
  </div>
</template>

<script setup>
import { onMounted, ref } from "vue";
import { useRouter } from "vue-router";
import { useAuthStore } from "@/stores/auth";
import { rutinaService } from "@/services/rutina";

const router = useRouter();
const authStore = useAuthStore();
const rutinas = ref([]);
const loading = ref(true);
const error = ref("");

onMounted(async () => {
  await authStore.initAuth();

  if (!authStore.user) {
    router.push("/login");
    return;
  }

  await loadRutinas();
});

const loadRutinas = async () => {
  try {
    loading.value = true;
    error.value = "";
    rutinas.value = await rutinaService.getAll();
  } catch (err) {
    error.value = "Error al cargar rutinas";
    console.error(err);
  } finally {
    loading.value = false;
  }
};

const selectRutina = (rutinaId) => {
  router.push(`/rutina/${rutinaId}`);
};

const goToOpciones = () => {
  router.push("/opciones");
};
</script>

<template>
  <div class="min-h-screen bg-gray-100">
    <header class="bg-white shadow">
      <div
        class="max-w-7xl mx-auto py-6 px-4 flex justify-between items-center"
      >
        <h1 class="text-3xl font-bold text-gray-900 flex items-center gap-2">
          <img src="/icon.png" alt="WodBox" class="h-10 rounded-lg" />
          Box Tracker
        </h1>
        <button @click="goToOpciones" class="text-gray-600 hover:text-gray-800">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="h-6 w-6"
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

    <main class="max-w-7xl mx-auto py-6 px-4">
      <h2 class="text-xl font-semibold text-gray-800 mb-4">
        Selecciona una rutina
      </h2>

      <div v-if="loading" class="text-center py-8">
        <p class="text-gray-500">Cargando...</p>
      </div>

      <div
        v-else-if="error"
        class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded"
      >
        {{ error }}
      </div>

      <div v-else class="space-y-3">
        <button
          v-for="rutina in rutinas"
          :key="rutina.id"
          @click="selectRutina(rutina.id)"
          class="w-full bg-white p-4 rounded-lg shadow text-left hover:bg-gray-50 active:bg-gray-100 transition-colors"
        >
          <h3 class="text-lg font-semibold text-gray-900">
            {{ rutina.nombre }}
          </h3>
          <p v-if="rutina.descripcion" class="text-sm text-gray-500 mt-1">
            {{ rutina.descripcion }}
          </p>
        </button>
      </div>
    </main>
  </div>
</template>

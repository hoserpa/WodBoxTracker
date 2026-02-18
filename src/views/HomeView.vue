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

const getGradient = (index) => {
  const gradients = [
    "from-violet-500 to-purple-600",
    "from-cyan-500 to-blue-600",
    "from-orange-500 to-red-500",
    "from-green-500 to-teal-600",
    "from-pink-500 to-rose-600",
    "from-indigo-500 to-blue-600",
  ];
  return gradients[index % gradients.length];
};
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
      <div class="flex items-center gap-3 mb-8">
        <div
          class="w-1 h-8 bg-gradient-to-b from-violet-500 to-cyan-500 rounded-full"
        ></div>
        <h2 class="text-2xl font-bold text-white">Tus Rutinas</h2>
      </div>

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

      <div v-else class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        <button
          v-for="(rutina, index) in rutinas"
          :key="rutina.id"
          @click="selectRutina(rutina.id)"
          class="group relative overflow-hidden rounded-2xl bg-white/10 backdrop-blur-sm border border-white/10 p-6 text-left transition-all duration-300 hover:bg-white/20 hover:scale-[1.02] hover:shadow-2xl hover:shadow-violet-500/20"
        >
          <div
            :class="[
              'absolute inset-0 bg-gradient-to-br opacity-0 group-hover:opacity-100 transition-opacity duration-500',
              getGradient(index),
            ]"
          ></div>
          <div class="relative">
            <div class="flex items-center gap-3 mb-3">
              <div
                :class="[
                  'w-12 h-12 rounded-xl bg-gradient-to-br flex items-center justify-center shadow-lg',
                  getGradient(index),
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
                    d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"
                  />
                </svg>
              </div>
              <h3 class="text-xl font-bold text-white group-hover:text-white">
                {{ rutina.nombre }}
              </h3>
            </div>
            <p
              v-if="rutina.descripcion"
              class="text-white/60 text-sm group-hover:text-white/80 transition-colors"
            >
              {{ rutina.descripcion }}
            </p>
          </div>
          <div
            class="absolute bottom-4 right-4 opacity-0 group-hover:opacity-100 transition-all duration-300 translate-x-2 group-hover:translate-x-0"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="h-5 w-5 text-white"
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
        </button>
      </div>

      <div v-if="!loading && rutinas.length === 0" class="text-center py-16">
        <div
          class="w-20 h-20 mx-auto mb-4 rounded-full bg-white/10 flex items-center justify-center"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="h-10 w-10 text-white/40"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M12 6v6m0 0v6m0-6h6m-6 0H6"
            />
          </svg>
        </div>
        <p class="text-white/60 text-lg">No tienes rutinas todavía</p>
      </div>
    </main>
  </div>
</template>

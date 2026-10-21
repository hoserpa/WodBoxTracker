<script setup>
import AppHeader from "@/components/AppHeader.vue";
import BackButton from "@/components/BackButton.vue";
import { useRouter } from "vue-router";

const router = useRouter();



const goToEntrenamiento = () => {
  router.push("/halterofilia/entrenamiento");
};

const goToRmEjercicios = () => {
  router.push("/halterofilia/rm-ejercicios");
};

const goToHistorial = () => {
  router.push("/halterofilia/historial");
};



const getGradient = (index) => {
  const gradients = [
    "from-amber-500 to-orange-600",
    "from-cyan-500 to-blue-600",
    "from-violet-500 to-purple-600",
  ];
  return gradients[index % gradients.length];
};
</script>

<template>
  <div
    class="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900"
  >
    <AppHeader />
    <main class="max-w-7xl mx-auto py-8 px-4">
      <BackButton to="/" class="mb-6" />

      <div class="flex items-center gap-3 mb-8">
        <div
          class="w-1 h-8 bg-gradient-to-b from-amber-500 to-orange-500 rounded-full"
        ></div>
        <h2 class="text-2xl font-bold text-white">Halterofilia</h2>
      </div>

      <div class="grid gap-4 sm:grid-cols-3">
        <button
          @click="goToEntrenamiento"
          class="group relative overflow-hidden rounded-2xl bg-white/10 backdrop-blur-sm border border-white/10 p-6 text-left transition-all duration-300 hover:bg-white/20 hover:scale-[1.02] hover:shadow-2xl hover:shadow-amber-500/20"
        >
          <div
            :class="[
              'absolute inset-0 bg-gradient-to-br opacity-0 group-hover:opacity-100 transition-opacity duration-500',
              getGradient(0),
            ]"
          ></div>
          <div class="relative">
            <div class="flex items-center gap-3 mb-3">
              <div
                :class="[
                  'w-12 h-12 rounded-xl bg-gradient-to-br flex items-center justify-center shadow-lg text-2xl',
                  getGradient(0),
                ]"
              >
                🏋️
              </div>
              <h3 class="text-xl font-bold text-white group-hover:text-white">
                Entrenaminento
              </h3>
            </div>
            <p
              class="text-white/60 text-sm group-hover:text-white/80 transition-colors"
            >
              Crea y sigue tus entrenamientos personalizados
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

        <button
          @click="goToRmEjercicios"
          class="group relative overflow-hidden rounded-2xl bg-white/10 backdrop-blur-sm border border-white/10 p-6 text-left transition-all duration-300 hover:bg-white/20 hover:scale-[1.02] hover:shadow-2xl hover:shadow-cyan-500/20"
        >
          <div
            :class="[
              'absolute inset-0 bg-gradient-to-br opacity-0 group-hover:opacity-100 transition-opacity duration-500',
              getGradient(1),
            ]"
          ></div>
          <div class="relative">
            <div class="flex items-center gap-3 mb-3">
              <div
                :class="[
                  'w-12 h-12 rounded-xl bg-gradient-to-br flex items-center justify-center shadow-lg',
                  getGradient(1),
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
                RM Ejercicios
              </h3>
            </div>
            <p
              class="text-white/60 text-sm group-hover:text-white/80 transition-colors"
            >
              Registra tus repeticiones máximas
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

        <button
          @click="goToHistorial"
          class="group relative overflow-hidden rounded-2xl bg-white/10 backdrop-blur-sm border border-white/10 p-6 text-left transition-all duration-300 hover:bg-white/20 hover:scale-[1.02] hover:shadow-2xl hover:shadow-violet-500/20"
        >
          <div
            :class="[
              'absolute inset-0 bg-gradient-to-br opacity-0 group-hover:opacity-100 transition-opacity duration-500',
              getGradient(2),
            ]"
          ></div>
          <div class="relative">
            <div class="flex items-center gap-3 mb-3">
              <div
                :class="[
                  'w-12 h-12 rounded-xl bg-gradient-to-br flex items-center justify-center shadow-lg',
                  getGradient(2),
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
                    d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"
                  />
                </svg>
              </div>
              <h3 class="text-xl font-bold text-white group-hover:text-white">
                Historial
              </h3>
            </div>
            <p
              class="text-white/60 text-sm group-hover:text-white/80 transition-colors"
            >
              Ver entrenamientos guardados
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
    </main>
  </div>
</template>









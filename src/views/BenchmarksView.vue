<script setup>
import AppHeader from "@/components/AppHeader.vue";
import BackButton from "@/components/BackButton.vue";
import { useRouter } from "vue-router";

const router = useRouter();



const goToPrincipales = () => {
  router.push("/benchmarks/principales");
};

const goToSecundarios = () => {
  router.push("/benchmarks/secundarios");
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
        <h2 class="text-2xl font-bold text-white">Tus Benchmarks</h2>
      </div>

      <div class="grid gap-4 sm:grid-cols-2">
        <button
          @click="goToPrincipales"
          class="group relative overflow-hidden rounded-2xl bg-white/10 backdrop-blur-sm border border-white/10 p-6 text-left transition-all duration-300 hover:bg-white/20 hover:scale-[1.02] hover:shadow-2xl hover:shadow-amber-500/20"
        >
          <div
            class="absolute inset-0 bg-gradient-to-br opacity-0 group-hover:opacity-100 transition-opacity duration-500 from-amber-500 to-orange-600"
          ></div>
          <div class="relative">
            <div class="flex items-center gap-3 mb-3">
              <div
                class="w-12 h-12 rounded-xl bg-gradient-to-br from-amber-500 to-orange-600 flex items-center justify-center shadow-lg"
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
                    d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"
                  />
                </svg>
              </div>
              <h3 class="text-xl font-bold text-white group-hover:text-white">
                Principales
              </h3>
            </div>
            <p
              class="text-white/60 text-sm group-hover:text-white/80 transition-colors"
            >
              Ejercicios principales (sentadilla, press banca, peso muerto...)
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
          @click="goToSecundarios"
          class="group relative overflow-hidden rounded-2xl bg-white/10 backdrop-blur-sm border border-white/10 p-6 text-left transition-all duration-300 hover:bg-white/20 hover:scale-[1.02] hover:shadow-2xl hover:shadow-amber-500/20"
        >
          <div
            class="absolute inset-0 bg-gradient-to-br opacity-0 group-hover:opacity-100 transition-opacity duration-500 from-amber-500 to-orange-600"
          ></div>
          <div class="relative">
            <div class="flex items-center gap-3 mb-3">
              <div
                class="w-12 h-12 rounded-xl bg-gradient-to-br from-amber-500 to-orange-600 flex items-center justify-center shadow-lg"
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
                    d="M4 6h16M4 12h16M4 18h7"
                  />
                </svg>
              </div>
              <h3 class="text-xl font-bold text-white group-hover:text-white">
                Secundarios
              </h3>
            </div>
            <p
              class="text-white/60 text-sm group-hover:text-white/80 transition-colors"
            >
              Ejercicios complementarios (curl, extensión tríceps...)
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









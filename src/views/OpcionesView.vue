<script setup>
import { useRouter } from "vue-router";
import { useQueryClient } from "@tanstack/vue-query";
import { useAuthStore } from "@/stores/auth";
import { diaCompletadoService } from "@/services/diaCompletado";

const router = useRouter();
const authStore = useAuthStore();
const queryClient = useQueryClient();

const goBack = () => {
  router.push("/");
};

const logout = async () => {
  await authStore.signOut();
  router.push("/login");
};

const resetDias = async () => {
  if (
    window.confirm(
      "¿Estás seguro de que quieres resetear todos los días marcados como completados?",
    )
  ) {
    await diaCompletadoService.resetAll();
    window.alert("Días reseteados correctamente");
  }
};

const reloadCache = async () => {
  await queryClient.invalidateQueries();
  window.alert("Cache recargado correctamente");
};
</script>

<template>
  <div
    class="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900"
  >
    <header class="bg-white/10 backdrop-blur-md border-b border-white/10">
      <div class="px-4 py-5 flex items-center justify-between">
        <button
          @click="goBack"
          class="text-violet-400 font-medium hover:text-violet-300 transition-colors flex items-center gap-2"
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
        <h1 class="text-xl font-bold text-white">Opciones</h1>
        <div class="w-16"></div>
      </div>
    </header>

    <main class="p-4 max-w-2xl mx-auto">
      <div class="space-y-4 mt-4">
        <button
          @click="reloadCache"
          class="w-full group relative overflow-hidden rounded-2xl bg-gradient-to-r from-violet-600 to-purple-600 p-5 text-left transition-all duration-300 hover:scale-[1.02] hover:shadow-2xl hover:shadow-violet-500/30"
        >
          <div
            class="absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 rounded-xl bg-white/20 flex items-center justify-center"
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
                d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"
              />
            </svg>
          </div>
          <h3 class="text-lg font-bold text-white pr-16">Recargar datos</h3>
          <p class="text-white/70 text-sm mt-1">
            Actualizar datos desde el servidor
          </p>
        </button>

        <button
          @click="resetDias"
          class="w-full group relative overflow-hidden rounded-2xl bg-gradient-to-r from-orange-500 to-red-500 p-5 text-left transition-all duration-300 hover:scale-[1.02] hover:shadow-2xl hover:shadow-orange-500/30"
        >
          <div
            class="absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 rounded-xl bg-white/20 flex items-center justify-center"
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
                d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"
              />
            </svg>
          </div>
          <h3 class="text-lg font-bold text-white pr-16">
            Resetear días completados
          </h3>
          <p class="text-white/70 text-sm mt-1">
            Quitar todas las marcas de días hechos
          </p>
        </button>

        <button
          @click="logout"
          class="w-full group relative overflow-hidden rounded-2xl bg-gradient-to-r from-slate-700 to-slate-800 border border-slate-600 p-5 text-left transition-all duration-300 hover:scale-[1.02] hover:shadow-2xl hover:border-slate-500"
        >
          <div
            class="absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 rounded-xl bg-white/10 flex items-center justify-center"
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
                d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"
              />
            </svg>
          </div>
          <h3 class="text-lg font-bold text-white pr-16">Cerrar sesión</h3>
          <p class="text-white/50 text-sm mt-1">Salir de tu cuenta</p>
        </button>
      </div>

      <div class="mt-8 text-center">
        <p class="text-white/30 text-sm">Box Tracker v1.0</p>
      </div>
    </main>
  </div>
</template>

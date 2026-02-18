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
  <div class="min-h-screen bg-gray-100">
    <header class="bg-white shadow">
      <div class="px-4 py-4 flex items-center justify-between">
        <button @click="goBack" class="text-indigo-600 font-medium">
          ← Volver
        </button>
        <h1 class="text-xl font-bold text-gray-900">Opciones</h1>
        <div class="w-16"></div>
      </div>
    </header>

    <main class="p-4">
      <div class="space-y-3">
        <button
          @click="reloadCache"
          class="w-full bg-white p-4 rounded-lg shadow text-left hover:bg-gray-50 active:bg-gray-100 transition-colors"
        >
          <h3 class="text-lg font-semibold text-indigo-600">Recargar datos</h3>
          <p class="text-sm text-gray-500 mt-1">
            Actualizar datos desde el servidor
          </p>
        </button>
        <button
          @click="resetDias"
          class="w-full bg-white p-4 rounded-lg shadow text-left hover:bg-gray-50 active:bg-gray-100 transition-colors"
        >
          <h3 class="text-lg font-semibold text-orange-600">
            Resetear días completados
          </h3>
          <p class="text-sm text-gray-500 mt-1">
            Quitar todas las marcas de días hechos
          </p>
        </button>
        <button
          @click="logout"
          class="w-full bg-white p-4 rounded-lg shadow text-left hover:bg-gray-50 active:bg-gray-100 transition-colors"
        >
          <h3 class="text-lg font-semibold text-red-600">Cerrar sesión</h3>
          <p class="text-sm text-gray-500 mt-1">Salir de tu cuenta</p>
        </button>
      </div>
    </main>
  </div>
</template>

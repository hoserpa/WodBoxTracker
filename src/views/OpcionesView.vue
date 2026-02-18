<script setup>
import { useRouter } from "vue-router";
import { useAuthStore } from "@/stores/auth";

const router = useRouter();
const authStore = useAuthStore();

const goBack = () => {
  router.push("/");
};

const logout = async () => {
  await authStore.signOut();
  router.push("/login");
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

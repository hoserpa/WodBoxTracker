<script setup>
import { onMounted } from 'vue'
import { useAuthStore } from '@/stores/auth'

const authStore = useAuthStore()

onMounted(() => {
  authStore.initAuth()
})

const handleSignOut = async () => {
  await authStore.signOut()
}
</script>

<template>
  <div class="min-h-screen bg-gray-100">
    <header class="bg-white shadow">
      <div class="max-w-7xl mx-auto py-6 px-4 flex justify-between items-center">
        <h1 class="text-3xl font-bold text-gray-900">WodBox Tracker</h1>
        <div v-if="authStore.user">
          <span class="text-gray-600 mr-4">{{ authStore.user.email }}</span>
          <button
            @click="handleSignOut"
            class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700"
          >
            Cerrar Sesión
          </button>
        </div>
      </div>
    </header>

    <main class="max-w-7xl mx-auto py-6 px-4">
      <div v-if="!authStore.user" class="text-center mt-10">
        <p class="text-xl text-gray-600 mb-4">Gestiona tu entrenamiento de forma profesional</p>
        <router-link
          to="/login"
          class="inline-block bg-indigo-600 text-white px-6 py-3 rounded-lg hover:bg-indigo-700"
        >
          Iniciar Sesión
        </router-link>
      </div>

      <div v-else class="space-y-6">
        <div class="bg-white rounded-lg shadow p-6">
          <h2 class="text-xl font-semibold mb-4">Bienvenido</h2>
          <p class="text-gray-600">Selecciona una rutina para comenzar tu entrenamiento.</p>
        </div>
      </div>
    </main>
  </div>
</template>

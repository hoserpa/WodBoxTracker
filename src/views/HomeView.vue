<script setup>
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'
import { rutinaService } from '@/services/rutina'

const router = useRouter()
const authStore = useAuthStore()
const rutinas = ref([])
const loading = ref(true)
const error = ref('')

onMounted(async () => {
  await authStore.initAuth()
  if (authStore.user) {
    await loadRutinas()
  }
})

const loadRutinas = async () => {
  try {
    loading.value = true
    error.value = ''
    rutinas.value = await rutinaService.getAll()
  } catch (err) {
    error.value = 'Error al cargar rutinas'
    console.error(err)
  } finally {
    loading.value = false
  }
}

const handleSignOut = async () => {
  await authStore.signOut()
}

const selectRutina = (rutinaId) => {
  router.push(`/rutina/${rutinaId}`)
}
</script>

<template>
  <div class="min-h-screen bg-gray-100">
    <header class="bg-white shadow">
      <div class="max-w-7xl mx-auto py-6 px-4 flex justify-between items-center">
        <h1 class="text-3xl font-bold text-gray-900">WodBox</h1>
        <div v-if="authStore.user">
          <button
            @click="handleSignOut"
            class="bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 text-sm"
          >
            Salir
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

      <div v-else class="space-y-4">
        <h2 class="text-xl font-semibold text-gray-800">Selecciona una rutina</h2>

        <div v-if="loading" class="text-center py-8">
          <p class="text-gray-500">Cargando...</p>
        </div>

        <div v-else-if="error" class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded">
          {{ error }}
        </div>

        <div v-else class="space-y-3">
          <button
            v-for="rutina in rutinas"
            :key="rutina.id"
            @click="selectRutina(rutina.id)"
            class="w-full bg-white p-4 rounded-lg shadow text-left hover:bg-gray-50 active:bg-gray-100 transition-colors"
          >
            <h3 class="text-lg font-semibold text-gray-900">{{ rutina.nombre }}</h3>
            <p v-if="rutina.descripcion" class="text-sm text-gray-500 mt-1">
              {{ rutina.descripcion }}
            </p>
          </button>
        </div>
      </div>
    </main>
  </div>
</template>

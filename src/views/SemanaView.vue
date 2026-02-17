<script setup>
import { onMounted, ref, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { rutinaService } from '@/services/rutina'
import { semanaService } from '@/services/semana'
import { diaService } from '@/services/dia'

const route = useRoute()
const router = useRouter()

const rutinaId = computed(() => route.params.rutinaId)
const semanaId = computed(() => route.params.semanaId)
const rutina = ref(null)
const semana = ref(null)
const dias = ref([])
const loading = ref(true)
const error = ref('')

onMounted(async () => {
  await loadData()
})

const loadData = async () => {
  try {
    loading.value = true
    error.value = ''
    
    const [rutinaData, semanaData, diasData] = await Promise.all([
      rutinaService.getById(rutinaId.value),
      semanaService.getById(semanaId.value),
      diaService.getBySemana(semanaId.value)
    ])
    
    rutina.value = rutinaData
    semana.value = semanaData
    dias.value = diasData
  } catch (err) {
    error.value = 'Error al cargar datos'
    console.error(err)
  } finally {
    loading.value = false
  }
}

const selectDia = (diaId) => {
  router.push(`/rutina/${rutinaId.value}/semana/${semanaId.value}/dia/${diaId}`)
}

const goBack = () => {
  router.push(`/rutina/${rutinaId.value}`)
}
</script>

<template>
  <div class="min-h-screen bg-gray-100">
    <header class="bg-white shadow">
      <div class="px-4 py-4">
        <button @click="goBack" class="text-indigo-600 font-medium">
          ← Volver
        </button>
        <h1 class="text-xl font-bold text-gray-900 mt-2">Días</h1>
      </div>
    </header>

    <main class="p-4">
      <div v-if="loading" class="text-center py-8">
        <p class="text-gray-500">Cargando...</p>
      </div>

      <div v-else-if="error" class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded">
        {{ error }}
      </div>

      <div v-else>
        <h2 class="text-lg font-semibold text-gray-800 mb-2">{{ rutina?.nombre }}</h2>
        <h3 class="text-md text-gray-600 mb-4">Semana {{ semana?.numero }}</h3>
        
        <div class="space-y-3">
          <button
            v-for="dia in dias"
            :key="dia.id"
            @click="selectDia(dia.id)"
            class="w-full bg-white p-4 rounded-lg shadow text-left hover:bg-gray-50 active:bg-gray-100 transition-colors"
          >
            <h3 class="text-lg font-semibold text-gray-900">{{ dia.nombre || `Día ${dia.numero}` }}</h3>
          </button>
        </div>
      </div>
    </main>
  </div>
</template>

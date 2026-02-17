<script setup>
import { onMounted, ref, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { rutinaService } from '@/services/rutina'
import { semanaService } from '@/services/semana'
import { diaService } from '@/services/dia'
import { serieService } from '@/services/serie'

const route = useRoute()
const router = useRouter()

const rutinaId = computed(() => route.params.rutinaId)
const semanaId = computed(() => route.params.semanaId)
const diaId = computed(() => route.params.diaId)

const rutina = ref(null)
const semana = ref(null)
const dia = ref(null)
const series = ref([])
const loading = ref(true)
const error = ref('')

const tipoLabels = {
  principal: 'Ejercicios Principales',
  secundario: 'Ejercicios Secundarios',
  calentamiento: 'Calentamiento',
  core: 'Core'
}

const tiposEnDia = computed(() => {
  const tipos = new Set(series.value.map(s => s.tipo_ejercicio))
  const orden = ['principal', 'secundario', 'calentamiento', 'core']
  return orden.filter(t => tipos.has(t))
})

const ejerciciosPorTipo = computed(() => {
  const grouped = {}
  tiposEnDia.value.forEach(tipo => {
    grouped[tipo] = series.value.filter(s => s.tipo_ejercicio === tipo)
  })
  return grouped
})

const selectedTipo = ref(null)

onMounted(async () => {
  await loadData()
})

const loadData = async () => {
  try {
    loading.value = true
    error.value = ''
    
    const [rutinaData, semanaData, diaData, seriesData] = await Promise.all([
      rutinaService.getById(rutinaId.value),
      semanaService.getById(semanaId.value),
      diaService.getById(diaId.value),
      serieService.getByDia(diaId.value)
    ])
    
    rutina.value = rutinaData
    semana.value = semanaData
    dia.value = diaData
    series.value = seriesData
  } catch (err) {
    error.value = 'Error al cargar datos'
    console.error(err)
  } finally {
    loading.value = false
  }
}

const selectTipo = (tipo) => {
  selectedTipo.value = tipo
}

const goBack = () => {
  if (selectedTipo.value) {
    selectedTipo.value = null
  } else {
    router.push(`/rutina/${rutinaId.value}/semana/${semanaId.value}`)
  }
}
</script>

<template>
  <div class="min-h-screen bg-gray-100 pb-20">
    <header class="bg-white shadow sticky top-0 z-10">
      <div class="px-4 py-4">
        <button @click="goBack" class="text-indigo-600 font-medium">
          ← Volver
        </button>
        <h1 class="text-xl font-bold text-gray-900 mt-2">{{ dia?.nombre || `Día ${dia?.numero}` }}</h1>
        <p class="text-sm text-gray-600">{{ rutina?.nombre }} - Semana {{ semana?.numero }}</p>
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
        <!-- Lista de tipos -->
        <div v-if="!selectedTipo" class="space-y-3">
          <button
            v-for="tipo in tiposEnDia"
            :key="tipo"
            @click="selectTipo(tipo)"
            class="w-full bg-white p-4 rounded-lg shadow text-left hover:bg-gray-50 active:bg-gray-100 transition-colors"
          >
            <h3 class="text-lg font-semibold text-gray-900">{{ tipoLabels[tipo] }}</h3>
            <p class="text-sm text-gray-500 mt-1">
              {{ ejerciciosPorTipo[tipo]?.length }} ejercicio{{ ejerciciosPorTipo[tipo]?.length !== 1 ? 's' : '' }}
            </p>
          </button>
        </div>

        <!-- Ejercicios del tipo seleccionado -->
        <div v-else>
          <h2 class="text-lg font-bold text-gray-800 mb-4">{{ tipoLabels[selectedTipo] }}</h2>
          
          <div class="space-y-3">
            <div
              v-for="serie in ejerciciosPorTipo[selectedTipo]"
              :key="serie.id"
              class="bg-white p-4 rounded-lg shadow"
            >
              <h3 class="font-semibold text-gray-900">{{ serie.ejercicio?.nombre }}</h3>
              
              <div class="mt-2 flex flex-wrap gap-2 text-sm text-gray-600">
                <span v-if="serie.sets" class="bg-gray-100 px-2 py-1 rounded">
                  {{ serie.sets }}x{{ serie.reps }}
                </span>
                <span v-if="serie.tempo" class="bg-gray-100 px-2 py-1 rounded">
                  Tempo: {{ serie.tempo }}
                </span>
                <span v-if="serie.rir" class="bg-gray-100 px-2 py-1 rounded">
                  RIR: {{ serie.rir }}
                </span>
                <span v-if="serie.rpe" class="bg-gray-100 px-2 py-1 rounded">
                  RPE: {{ serie.rpe }}
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

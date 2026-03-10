<script setup>
import { ref, onMounted, computed } from "vue";
import { useRouter } from "vue-router";
import { userRmService } from "@/services/user_rm";

const router = useRouter();
const ejercicios = ref([]);
const loading = ref(true);
const error = ref("");
const ejercicioSeleccionado = ref(null);
const repeticiones = ref("");
const series = ref("");
const mostrarTabla = ref(false);
const porcentajes = ref([]);

const goToOpciones = () => {
  router.push("/opciones");
};

const goBack = () => {
  router.push("/halterofilia");
};

const rmSeleccionado = computed(() => {
  if (ejercicioSeleccionado.value) {
    return ejercicios.value.find((e) => e.id === ejercicioSeleccionado.value)?.rm;
  }
  return null;
});

const calcularPorcentajes = () => {
  if (!ejercicioSeleccionado.value || !repeticiones.value) {
    error.value = "Selecciona un ejercicio e ingresa repeticiones";
    return;
  }

  error.value = "";
  const rm = rmSeleccionado.value;
  if (!rm) {
    error.value = "No hay RM registrado para este ejercicio";
    return;
  }

  const tabla = [];
  for (let porcentaje = 50; porcentaje <= 100; porcentaje += 5) {
    tabla.push({
      porcentaje,
      peso: parseFloat(((rm * porcentaje) / 100).toFixed(1)),
    });
  }

  porcentajes.value = tabla;
  mostrarTabla.value = true;
};

onMounted(async () => {
  try {
    loading.value = true;
    ejercicios.value = await userRmService.getHalterofilia();
  } catch (err) {
    error.value = "Error al cargar ejercicios";
    console.error(err);
  } finally {
    loading.value = false;
  }
});
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
      <button
        @click="goBack"
        class="flex items-center gap-2 text-white/60 hover:text-white mb-6 transition-colors"
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

      <div class="flex items-center gap-3 mb-8">
        <div
          class="w-1 h-8 bg-gradient-to-b from-amber-500 to-orange-500 rounded-full"
        ></div>
        <h2 class="text-2xl font-bold text-white">Calculadora Halterofilia</h2>
      </div>

      <div v-if="loading" class="flex justify-center py-16">
        <div
          class="animate-spin rounded-full h-12 w-12 border-4 border-amber-500 border-t-transparent"
        ></div>
      </div>

      <div v-else class="space-y-6">
        <div class="bg-white/10 backdrop-blur-sm border border-white/10 rounded-2xl p-6">
          <div class="space-y-4">
            <!-- Seleccionar ejercicio -->
            <div>
              <label class="block text-white font-medium mb-2">
                Selecciona ejercicio
              </label>
              <select
                v-model="ejercicioSeleccionado"
                class="w-full px-4 py-2 bg-white/10 border border-white/20 rounded-lg text-white placeholder-white/40 focus:outline-none focus:border-amber-500"
              >
                <option value="" disabled class="text-gray-600">-- Selecciona un ejercicio --</option>
                <option v-for="e in ejercicios" :key="e.id" :value="e.id" class="text-gray-800">
                  {{ e.nombre }}
                  <span v-if="e.rm" class="text-gray-600">- RM: {{ e.rm }} kg</span>
                </option>
              </select>
            </div>

            <!-- Input repeticiones y series -->
            <div class="grid grid-cols-2 gap-4">
              <div>
                <label class="block text-white font-medium mb-2">
                  Repeticiones
                </label>
                <input
                  v-model.number="repeticiones"
                  type="number"
                  placeholder="Ej: 5"
                  class="w-full px-4 py-2 bg-white/10 border border-white/20 rounded-lg text-white placeholder-white/40 focus:outline-none focus:border-amber-500"
                />
              </div>
              <div>
                <label class="block text-white font-medium mb-2">
                  Series
                </label>
                <input
                  v-model.number="series"
                  type="number"
                  placeholder="Ej: 3"
                  class="w-full px-4 py-2 bg-white/10 border border-white/20 rounded-lg text-white placeholder-white/40 focus:outline-none focus:border-amber-500"
                />
              </div>
            </div>

            <!-- Botón calcular -->
            <button
              @click="calcularPorcentajes"
              class="w-full px-4 py-3 bg-amber-500 hover:bg-amber-600 text-white font-bold rounded-lg transition-colors"
            >
              Calcular %
            </button>

            <!-- Mostrar error si existe -->
            <div
              v-if="error"
              class="bg-red-500/20 border border-red-500/50 text-red-200 px-4 py-3 rounded-lg"
            >
              {{ error }}
            </div>
          </div>
        </div>

        <!-- Tabla de porcentajes -->
        <div v-if="mostrarTabla" class="bg-white/10 backdrop-blur-sm border border-white/10 rounded-2xl overflow-hidden">
          <div class="p-6 border-b border-white/10">
            <h3 class="text-xl font-bold text-white">
              {{ ejercicios.find((e) => e.id === ejercicioSeleccionado)?.nombre }} - RM: {{ rmSeleccionado }} kg
            </h3>
            <p class="text-white/60 text-sm mt-1">
              {{ repeticiones }} rep x {{ series }} series
            </p>
          </div>

          <div class="overflow-x-auto">
            <table class="w-full text-white">
              <thead class="bg-white/10 border-b border-white/10">
                <tr>
                  <th class="px-6 py-3 text-left font-semibold">Porcentaje</th>
                  <th class="px-6 py-3 text-left font-semibold">Peso (kg)</th>
                </tr>
              </thead>
              <tbody class="divide-y divide-white/10">
                <tr
                  v-for="(item, index) in porcentajes"
                  :key="index"
                  class="hover:bg-white/5 transition-colors"
                  :class="{ 'bg-amber-500/10': item.porcentaje === 100 }"
                >
                  <td class="px-6 py-3">
                    <span
                      class="inline-block px-3 py-1 rounded-lg"
                      :class="
                        item.porcentaje === 100
                          ? 'bg-amber-500/30 text-amber-300 font-bold'
                          : 'bg-white/10 text-white/80'
                      "
                    >
                      {{ item.porcentaje }}%
                    </span>
                  </td>
                  <td class="px-6 py-3 font-semibold text-lg">
                    {{ item.peso }} kg
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

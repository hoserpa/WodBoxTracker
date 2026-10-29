<script setup>
import AppHeader from "@/components/AppHeader.vue";
import BackButton from "@/components/BackButton.vue";
import RoundStepper from "@/components/RoundStepper.vue";
/* global setTimeout */
import { ref, computed, watch, onMounted } from "vue";
import { useRouter, useRoute } from "vue-router";
import { userRmService } from "@/services/user_rm";
import { halterofiliaService } from "@/services/halterofilia_entrenamiento";

const router = useRouter();
const route = useRoute();
const ejercicios = ref([]);
const loading = ref(true);
const saving = ref(false);
const error = ref("");
const editMode = ref(false);
const entrenamientoId = ref(null);

const ejercicioSeleccionado = ref("");
const numRondas = ref(1);

const decrementarNumRondas = () => {
  if (numRondas.value > 1) {
    numRondas.value--;
  }
};

const incrementarNumRondas = () => {
  numRondas.value++;
};
const ejerciciosAñadidos = ref([]);
const ejercicioActual = ref(null);
const notas = ref("");
const mensajeExito = ref("");
const fecha = ref("");

const resultadoGeneral = computed(() => {
  if (!ejercicioActual.value) return 0;
  const peso = Number(ejercicioActual.value.pesoGeneral);
  const porcentaje = Number(ejercicioActual.value.porcentajeGeneral);
  if (!peso || !porcentaje) return 0;
  return parseFloat(((peso * porcentaje) / 100).toFixed(1));
});

const puedeConfirmarEjercicio = computed(() => {
  if (!ejercicioActual.value || ejercicioActual.value.rondas.length === 0) return false;
  return editMode.value || resultadoGeneral.value > 0;
});

const ajustarGeneral = (campo, delta, min, max) => {
  if (!ejercicioActual.value) return;
  const valor = (Number(ejercicioActual.value[campo]) || 0) + delta;
  if (valor < min || valor > max) return;
  ejercicioActual.value[campo] = campo === "pesoGeneral" ? parseFloat(valor.toFixed(1)) : valor;
};

const calcularPesoConBase = (base, porcentaje) => {
  if (!base || !porcentaje) return 0;
  return parseFloat(((base * porcentaje) / 100).toFixed(1));
};

const getRmPorEjercicio = (ejercicioId) => {
  const ejercicio = ejercicios.value.find((e) => e.id === ejercicioId);
  return ejercicio?.rm || null;
};

const calcularPeso = (ejercicioId, porcentaje) => {
  const rm = getRmPorEjercicio(ejercicioId);
  if (!rm || !porcentaje) return 0;
  return parseFloat(((rm * porcentaje) / 100).toFixed(1));
};

const añadirEjercicio = () => {
  if (!ejercicioSeleccionado.value) {
    error.value = "Selecciona un ejercicio";
    return;
  }

  const ejercicio = ejercicios.value.find(
    (e) => e.id === ejercicioSeleccionado.value,
  );

  ejercicioActual.value = {
    ejercicio_id: ejercicioSeleccionado.value,
    nombre_ejercicio: ejercicio?.nombre,
    rm: ejercicio?.rm,
    pesoGeneral: ejercicio?.rm ?? null,
    porcentajeGeneral: 100,
    rondas: [],
  };

  error.value = "";
};

const añadirRondas = () => {
  if (!ejercicioActual.value) return;

  const num = parseInt(numRondas.value) || 1;
  const base = resultadoGeneral.value || ejercicioActual.value.rm || 0;

  for (let i = 0; i < num; i++) {
    ejercicioActual.value.rondas.push({
      repeticiones: 1,
      series: 1,
      porcentaje: 50,
      peso: calcularPesoConBase(base, 50),
    });
  }

  numRondas.value = 1;
};

const aplicarCambio = (ronda, { campo, valor }, ejercicioId = null) => {
  ronda[campo] = valor;
  if (campo === "porcentaje") {
    const base = editMode.value
      ? getRmPorEjercicio(ejercicioId)
      : resultadoGeneral.value || ejercicioActual.value?.rm || 0;
    ronda.peso = calcularPesoConBase(base, valor);
  }
};

watch(resultadoGeneral, (base) => {
  if (editMode.value || !ejercicioActual.value) return;
  ejercicioActual.value.rondas.forEach((ronda) => {
    ronda.peso = calcularPesoConBase(base, ronda.porcentaje);
  });
});

const eliminarRonda = (index) => {
  ejercicioActual.value.rondas.splice(index, 1);
};

const confirmarEjercicio = () => {
  if (!ejercicioActual.value || ejercicioActual.value.rondas.length === 0) {
    error.value = "Añade al menos una ronda";
    return;
  }

  ejerciciosAñadidos.value.push({ ...ejercicioActual.value });
  ejercicioActual.value = null;
  ejercicioSeleccionado.value = "";
  error.value = "";
};

const eliminarEjercicio = (index) => {
  ejerciciosAñadidos.value.splice(index, 1);
};

const eliminarRondaEdit = (ejercicio, rIndex) => {
  ejercicio.rondas.splice(rIndex, 1);
};

const goBack = () => {
  if (editMode.value) {
    router.push("/halterofilia/historial");
  } else {
    router.push("/halterofilia");
  }
};

const guardarEntrenamiento = async () => {
  if (ejerciciosAñadidos.value.length === 0) {
    error.value = "Añade al menos un ejercicio";
    return;
  }

  try {
    saving.value = true;
    error.value = "";

    const ejerciciosParaGuardar = ejerciciosAñadidos.value.map((e) => ({
      ejercicio_id: e.ejercicio_id,
      rondas: e.rondas,
    }));

    if (editMode.value && entrenamientoId.value) {
      await halterofiliaService.update(entrenamientoId.value, {
        notas: notas.value?.trim().slice(0, 1000) || null,
        fecha: fecha.value || null,
        ejercicios: ejerciciosParaGuardar,
      });
      mensajeExito.value = "Entrenamiento actualizado correctamente";
    } else {
      await halterofiliaService.create({
        notas: notas.value?.trim().slice(0, 1000) || null,
        ejercicios: ejerciciosParaGuardar,
      });
      mensajeExito.value = "Entrenamiento guardado correctamente";
      ejerciciosAñadidos.value = [];
      notas.value = "";
    }

    setTimeout(() => {
      mensajeExito.value = "";
    }, 3000);

    if (editMode.value) {
      router.push("/halterofilia/historial");
    }
  } catch (err) {
    error.value = "Error al guardar entrenamiento";
    console.error(err);
  } finally {
    saving.value = false;
  }
};

onMounted(async () => {
  try {
    loading.value = true;
    ejercicios.value = await userRmService.getHalterofilia();

    if (route.params.id) {
      editMode.value = true;
      entrenamientoId.value = route.params.id;
      const data = await halterofiliaService.getById(entrenamientoId.value);
      notas.value = data.notas || "";
      fecha.value = data.fecha || "";
      ejerciciosAñadidos.value = data.ejercicios.map((e) => ({
        ejercicio_id: e.ejercicio_id,
        nombre_ejercicio: e.nombre_ejercicio,
        rm: e.rm || null,
        rondas: e.rondas.map((r) => ({
          repeticiones: r.repeticiones,
          series: r.series,
          porcentaje: r.porcentaje,
          peso: r.peso || calcularPeso(e.ejercicio_id, r.porcentaje),
        })),
      }));
    }
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
    <AppHeader />
    <main class="max-w-7xl mx-auto py-8 px-4">
      <BackButton :fallback="goBack" class="mb-6" />

      <div class="flex items-center gap-3 mb-8">
        <div
          class="w-1 h-8 bg-gradient-to-b from-amber-500 to-orange-500 rounded-full"
        ></div>
        <h2 class="text-2xl font-bold text-white">
          {{ editMode ? "Editar" : "Nuevo" }} Entrenamiento Halterofilia
        </h2>
      </div>

      <div
        v-if="mensajeExito"
        class="bg-green-500/20 border border-green-500/50 text-green-200 px-4 py-3 rounded-lg mb-6"
      >
        {{ mensajeExito }}
      </div>

      <div v-if="loading" class="flex justify-center py-16">
        <div
          class="animate-spin rounded-full h-12 w-12 border-4 border-amber-500 border-t-transparent"
        ></div>
      </div>

      <div v-else class="space-y-6">
        <div
          v-if="!ejercicioActual"
          class="bg-white/10 backdrop-blur-sm border border-white/10 rounded-2xl p-6"
        >
          <h3 class="text-lg font-bold text-white mb-4">Añadir Ejercicio</h3>
          <div class="space-y-4">
            <div>
              <label class="block text-white font-medium mb-2">
                Ejercicio
              </label>
              <select
                v-model="ejercicioSeleccionado"
                class="w-full px-4 py-2 bg-white/10 border border-white/20 rounded-lg text-white placeholder-white/40 focus:outline-none focus:border-amber-500"
              >
                <option value="" disabled class="text-gray-600">
                  -- Selecciona un ejercicio --
                </option>
                <option
                  v-for="e in ejercicios"
                  :key="e.id"
                  :value="e.id"
                  class="text-gray-800"
                >
                  {{ e.nombre }}
                  <span v-if="e.rm" class="text-gray-600"
                    >- RM: {{ e.rm }} kg</span
                  >
                </option>
              </select>
            </div>

            <button
              @click="añadirEjercicio"
              :disabled="!ejercicioSeleccionado"
              class="w-full px-4 py-3 bg-amber-500 hover:bg-amber-600 disabled:bg-amber-500/50 disabled:cursor-not-allowed text-white font-bold rounded-lg transition-colors"
            >
              Añadir Ejercicio
            </button>
          </div>
        </div>

        <div
          v-if="ejercicioActual"
          class="bg-white/10 backdrop-blur-sm border border-white/10 rounded-2xl p-6"
        >
          <div class="flex items-center justify-between mb-4">
            <h3 class="text-lg font-bold text-white">
              {{ ejercicioActual.nombre_ejercicio }}
              <span v-if="ejercicioActual.rm" class="text-amber-300 text-sm">
                (RM: {{ ejercicioActual.rm }} kg)
              </span>
            </h3>
          </div>

          <div class="space-y-4">
            <div>
              <label class="block text-white font-medium mb-2">
                Número de rondas
              </label>
              <div class="flex items-center justify-center gap-4">
                <button
                  @click="decrementarNumRondas"
                  :disabled="numRondas <= 1"
                  class="w-12 h-12 rounded-xl bg-white/10 hover:bg-white/20 text-white font-bold text-xl flex items-center justify-center disabled:opacity-30 disabled:cursor-not-allowed"
                >
                  -
                </button>
                <span class="w-12 text-center text-white font-bold text-2xl">
                  {{ numRondas }}
                </span>
                <button
                  @click="incrementarNumRondas"
                  class="w-12 h-12 rounded-xl bg-white/10 hover:bg-white/20 text-white font-bold text-xl flex items-center justify-center"
                >
                  +
                </button>
              </div>
            </div>

            <div v-if="!editMode" class="space-y-3">
              <h4 class="text-white font-medium">Cálculo de peso base</h4>
              <div class="grid grid-cols-3 gap-2">
                <div>
                  <label class="block text-white/60 text-xs text-center mb-1">
                    Peso general
                  </label>
                  <div class="flex items-center justify-center gap-1">
                    <button
                      @click="ajustarGeneral('pesoGeneral', -0.5, 0, Infinity)"
                      :disabled="!ejercicioActual.pesoGeneral"
                      class="w-8 h-8 rounded-lg bg-white/10 hover:bg-white/20 text-white font-bold flex items-center justify-center disabled:opacity-30 disabled:cursor-not-allowed"
                    >
                      -
                    </button>
                    <span class="w-12 text-center text-white font-medium">
                      {{ ejercicioActual.pesoGeneral ?? 0 }}
                    </span>
                    <button
                      @click="ajustarGeneral('pesoGeneral', 0.5, 0, Infinity)"
                      class="w-8 h-8 rounded-lg bg-white/10 hover:bg-white/20 text-white font-bold flex items-center justify-center"
                    >
                      +
                    </button>
                  </div>
                </div>
                <div>
                  <label class="block text-white/60 text-xs text-center mb-1">
                    Porcentaje
                  </label>
                  <div class="flex items-center justify-center gap-1">
                    <button
                      @click="ajustarGeneral('porcentajeGeneral', -5, 0, 100)"
                      :disabled="!ejercicioActual.porcentajeGeneral"
                      class="w-8 h-8 rounded-lg bg-white/10 hover:bg-white/20 text-white font-bold flex items-center justify-center disabled:opacity-30 disabled:cursor-not-allowed"
                    >
                      -
                    </button>
                    <span class="w-12 text-center text-white font-medium">
                      {{ ejercicioActual.porcentajeGeneral ?? 0 }}%
                    </span>
                    <button
                      @click="ajustarGeneral('porcentajeGeneral', 5, 0, 100)"
                      :disabled="ejercicioActual.porcentajeGeneral >= 100"
                      class="w-8 h-8 rounded-lg bg-white/10 hover:bg-white/20 text-white font-bold flex items-center justify-center disabled:opacity-30 disabled:cursor-not-allowed"
                    >
                      +
                    </button>
                  </div>
                </div>
                <div>
                  <label class="block text-white/60 text-xs text-center mb-1">
                    Resultado
                  </label>
                  <div class="h-8 flex items-center justify-center text-amber-300 font-medium">
                    {{ resultadoGeneral }} kg
                  </div>
                </div>
              </div>
              <p class="text-white/50 text-xs">
                Los porcentajes de las rondas se calculan sobre este resultado.
              </p>
            </div>

            <button
              @click="añadirRondas"
              class="w-full px-4 py-3 bg-amber-500 hover:bg-amber-600 text-white font-bold rounded-lg transition-colors"
            >
              Añadir Rondas
            </button>

            <div
              v-if="ejercicioActual.rondas.length > 0"
              class="space-y-3 mt-6"
            >
              <h4 class="text-white font-medium">Rondas:</h4>
              <div
                v-for="(ronda, index) in ejercicioActual.rondas"
                :key="index"
                class="bg-white/5 rounded-xl p-3"
              >
                <div class="flex items-center justify-between mb-3">
                  <span class="text-white/80 font-medium">{{ index + 1 }}</span>
                  <button
                    @click="eliminarRonda(index)"
                    class="p-1 text-red-400 hover:text-red-300"
                  >
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      class="h-4 w-4"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M6 18L18 6M6 6l12 12"
                      />
                    </svg>
                  </button>
                </div>

                <RoundStepper :ronda="ronda" @change="aplicarCambio(ronda, $event)" />
                </div>
              </div>

            <div class="flex gap-3 mt-6">
              <button
                @click="confirmarEjercicio"
                :disabled="!puedeConfirmarEjercicio"
                class="flex-1 px-4 py-3 bg-green-500 hover:bg-green-600 disabled:bg-green-500/50 disabled:cursor-not-allowed text-white font-bold rounded-lg transition-colors"
              >
                Confirmar Ejercicio
              </button>
              <button
                @click="ejercicioActual = null"
                class="px-4 py-3 bg-white/10 hover:bg-white/20 text-white font-bold rounded-lg transition-colors"
              >
                Cancelar
              </button>
            </div>
          </div>
        </div>

        <div
          v-if="ejerciciosAñadidos.length > 0"
          class="bg-white/10 backdrop-blur-sm border border-white/10 rounded-2xl p-6"
        >
          <h3 class="text-lg font-bold text-white mb-4">
            Ejercicios ({{ ejerciciosAñadidos.length }})
          </h3>
          <div class="space-y-4">
            <div
              v-for="(ejercicio, index) in ejerciciosAñadidos"
              :key="index"
              class="bg-white/5 rounded-xl p-4"
            >
              <div class="flex items-center justify-between mb-3">
                <div>
                  <p class="text-white font-medium">
                    {{ ejercicio.nombre_ejercicio }}
                  </p>
                </div>
                <button
                  @click="eliminarEjercicio(index)"
                  class="p-2 text-red-400 hover:text-red-300"
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
                      d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
                    />
                  </svg>
                </button>
              </div>
              <div v-if="editMode" class="space-y-3">
                <div
                  v-for="(ronda, rIndex) in ejercicio.rondas"
                  :key="rIndex"
                  class="bg-white/5 rounded-xl p-3"
                >
                  <div class="flex items-center justify-between mb-2">
                    <span class="text-white/80 font-medium text-sm">Ronda {{ rIndex + 1 }}</span>
                    <button
                      @click="eliminarRondaEdit(ejercicio, rIndex)"
                      class="p-1 text-red-400 hover:text-red-300"
                    >
                      <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                      </svg>
                    </button>
                  </div>

                  <RoundStepper :ronda="ronda" editable-peso @change="aplicarCambio(ronda, $event, ejercicio.ejercicio_id)" />
                </div>
              </div>

              <div v-else class="space-y-2">
                <div
                  v-for="(ronda, rIndex) in ejercicio.rondas"
                  :key="rIndex"
                  class="text-white/60 text-sm flex flex-wrap gap-x-2 gap-y-1"
                >
                  <span>{{ ronda.repeticiones }} rep</span>
                  <span>x</span>
                  <span>{{ ronda.series }} series</span>
                  <span>@</span>
                  <span>{{ ronda.porcentaje }}%</span>
                  <input
                    v-model.number="ronda.peso"
                    type="number"
                    step="0.5"
                    class="w-16 px-1 py-0.5 bg-white/10 border border-white/20 rounded text-amber-300 text-sm text-center focus:outline-none focus:border-amber-500"
                  />
                  <span class="text-white/60">kg</span>
                </div>
              </div>
            </div>
          </div>

          <div class="mt-6 space-y-4">
            <div v-if="editMode">
              <label class="block text-white font-medium mb-2"> Fecha </label>
              <input
                v-model="fecha"
                type="date"
                class="w-full px-4 py-2 bg-white/10 border border-white/20 rounded-lg text-white focus:outline-none focus:border-amber-500"
              />
            </div>

            <div>
              <label class="block text-white font-medium mb-2"> Notas </label>
              <textarea
                v-model="notas"
                rows="2"
                maxlength="1000"
                placeholder="Observaciones del entrenamiento..."
                class="w-full px-4 py-2 bg-white/10 border border-white/20 rounded-lg text-white placeholder-white/40 focus:outline-none focus:border-amber-500 resize-none"
              ></textarea>
            </div>

            <button
              @click="guardarEntrenamiento"
              :disabled="saving"
              class="w-full px-4 py-3 bg-green-500 hover:bg-green-600 disabled:bg-green-500/50 text-white font-bold rounded-lg transition-colors"
            >
              {{ saving ? "Guardando..." : editMode ? "Actualizar Entrenamiento" : "Guardar Entrenamiento" }}
            </button>
          </div>
        </div>

        <div
          v-if="error"
          class="bg-red-500/20 border border-red-500/50 text-red-200 px-4 py-3 rounded-lg"
        >
          {{ error }}
        </div>
      </div>
    </main>
  </div>
</template>











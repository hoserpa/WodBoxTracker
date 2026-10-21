<script setup>
const props = defineProps({
  ronda: {
    type: Object,
    required: true,
  },
  editablePeso: {
    type: Boolean,
    default: false,
  },
});

const emit = defineEmits(["change"]);

const ajustar = (campo, delta, min, max) => {
  const valor = props.ronda[campo] + delta;
  if (valor < min || valor > max) return;
  emit("change", { campo, valor });
};
</script>

<template>
  <div>
    <div class="grid grid-cols-3 gap-2">
      <div>
        <label class="block text-white/60 text-xs text-center mb-1">Reps</label>
        <div class="flex items-center justify-center gap-1">
          <button
            @click="ajustar('repeticiones', -1, 1, Infinity)"
            :disabled="ronda.repeticiones <= 1"
            class="w-8 h-8 rounded-lg bg-white/10 hover:bg-white/20 text-white font-bold flex items-center justify-center disabled:opacity-30 disabled:cursor-not-allowed"
          >
            -
          </button>
          <span class="w-8 text-center text-white font-medium">
            {{ ronda.repeticiones }}
          </span>
          <button
            @click="ajustar('repeticiones', 1, 1, Infinity)"
            class="w-8 h-8 rounded-lg bg-white/10 hover:bg-white/20 text-white font-bold flex items-center justify-center"
          >
            +
          </button>
        </div>
      </div>

      <div>
        <label class="block text-white/60 text-xs text-center mb-1">Series</label>
        <div class="flex items-center justify-center gap-1">
          <button
            @click="ajustar('series', -1, 1, Infinity)"
            :disabled="ronda.series <= 1"
            class="w-8 h-8 rounded-lg bg-white/10 hover:bg-white/20 text-white font-bold flex items-center justify-center disabled:opacity-30 disabled:cursor-not-allowed"
          >
            -
          </button>
          <span class="w-8 text-center text-white font-medium">
            {{ ronda.series }}
          </span>
          <button
            @click="ajustar('series', 1, 1, Infinity)"
            class="w-8 h-8 rounded-lg bg-white/10 hover:bg-white/20 text-white font-bold flex items-center justify-center"
          >
            +
          </button>
        </div>
      </div>

      <div>
        <label class="block text-white/60 text-xs text-center mb-1">%</label>
        <div class="flex items-center justify-center gap-1">
          <button
            @click="ajustar('porcentaje', -5, 50, 100)"
            :disabled="ronda.porcentaje <= 50"
            class="w-8 h-8 rounded-lg bg-white/10 hover:bg-white/20 text-white font-bold flex items-center justify-center disabled:opacity-30 disabled:cursor-not-allowed"
          >
            -
          </button>
          <span class="w-8 text-center text-white font-medium">
            {{ ronda.porcentaje }}
          </span>
          <button
            @click="ajustar('porcentaje', 5, 50, 100)"
            :disabled="ronda.porcentaje >= 100"
            class="w-8 h-8 rounded-lg bg-white/10 hover:bg-white/20 text-white font-bold flex items-center justify-center disabled:opacity-30 disabled:cursor-not-allowed"
          >
            +
          </button>
        </div>
      </div>
    </div>

    <div class="mt-2 text-center">
      <div v-if="editablePeso" class="flex items-center justify-center gap-2">
        <input
          :value="ronda.peso"
          @input="emit('change', { campo: 'peso', valor: Number($event.target.value) })"
          type="number"
          step="0.5"
          class="w-20 px-2 py-1 bg-white/10 border border-white/20 rounded text-amber-300 text-sm text-center focus:outline-none focus:border-amber-500"
        />
        <span class="text-white/60 text-sm">kg</span>
      </div>
      <span v-else class="text-amber-300 font-medium">
        {{ ronda.peso }} kg
      </span>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { userRmService } from "@/services/user_rm";
import AppHeader from "@/components/AppHeader.vue";
import BackButton from "@/components/BackButton.vue";

const props = defineProps({
  tipo: {
    type: String,
    required: true,
  },
  titulo: {
    type: String,
    required: true,
  },
  vacio: {
    type: String,
    required: true,
  },
});

const ejercicios = ref([]);
const loading = ref(true);
const error = ref("");
const saving = ref({});

const formatDate = (dateStr) => {
  if (!dateStr) return "";
  const date = new Date(dateStr);
  return date.toLocaleDateString("es-ES", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  });
};

const saveRm = async (ejercicio) => {
  if (!ejercicio.rmInput || ejercicio.rmInput <= 0) return;

  saving.value[ejercicio.id] = true;
  try {
    await userRmService.upsert(ejercicio.id, ejercicio.rmInput);
    ejercicio.rm = ejercicio.rmInput;
    ejercicio.fecha = new Date().toISOString();
  } catch (err) {
    error.value = "Error al guardar RM";
    console.error(err);
  } finally {
    saving.value[ejercicio.id] = false;
  }
};

onMounted(async () => {
  try {
    loading.value = true;
    ejercicios.value = await userRmService.getByTipo(props.tipo);
    ejercicios.value.forEach((e) => {
      e.rmInput = e.rm;
    });
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
      <BackButton to="/benchmarks" class="mb-6" />

      <div class="flex items-center gap-3 mb-8">
        <div
          class="w-1 h-8 bg-gradient-to-b from-amber-500 to-orange-500 rounded-full"
        ></div>
        <h2 class="text-2xl font-bold text-white">{{ titulo }}</h2>
      </div>

      <div v-if="loading" class="flex justify-center py-16">
        <div
          class="animate-spin rounded-full h-12 w-12 border-4 border-amber-500 border-t-transparent"
        ></div>
      </div>

      <div
        v-else-if="error"
        class="bg-red-500/20 border border-red-500/50 text-red-200 px-6 py-4 rounded-2xl backdrop-blur-sm"
      >
        {{ error }}
      </div>

      <div v-else class="space-y-3">
        <div
          v-for="ejercicio in ejercicios"
          :key="ejercicio.id"
          class="bg-white/5 backdrop-blur-sm border border-white/10 rounded-xl p-4 flex flex-col sm:flex-row sm:items-center gap-4"
        >
          <div class="flex-1">
            <h3 class="text-white font-semibold text-lg">
              {{ ejercicio.nombre }}
            </h3>
            <p v-if="ejercicio.fecha" class="text-white/50 text-sm">
              Última marca: {{ ejercicio.rm }} kg -
              {{ formatDate(ejercicio.fecha) }}
            </p>
          </div>

          <div class="flex items-center gap-3">
            <input
              v-model="ejercicio.rmInput"
              type="number"
              step="0.5"
              min="0"
              placeholder="RM (kg)"
              class="w-28 bg-white/10 border border-white/20 rounded-lg px-3 py-2 text-white placeholder-white/40 focus:outline-none focus:border-amber-500"
            />
            <button
              @click="saveRm(ejercicio)"
              :disabled="saving[ejercicio.id]"
              class="px-4 py-2 bg-amber-500 hover:bg-amber-600 disabled:opacity-50 text-white rounded-lg font-medium transition-colors"
            >
              {{ saving[ejercicio.id] ? "..." : "Guardar" }}
            </button>
          </div>
        </div>
      </div>

      <div v-if="!loading && ejercicios.length === 0" class="text-center py-16">
        <p class="text-white/60 text-lg">{{ vacio }}</p>
      </div>
    </main>
  </div>
</template>


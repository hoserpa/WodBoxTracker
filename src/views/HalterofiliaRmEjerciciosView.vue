<script setup>
/* global setTimeout confirm */
import { ref, onMounted, computed } from "vue";
import { useRouter } from "vue-router";
import { userRmService } from "@/services/user_rm";
import { supabase } from "@/lib/supabase";
import { useAuthStore } from "@/stores/auth";
import { storeToRefs } from "pinia";

const router = useRouter();
const authStore = useAuthStore();
const { user } = storeToRefs(authStore);
const ejercicios = ref([]);
const loading = ref(true);
const error = ref("");
const saving = ref({});
const mensajeExito = ref("");
const nuevoEjercicio = ref("");
const guardandoNuevo = ref(false);

const puedeBorrar = computed(() => {
  return user.value?.email === "joraalgo@gmail.com";
});

const puedeBorrarEjercicio = (ejercicio) => {
  if (!user.value) return false;
  if (ejercicio.user_id) return ejercicio.user_id === user.value.id;
  return puedeBorrar.value;
};

const goToOpciones = () => {
  router.push("/opciones");
};

const goBack = () => {
  router.push("/halterofilia");
};

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

const crearEjercicio = async () => {
  const nombre = nuevoEjercicio.value.trim().slice(0, 100);
  if (!nombre) return;

  guardandoNuevo.value = true;
  try {
    const { error: insertError } = await supabase.from("ejercicios").insert({
      nombre: nombre.toUpperCase(),
      tipo_id: 5,
    });

    if (insertError) throw insertError;

    mensajeExito.value = "Ejercicio creado correctamente";
    setTimeout(() => {
      mensajeExito.value = "";
    }, 3000);

    nuevoEjercicio.value = "";
    await cargarEjercicios();
  } catch (err) {
    error.value = "Error al crear ejercicio";
    console.error(err);
  } finally {
    guardandoNuevo.value = false;
  }
};

const eliminarEjercicio = async (ejercicio) => {
  const mensajeConfirmacion = ejercicio.user_id
    ? `¿Eliminar tu ejercicio privado "${ejercicio.nombre}"?`
    : `¿Eliminar "${ejercicio.nombre}"? Esto también puede afectar a otros datos.`;

  if (!confirm(mensajeConfirmacion)) {
    return;
  }

  error.value = "";

  try {
    const { error: deleteError } = await supabase
      .from("ejercicios")
      .delete()
      .eq("id", ejercicio.id);

    if (deleteError) throw deleteError;

    mensajeExito.value = "Ejercicio eliminado";
    setTimeout(() => {
      mensajeExito.value = "";
    }, 3000);

    await cargarEjercicios();
  } catch (err) {
    error.value =
      err?.code === "23503"
        ? "No se puede eliminar: el ejercicio está en uso en entrenamientos guardados"
        : "Error al eliminar ejercicio";
    console.error(err);
  }
};

const cargarEjercicios = async () => {
  try {
    loading.value = true;
    ejercicios.value = await userRmService.getHalterofilia();
    ejercicios.value.forEach((e) => {
      e.rmInput = e.rm;
    });
  } catch (err) {
    error.value = "Error al cargar ejercicios";
    console.error(err);
  } finally {
    loading.value = false;
  }
};

onMounted(async () => {
  await cargarEjercicios();
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
          class="w-1 h-8 bg-gradient-to-b from-cyan-500 to-blue-500 rounded-full"
        ></div>
        <h2 class="text-2xl font-bold text-white">
          RM Ejercicios Halterofilia
        </h2>
      </div>

      <div
        v-if="mensajeExito"
        class="bg-green-500/20 border border-green-500/50 text-green-200 px-4 py-3 rounded-lg mb-6"
      >
        {{ mensajeExito }}
      </div>

      <div
        class="bg-white/10 backdrop-blur-sm border border-white/10 rounded-2xl p-4 mb-6"
      >
        <h3 class="text-white font-medium mb-3">Añadir nuevo ejercicio</h3>
        <div class="flex gap-3">
          <input
            v-model="nuevoEjercicio"
            type="text"
            maxlength="100"
            placeholder="Nombre del ejercicio"
            class="flex-1 px-4 py-2 bg-white/10 border border-white/20 rounded-lg text-white placeholder-white/40 focus:outline-none focus:border-cyan-500"
            @keyup.enter="crearEjercicio"
          />
          <button
            @click="crearEjercicio"
            :disabled="!nuevoEjercicio.trim() || guardandoNuevo"
            class="px-4 py-2 bg-cyan-500 hover:bg-cyan-600 disabled:opacity-50 text-white rounded-lg font-medium transition-colors"
          >
            {{ guardandoNuevo ? "..." : "Añadir" }}
          </button>
        </div>
      </div>

      <div v-if="loading" class="flex justify-center py-16">
        <div
          class="animate-spin rounded-full h-12 w-12 border-4 border-cyan-500 border-t-transparent"
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
            <h3 class="text-white font-semibold text-lg flex items-center gap-2">
              {{ ejercicio.nombre }}
              <span
                v-if="ejercicio.user_id"
                class="text-[10px] font-bold uppercase tracking-wide text-cyan-300 bg-cyan-500/20 px-1.5 py-0.5 rounded"
              >
                Privado
              </span>
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
              class="w-28 bg-white/10 border border-white/20 rounded-lg px-3 py-2 text-white placeholder-white/40 focus:outline-none focus:border-cyan-500"
            />
            <button
              @click="saveRm(ejercicio)"
              :disabled="saving[ejercicio.id]"
              class="px-4 py-2 bg-cyan-500 hover:bg-cyan-600 disabled:opacity-50 text-white rounded-lg font-medium transition-colors"
            >
              {{ saving[ejercicio.id] ? "..." : "Guardar" }}
            </button>
            <button
              v-if="puedeBorrarEjercicio(ejercicio)"
              @click="eliminarEjercicio(ejercicio)"
              class="p-2 text-red-400 hover:text-red-300"
              title="Eliminar ejercicio"
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
        </div>
      </div>

      <div v-if="!loading && ejercicios.length === 0" class="text-center py-16">
        <p class="text-white/60 text-lg">No hay ejercicios halterofilia</p>
      </div>
    </main>
  </div>
</template>

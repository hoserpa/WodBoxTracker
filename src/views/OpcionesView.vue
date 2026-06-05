<script setup>
import { ref } from "vue";
import { useRouter } from "vue-router";
import { useQueryClient } from "@tanstack/vue-query";
import { useAuthStore } from "@/stores/auth";
import { diaCompletadoService } from "@/services/diaCompletado";
import InstallPwaButton from "@/components/InstallPwaButton.vue";

const router = useRouter();
const authStore = useAuthStore();
const queryClient = useQueryClient();

const showChangePassword = ref(false);
const newPassword = ref("");
const confirmPassword = ref("");
const passwordLoading = ref(false);
const passwordError = ref("");
const passwordSuccess = ref(false);

const goBack = () => {
  router.push("/");
};

const changePassword = async () => {
  passwordError.value = "";
  passwordSuccess.value = false;

  if (newPassword.value.length < 6) {
    passwordError.value = "Mínimo 6 caracteres";
    return;
  }

  if (newPassword.value !== confirmPassword.value) {
    passwordError.value = "Las contraseñas no coinciden";
    return;
  }

  passwordLoading.value = true;

  try {
    await authStore.updatePassword(newPassword.value);
    passwordSuccess.value = true;
    newPassword.value = "";
    confirmPassword.value = "";
    showChangePassword.value = false;
  } catch (err) {
    passwordError.value = err.message;
  } finally {
    passwordLoading.value = false;
  }
};

const logout = async () => {
  await authStore.signOut();
  router.push("/login");
};

const resetDias = async () => {
  if (
    window.confirm(
      "¿Estás seguro de que quieres resetear todos los días marcados como completados?",
    )
  ) {
    await diaCompletadoService.resetAll();
    window.alert("Días reseteados correctamente");
  }
};

const reloadCache = async () => {
  await queryClient.invalidateQueries();
  window.alert("Cache recargado correctamente");
};
</script>

<template>
  <div
    class="min-h-screen bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900"
  >
    <header class="bg-white/10 backdrop-blur-md border-b border-white/10">
      <div class="px-4 py-5 flex items-center justify-between">
        <button
          @click="goBack"
          class="text-violet-400 font-medium hover:text-violet-300 transition-colors flex items-center gap-2"
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
        <h1 class="text-xl font-bold text-white">Opciones</h1>
        <div class="w-16"></div>
      </div>
    </header>

    <main class="p-4 max-w-2xl mx-auto">
      <div class="space-y-4 mt-4">
        <button
          @click="reloadCache"
          class="w-full group relative overflow-hidden rounded-2xl bg-gradient-to-r from-violet-600 to-purple-600 p-5 text-left transition-all duration-300 hover:scale-[1.02] hover:shadow-2xl hover:shadow-violet-500/30"
        >
          <div
            class="absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 rounded-xl bg-white/20 flex items-center justify-center"
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
                d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"
              />
            </svg>
          </div>
          <h3 class="text-lg font-bold text-white pr-16">Recargar datos</h3>
          <p class="text-white/70 text-sm mt-1">
            Actualizar datos desde el servidor
          </p>
        </button>

        <button
          @click="resetDias"
          class="w-full group relative overflow-hidden rounded-2xl bg-gradient-to-r from-orange-500 to-red-500 p-5 text-left transition-all duration-300 hover:scale-[1.02] hover:shadow-2xl hover:shadow-orange-500/30"
        >
          <div
            class="absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 rounded-xl bg-white/20 flex items-center justify-center"
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
                d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"
              />
            </svg>
          </div>
          <h3 class="text-lg font-bold text-white pr-16">
            Resetear días completados
          </h3>
          <p class="text-white/70 text-sm mt-1">
            Quitar todas las marcas de días hechos
          </p>
        </button>

        <div>
          <button
            @click="showChangePassword = !showChangePassword"
            class="w-full group relative overflow-hidden rounded-2xl bg-gradient-to-r from-cyan-600 to-teal-600 p-5 text-left transition-all duration-300 hover:scale-[1.02] hover:shadow-2xl hover:shadow-cyan-500/30"
          >
            <div
              class="absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 rounded-xl bg-white/20 flex items-center justify-center"
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
                  d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"
                />
              </svg>
            </div>
            <h3 class="text-lg font-bold text-white pr-16">
              Cambiar contrase&ntilde;a
            </h3>
            <p class="text-white/70 text-sm mt-1">
              Actualizar tu contrase&ntilde;a de acceso
            </p>
          </button>

          <div
            v-if="showChangePassword"
            class="mt-2 bg-white/10 backdrop-blur-md border border-white/10 rounded-2xl p-5 overflow-hidden transition-all"
          >
            <form @submit.prevent="changePassword" class="space-y-4">
              <div
                v-if="passwordError"
                class="bg-red-500/20 border border-red-500/50 text-red-200 px-4 py-3 rounded-xl text-sm"
              >
                {{ passwordError }}
              </div>
              <div
                v-if="passwordSuccess"
                class="bg-emerald-500/20 border border-emerald-500/50 text-emerald-200 px-4 py-3 rounded-xl text-sm"
              >
                Contraseña actualizada correctamente
              </div>

              <div>
                <label class="block text-sm font-medium text-white/70 mb-2"
                  >Nueva contraseña</label
                >
                <input
                  v-model="newPassword"
                  type="password"
                  required
                  minlength="6"
                  class="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-white/40 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:border-transparent transition-all"
                  placeholder="Mínimo 6 caracteres"
                />
              </div>

              <div>
                <label class="block text-sm font-medium text-white/70 mb-2"
                  >Confirmar contraseña</label
                >
                <input
                  v-model="confirmPassword"
                  type="password"
                  required
                  minlength="6"
                  class="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-white/40 focus:outline-none focus:ring-2 focus:ring-cyan-500 focus:border-transparent transition-all"
                  placeholder="Repite la contraseña"
                />
              </div>

              <button
                type="submit"
                :disabled="passwordLoading"
                class="w-full py-3 px-4 bg-gradient-to-r from-cyan-600 to-teal-600 text-white font-bold rounded-xl hover:from-cyan-500 hover:to-teal-500 transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
              >
                <div
                  v-if="passwordLoading"
                  class="animate-spin rounded-full h-5 w-5 border-2 border-white border-t-transparent"
                ></div>
                <span>{{
                  passwordLoading ? "Guardando..." : "Guardar contraseña"
                }}</span>
              </button>
            </form>
          </div>
        </div>

        <InstallPwaButton variant="card" />

        <button
          @click="logout"
          class="w-full group relative overflow-hidden rounded-2xl bg-gradient-to-r from-slate-700 to-slate-800 border border-slate-600 p-5 text-left transition-all duration-300 hover:scale-[1.02] hover:shadow-2xl hover:border-slate-500"
        >
          <div
            class="absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 rounded-xl bg-white/10 flex items-center justify-center"
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
                d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"
              />
            </svg>
          </div>
          <h3 class="text-lg font-bold text-white pr-16">Cerrar sesión</h3>
          <p class="text-white/50 text-sm mt-1">Salir de tu cuenta</p>
        </button>
      </div>

      <div class="mt-8 text-center">
        <p class="text-white/30 text-sm">Box Tracker v1.0</p>
      </div>
    </main>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { useRouter } from "vue-router";
import { useAuthStore } from "@/stores/auth";

const router = useRouter();
const authStore = useAuthStore();

const password = ref("");
const confirmPassword = ref("");
const loading = ref(false);
const error = ref("");
const success = ref(false);

const isFromInvite = authStore.isRecoveryMode;

const handleSubmit = async () => {
  error.value = "";

  if (password.value.length < 6) {
    error.value = "La contraseña debe tener al menos 6 caracteres";
    return;
  }

  if (password.value !== confirmPassword.value) {
    error.value = "Las contraseñas no coinciden";
    return;
  }

  loading.value = true;

  try {
    await authStore.updatePassword(password.value);
    success.value = true;
    window.setTimeout(() => {
      router.push("/login");
    }, 2000);
  } catch (err) {
    error.value = err.message;
  } finally {
    loading.value = false;
  }
};
</script>

<template>
  <div
    class="min-h-screen flex items-center justify-center bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900 p-4"
  >
    <div class="w-full max-w-md">
      <div class="text-center mb-8">
        <img
          src="/icon.png"
          alt="WodBox"
          class="h-20 w-20 mx-auto rounded-2xl shadow-2xl mb-4"
        />
        <h1
          class="text-3xl font-bold bg-gradient-to-r from-violet-400 to-cyan-400 bg-clip-text text-transparent"
        >
          {{ isFromInvite ? "Establecer" : "Restablecer" }}
          contrase&ntilde;a
        </h1>
        <p class="text-white/50 mt-2">
          {{
            isFromInvite
              ? "Elige una contraseña para tu cuenta"
              : "Escribe tu nueva contraseña"
          }}
        </p>
      </div>

      <div
        class="bg-white/10 backdrop-blur-md border border-white/10 rounded-2xl p-6 shadow-2xl"
      >
        <form v-if="!success" @submit.prevent="handleSubmit" class="space-y-5">
          <div
            v-if="error"
            class="bg-red-500/20 border border-red-500/50 text-red-200 px-4 py-3 rounded-xl"
          >
            {{ error }}
          </div>

          <div>
            <label class="block text-sm font-medium text-white/70 mb-2"
              >Nueva contrase&ntilde;a</label
            >
            <input
              v-model="password"
              type="password"
              required
              minlength="6"
              class="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-white/40 focus:outline-none focus:ring-2 focus:ring-violet-500 focus:border-transparent transition-all"
              placeholder="M&iacute;nimo 6 caracteres"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-white/70 mb-2"
              >Confirmar contrase&ntilde;a</label
            >
            <input
              v-model="confirmPassword"
              type="password"
              required
              minlength="6"
              class="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-white/40 focus:outline-none focus:ring-2 focus:ring-violet-500 focus:border-transparent transition-all"
              placeholder="Repite la contrase&ntilde;a"
            />
          </div>

          <button
            type="submit"
            :disabled="loading"
            class="w-full py-3 px-4 bg-gradient-to-r from-violet-600 to-purple-600 text-white font-bold rounded-xl hover:from-violet-500 hover:to-purple-500 transition-all duration-300 shadow-lg shadow-violet-500/30 disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
          >
            <div
              v-if="loading"
              class="animate-spin rounded-full h-5 w-5 border-2 border-white border-t-transparent"
            ></div>
            <span>{{
              loading ? "Guardando..." : "Guardar contrase&ntilde;a"
            }}</span>
          </button>
        </form>

        <div v-else class="text-center space-y-5">
          <div
            class="bg-emerald-500/20 border border-emerald-500/50 text-emerald-200 px-4 py-3 rounded-xl"
          >
            Contrase&ntilde;a guardada correctamente.
          </div>
          <p class="text-white/50 text-sm">Redirigiendo al login...</p>
        </div>
      </div>
    </div>
  </div>
</template>

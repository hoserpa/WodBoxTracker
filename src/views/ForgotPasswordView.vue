<script setup>
import { ref } from "vue";
import { useAuthStore } from "@/stores/auth";

const authStore = useAuthStore();

const email = ref("");
const loading = ref(false);
const error = ref("");
const sent = ref(false);

const handleSubmit = async () => {
  error.value = "";
  loading.value = true;

  try {
    await authStore.resetPassword(email.value);
    sent.value = true;
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
          Recuperar contrase&ntilde;a
        </h1>
        <p class="text-white/50 mt-2">
          Te enviaremos un link para restablecerla
        </p>
      </div>

      <div
        class="bg-white/10 backdrop-blur-md border border-white/10 rounded-2xl p-6 shadow-2xl"
      >
        <form v-if="!sent" @submit.prevent="handleSubmit" class="space-y-5">
          <div
            v-if="error"
            class="bg-red-500/20 border border-red-500/50 text-red-200 px-4 py-3 rounded-xl"
          >
            {{ error }}
          </div>

          <div>
            <label class="block text-sm font-medium text-white/70 mb-2"
              >Email</label
            >
            <input
              v-model="email"
              type="email"
              required
              class="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-white/40 focus:outline-none focus:ring-2 focus:ring-violet-500 focus:border-transparent transition-all"
              placeholder="tu@email.com"
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
              loading
                ? "Enviando..."
                : "Enviar link de recuperaci&oacute;n"
            }}</span>
          </button>
        </form>

        <div v-else class="text-center space-y-5">
          <div
            class="bg-emerald-500/20 border border-emerald-500/50 text-emerald-200 px-4 py-3 rounded-xl"
          >
            Revisa tu email. Si existe una cuenta asociada a
            <strong>{{ email }}</strong
            >, recibir&aacute;s un link para restablecer tu contrase&ntilde;a.
          </div>
          <button
            @click="sent = false"
            class="text-violet-400 hover:text-violet-300 transition-colors text-sm"
          >
            Enviar de nuevo
          </button>
        </div>
      </div>

      <div class="text-center mt-6">
        <router-link
          to="/login"
          class="text-violet-400 hover:text-violet-300 transition-colors text-sm"
        >
          Volver al inicio de sesi&oacute;n
        </router-link>
      </div>
    </div>
  </div>
</template>

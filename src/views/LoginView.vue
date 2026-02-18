<script setup>
import { ref } from "vue";
import { useRouter } from "vue-router";
import { useAuthStore } from "@/stores/auth";

const router = useRouter();
const authStore = useAuthStore();

const email = ref("");
const password = ref("");
const loading = ref(false);
const error = ref("");

const handleSubmit = async () => {
  error.value = "";
  loading.value = true;

  try {
    await authStore.signIn(email.value, password.value);
    router.push("/");
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
          Box Tracker
        </h1>
        <p class="text-white/50 mt-2">Inicia sesión para continuar</p>
      </div>

      <div
        class="bg-white/10 backdrop-blur-md border border-white/10 rounded-2xl p-6 shadow-2xl"
      >
        <form @submit.prevent="handleSubmit" class="space-y-5">
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

          <div>
            <label class="block text-sm font-medium text-white/70 mb-2"
              >Contraseña</label
            >
            <input
              v-model="password"
              type="password"
              required
              class="w-full px-4 py-3 bg-white/10 border border-white/20 rounded-xl text-white placeholder-white/40 focus:outline-none focus:ring-2 focus:ring-violet-500 focus:border-transparent transition-all"
              placeholder="••••••••"
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
            <span>{{ loading ? "Iniciando..." : "Iniciar Sesión" }}</span>
          </button>
        </form>
      </div>

      <p class="text-center text-white/30 text-sm mt-6">Powered by WodBox</p>
    </div>
  </div>
</template>

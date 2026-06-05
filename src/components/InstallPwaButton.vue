<script setup>
import { useInstallPrompt } from '@/composables/useInstallPrompt'

defineProps({
  variant: {
    type: String,
    default: 'card',
    validator: (v) => ['card', 'banner'].includes(v),
  },
})

const emit = defineEmits(['dismiss'])

const { isInstallable, register, install } = useInstallPrompt()

register()
</script>

<template>
  <template v-if="isInstallable && variant === 'card'">
    <button
      @click="install"
      class="w-full group relative overflow-hidden rounded-2xl bg-gradient-to-r from-emerald-600 to-green-600 p-5 text-left transition-all duration-300 hover:scale-[1.02] hover:shadow-2xl hover:shadow-emerald-500/30"
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
            d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
          />
        </svg>
      </div>
      <h3 class="text-lg font-bold text-white pr-16">
        Instalar app
      </h3>
      <p class="text-white/70 text-sm mt-1">
        A&ntilde;ade Box Tracker a tu pantalla de inicio
      </p>
    </button>
  </template>

  <template v-if="isInstallable && variant === 'banner'">
    <div
      class="fixed bottom-0 left-0 right-0 z-50 p-4 pb-6 md:pb-4 animate-slide-up"
    >
      <div
        class="mx-auto max-w-md bg-gradient-to-r from-slate-800 to-slate-900 border border-white/20 rounded-2xl p-4 shadow-2xl backdrop-blur-md"
      >
        <div class="flex items-center gap-4">
          <img
            src="/icon.png"
            alt="WodBox"
            class="h-12 w-12 rounded-xl shrink-0"
          />
          <div class="flex-1 min-w-0">
            <p class="text-white font-semibold text-sm">Instala Box Tracker</p>
            <p class="text-white/50 text-xs mt-0.5">
              A&ntilde;&aacute;delo a tu pantalla de inicio para acceder r&aacute;pido
            </p>
          </div>
          <button
            @click="install"
            class="shrink-0 bg-gradient-to-r from-emerald-600 to-green-600 text-white font-bold px-4 py-2 rounded-xl text-sm hover:from-emerald-500 hover:to-green-500 transition-all duration-300"
          >
            Instalar
          </button>
          <button
            @click="emit('dismiss')"
            class="shrink-0 text-white/40 hover:text-white/70 transition-colors"
            aria-label="Cerrar"
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
                d="M6 18L18 6M6 6l12 12"
              />
            </svg>
          </button>
        </div>
      </div>
    </div>
  </template>
</template>

<style scoped>
@keyframes slide-up {
  from {
    transform: translateY(100%);
    opacity: 0;
  }
  to {
    transform: translateY(0);
    opacity: 1;
  }
}
.animate-slide-up {
  animation: slide-up 0.3s ease-out;
}
</style>

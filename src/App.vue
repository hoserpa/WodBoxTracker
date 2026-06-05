<script setup>
import { onMounted, onUnmounted, watch } from 'vue'
import { useRouter } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const router = useRouter()
const authStore = useAuthStore()

const hash = window.location.hash
const isFromInvite = hash.includes('type=signup') || hash.includes('type=invite')

onMounted(async () => {
  await authStore.initAuth()

  if (isFromInvite) {
    authStore.isRecoveryMode = true
    router.push('/update-password')
  }
})

watch(
  () => authStore.isRecoveryMode,
  (mode) => {
    if (mode) {
      router.push('/update-password')
    }
  },
)

onUnmounted(() => {
  authStore.cleanup()
})
</script>

<template>
  <div id="app" class="min-h-screen bg-gray-50">
    <router-view />
  </div>
</template>

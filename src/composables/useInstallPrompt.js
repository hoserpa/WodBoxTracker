import { ref } from 'vue'

let deferredPrompt = null
const isInstallable = ref(false)
let isRegistered = false

export function useInstallPrompt() {
  const register = () => {
    if (isRegistered) return
    isRegistered = true

    window.addEventListener('beforeinstallprompt', (e) => {
      e.preventDefault()
      deferredPrompt = e
      isInstallable.value = true
    })

    window.addEventListener('appinstalled', () => {
      isInstallable.value = false
      deferredPrompt = null
    })
  }

  const install = async () => {
    if (!deferredPrompt) return
    deferredPrompt.prompt()
    const { outcome } = await deferredPrompt.userChoice
    if (outcome === 'accepted') {
      isInstallable.value = false
    }
    deferredPrompt = null
  }

  return { isInstallable, register, install }
}

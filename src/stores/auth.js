import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { supabase } from '@/lib/supabase'

export const useAuthStore = defineStore('auth', () => {
  const user = ref(null)
  const session = ref(null)
  const isRecoveryMode = ref(false)
  let _unsubscribe = null

  const isAuthenticated = computed(() => !!user.value)

  const initAuth = async () => {
    const { data } = await supabase.auth.getSession()
    session.value = data.session
    user.value = data.session?.user ?? null

    const { data: listenerData } = supabase.auth.onAuthStateChange(
      (event, _session) => {
        session.value = _session
        user.value = _session?.user ?? null

        if (event === 'PASSWORD_RECOVERY') {
          isRecoveryMode.value = true
        }
      },
    )
    _unsubscribe = listenerData?.subscription?.unsubscribe ?? null
  }

  const cleanup = () => {
    if (_unsubscribe) {
      _unsubscribe()
      _unsubscribe = null
    }
  }

  const signIn = async (email, password) => {
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    })
    if (error) throw error
    return data
  }

  const signUp = async (email, password) => {
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
    })
    if (error) throw error
    return data
  }

  const signOut = async () => {
    const { error } = await supabase.auth.signOut()
    if (error) throw error
  }

  const resetPassword = async (email) => {
    const { error } = await supabase.auth.resetPasswordForEmail(email, {
      redirectTo: window.location.origin,
    })
    if (error) throw error
  }

  const updatePassword = async (password) => {
    const { data, error } = await supabase.auth.updateUser({ password })
    if (error) throw error
    isRecoveryMode.value = false
    return data
  }

  return {
    user,
    session,
    isAuthenticated,
    isRecoveryMode,
    initAuth,
    cleanup,
    signIn,
    signUp,
    signOut,
    resetPassword,
    updatePassword,
  }
})

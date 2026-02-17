import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '@/stores/auth'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('@/views/HomeView.vue'),
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/LoginView.vue'),
  },
  {
    path: '/rutina/:rutinaId/semana/:semanaId',
    name: 'Workout',
    component: () => import('@/views/WorkoutView.vue'),
    meta: { requiresAuth: true },
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

router.beforeEach(async (to, from, next) => {
  const authStore = useAuthStore()
  
  if (!authStore.session) {
    await authStore.initAuth()
  }

  if (to.meta.requiresAuth && !authStore.user) {
    next({ name: 'Login' })
  } else if (to.name === 'Login' && authStore.user) {
    next({ name: 'Home' })
  } else {
    next()
  }
})

export default router

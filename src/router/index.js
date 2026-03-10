import { createRouter, createWebHashHistory } from "vue-router";
import { useAuthStore } from "@/stores/auth";

const routes = [
  {
    path: "/",
    name: "Home",
    component: () => import("@/views/HomeView.vue"),
  },
  {
    path: "/login",
    name: "Login",
    component: () => import("@/views/LoginView.vue"),
  },
  {
    path: "/benchmarks",
    name: "Benchmarks",
    component: () => import("@/views/BenchmarksView.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/benchmarks/principales",
    name: "BenchmarksPrincipales",
    component: () => import("@/views/BenchmarksPrincipalesView.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/benchmarks/secundarios",
    name: "BenchmarksSecundarios",
    component: () => import("@/views/BenchmarksSecundariosView.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/halterofilia",
    name: "Halterofilia",
    component: () => import("@/views/HalterofiliaView.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/halterofilia/calculadora",
    name: "HalterofiliaCalculadora",
    component: () => import("@/views/HalterofiliaCalculadoraView.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/halterofilia/rm-ejercicios",
    name: "HalterofiliaRmEjercicios",
    component: () => import("@/views/HalterofiliaRmEjerciciosView.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/opciones",
    name: "Opciones",
    component: () => import("@/views/OpcionesView.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/rutina/:rutinaId",
    name: "Rutina",
    component: () => import("@/views/RutinaView.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/rutina/:rutinaId/semana/:semanaId",
    name: "Semana",
    component: () => import("@/views/SemanaView.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/rutina/:rutinaId/semana/:semanaId/dia/:diaId",
    name: "Dia",
    component: () => import("@/views/DiaView.vue"),
    meta: { requiresAuth: true },
  },
];

const router = createRouter({
  history: createWebHashHistory(),
  routes,
});

router.beforeEach(async (to, from, next) => {
  const authStore = useAuthStore();

  if (!authStore.session) {
    await authStore.initAuth();
  }

  if (to.meta.requiresAuth && !authStore.user) {
    next({ name: "Login" });
  } else if (to.name === "Login" && authStore.user) {
    next({ name: "Home" });
  } else {
    next();
  }
});

export default router;

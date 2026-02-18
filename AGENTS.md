# WodBoxTracker - AGENTS.md

## Vue 3 SPA with Supabase for gym workout tracking. Stack: Vue 3 (Composition API), Vite, TailwindCSS, Pinia, Supabase.

## Commands

```bash
npm run dev          # Dev server (http://localhost:5173)
npm run build        # Production build
npm run preview      # Preview production build
npm run lint         # ESLint check
npm run lint:fix     # ESLint auto-fix
npm run deploy       # Build and deploy to gh-pages
npm install @tanstack/vue-query  # TanStack Query for caching/offline
```

**Testing** - Vitest NOT installed. Add:

```bash
npm install -D vitest @vue/test-utils jsdom
```

Add to package.json: `"test": "vitest", "test:single": "vitest run"`
Run single test: `npx vitest run src/components/__tests__/MyComponent.test.js`

---

## Code Style

- Language: JavaScript (no TypeScript), ESLint + Prettier, 2 spaces, semicolons, single quotes
- Use Composition API with `<script setup>`

### Imports (group order)

```js
import { ref, computed } from "vue";
import { useRouter } from "vue-router";
import { supabase } from "@/lib/supabase";
import { useAuthStore } from "@/stores/auth";
import { rutinaService } from "@/services/rutina";
import ExerciseCard from "@/components/ExerciseCard.vue";
```

### Naming

- Components: PascalCase, Stores: `useXxxStore.js`, Services: camelCase, Constants: SCREAMING_SNAKE_CASE

### Vue Components

```vue
<script setup>
import { ref, computed } from "vue";
const props = defineProps({ routineId: { type: String, required: true } });
const emit = defineEmits(["update", "delete"]);
const isLoading = ref(false);
</script>
<template>
  <div class="p-4"><!-- content --></div>
</template>
```

### Supabase Patterns

```js
// SELECT: const { data, error } = await supabase.from("table").select("cols").eq("field", val);
// INSERT: const { data, error } = await supabase.from("table").insert({ col: val }).select().single();
// UPDATE: const { data, error } = await supabase.from("table").update({ col: val }).eq("id", id).select().single();
// DELETE: const { error } = await supabase.from("table").delete().eq("id", id);
// All: if (error) throw error;
```

### Error Handling

```js
const loadData = async () => {
  try {
    loading.value = true;
    data.value = await service.getData();
  } catch (err) {
    error.value = "User-friendly message";
    console.error(err);
  } finally {
    loading.value = false;
  }
};
```

---

## Pinia Stores

```js
import { defineStore } from "pinia";
import { ref, computed } from "vue";
import { supabase } from "@/lib/supabase";
export const useAuthStore = defineStore("auth", () => {
  const user = ref(null),
    session = ref(null);
  const isAuthenticated = computed(() => !!user.value);
  const initialize = async () => {
    const { data } = await supabase.auth.getSession();
    session.value = data.session;
    user.value = data.session?.user ?? null;
  };
  const signIn = async (email, password) => {
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    });
    if (error) throw error;
    user.value = data.user;
    session.value = data.session;
  };
  const signOut = async () => {
    await supabase.auth.signOut();
    user.value = null;
    session.value = null;
  };
  return { user, session, isAuthenticated, initialize, signIn, signOut };
});
```

## In components: `const { user, isAuthenticated } = storeToRefs(authStore);`

## TanStack Query (Vue Query)

Caching and offline support. Configured in main.js with `offlineFirst` mode.

### Setup (main.js)

```js
import { VueQueryPlugin } from "@tanstack/vue-query";
const queryClient = new VueQueryPlugin.QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 1000 * 60 * 5,
      gcTime: 1000 * 60 * 60,
      networkMode: "offlineFirst",
    },
    mutations: { networkMode: "offlineFirst" },
  },
});
app.use(VueQueryPlugin, { queryClient });
```

### Composables (src/composables/useRutina.js)

```js
import { useQuery, useMutation, useQueryClient } from "@tanstack/vue-query";
import { rutinaService } from "@/services/rutina";

export function useRutinas() {
  return useQuery({
    queryKey: ["rutinas"],
    queryFn: () => rutinaService.getAll(),
  });
}

export function useRutina(id) {
  return useQuery({
    queryKey: ["rutina", id],
    queryFn: () => rutinaService.getById(id),
    enabled: !!id,
  });
}

export function useCreateRutina() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: (data) => rutinaService.create(data),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["rutinas"] }),
  });
}
```

### Usage in components

```js
const { data: rutinas, isLoading, error } = useRutinas();
const createRutina = useCreateRutina();
await createRutina.mutateAsync({ nombre: "Nueva Rutina" });
```

## TailwindCSS

- Mobile-first: base classes + `md:`/`lg:` for larger
- Use `gap-` for spacing, `p-`/`m-` with scale (1-6, 8, 10, 12, 16...)
- Semantic colors: `bg-white`, `text-gray-900`
- Interactive: `hover:`, `focus:`, `active:` prefixes

```vue
<div class="flex min-h-screen flex-col items-center gap-4 p-4 md:p-8">
  <button class="rounded bg-blue-600 px-4 py-2 text-white hover:bg-blue-700">Action</button>
</div>
```

---

## Routing

```js
const routes = [
  { path: "/", name: "home", component: HomeView },
  { path: "/rutinas", name: "rutinas", component: RutinasView },
  {
    path: "/rutinas/:id",
    name: "rutina-detalle",
    component: RutinaDetalleView,
  },
];
const router = createRouter({ history: createWebHistory(), routes });
router.beforeEach((to, from, next) => {
  const authStore = useAuthStore();
  if (to.meta.requiresAuth && !authStore.isAuthenticated)
    next({ name: "login" });
  else next();
});
```

---

## Security

- Allowed: `SUPABASE_URL`, `SUPABASE_ANON_KEY` (public keys only)
- NEVER expose: service_role, secrets, connection strings
- All tables require RLS policies

---

## Project Structure

```
src/
├── main.js, App.vue, router/index.js
├── views/           # Page components
├── components/      # Reusable components
├── composables/     # TanStack Query composables (useRutina.js)
├── stores/          # Pinia stores
├── services/        # Supabase data layer
└── lib/supabase.js  # Supabase client
```

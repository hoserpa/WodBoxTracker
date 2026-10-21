# WodBoxTracker - AGENTS.md

## Vue 3 SPA with Supabase for gym workout tracking. Stack: Vue 3 (Composition API), Vite, TailwindCSS, Pinia, Supabase.

## Commands

```bash
npm run dev          # Dev server (http://localhost:5173)
npm run build        # Production build
npm run preview      # Preview production build
npm run lint         # ESLint check
npm run lint:fix     # ESLint auto-fix
npm run build        # Production build (CI deploys to gh-pages via .github/workflows/deploy.yml)
node scripts/parse-wods.mjs  # Regenerate public/data/wods.json from wods.txt
```

**Testing** - Vitest NOT installed. Add:

```bash
npm install -D vitest @vue/test-utils jsdom
```

Add to package.json: `"test": "vitest", "test:single": "vitest run"`
Run single test: `npx vitest run src/components/__tests__/MyComponent.test.js`

---

## Code Style

- Language: JavaScript (no TypeScript), ESLint, 2 spaces, semicolons, single quotes
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
  const initAuth = async () => {
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
  return { user, session, isAuthenticated, initAuth, signIn, signOut };
});
```

## In components: `const { user, isAuthenticated } = storeToRefs(authStore);`

## Composables (src/composables/)

Plain `ref` + `try/catch/finally`, no query library. Fetch the WOD catalog once
and share the promise:

```js
// src/composables/useWodDelDia.js
let catalogoPromise = null;
const cargarCatalogo = () => {
  catalogoPromise ??= fetch(`${import.meta.env.BASE_URL}data/wods.json`).then(
    (res) => {
      if (!res.ok) throw new Error("No se pudo cargar el catálogo de WODs");
      return res.json();
    },
  );
  return catalogoPromise;
};
```

The WOD catalog lives in `public/data/wods.json` (not bundled) and is precached
by `public/sw.js`.

## Shared components

- `AppHeader.vue` — logo + options button (`showSettings` prop)
- `BackButton.vue` — back link; `to` (route) or `fallback` (fn), `variant="violet"`
- `RoundStepper.vue` — round counter; emits `change` with `{ campo, valor }`

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
├── composables/     # Data-loading composables (useWodDelDia.js)
├── stores/          # Pinia stores
├── services/        # Supabase data layer
├── utils/           # Pure helpers (wodFormatter.js, rpeCalculator.js)
└── lib/supabase.js  # Supabase client
```

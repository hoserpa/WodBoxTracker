# WodBoxTracker - AGENTS.md

## Project Overview

Vue 3 SPA with Supabase backend for gym workout tracking. Mobile-first design for use during training.

Stack: Vue 3 (Composition API), Vite, TailwindCSS, Pinia, Supabase (Auth + PostgreSQL).

---

## Commands

```bash
npm run dev          # Dev server
npm run build        # Production build
npm run preview      # Preview build
npm run lint         # ESLint
npm run lint:fix     # ESLint auto-fix
```

**Testing** - Vitest is NOT installed. To add:

```bash
npm install -D vitest
```

Add to package.json:

```json
"test": "vitest",
"test:watch": "vitest --watch",
"test:coverage": "vitest --coverage",
"test:single": "vitest run"
```

To run a single test file: `npx vitest run src/components/__tests__/MyComponent.test.js`

---

## Code Style

### General

- Language: JavaScript (no TypeScript)
- Linter: ESLint with Vue 3 config
- Formatter: Prettier (integrated with ESLint)
- Use Composition API with `<script setup>`
- 2 spaces indentation, semicolons, single quotes

### Imports

Use `@/` alias for project paths. Group order: Vue → libraries → stores → services → components.

```js
import { ref, computed } from "vue";
import { useRouter } from "vue-router";
import { supabase } from "@/lib/supabase";
import { useAuthStore } from "@/stores/auth";
import { rutinaService } from "@/services/rutina";
import ExerciseCard from "@/components/ExerciseCard.vue";
```

### Naming

- Components: PascalCase (`ExerciseCard.vue`)
- Stores: camelCase with `use` prefix (`useAuthStore.js`)
- Services: camelCase (`rutinaService.js`)
- Constants: SCREAMING_SNAKE_CASE
- Props/Variables: camelCase

### Vue Components

```vue
<script setup>
import { ref, computed } from "vue";

const props = defineProps({
  routineId: { type: String, required: true },
});

const emit = defineEmits(["update", "delete"]);
const isLoading = ref(false);
</script>

<template>
  <div class="p-4">
    <!-- content -->
  </div>
</template>
```

### Supabase Patterns

```js
const { data, error } = await supabase
  .from("table")
  .select("columns")
  .eq("field", value);

if (error) throw error;
return data;
```

Always handle session null, use RLS on all tables, validate data before sending.

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

## Security

- Allowed in frontend: `SUPABASE_URL`, `SUPABASE_ANON_KEY` (public keys)
- NEVER expose: service_role, connection strings, secrets
- All tables require RLS policies

---

## Project Structure

```
src/
├── main.js
├── App.vue
├── router/
├── views/       # Page components
├── components/  # Reusable components
├── stores/      # Pinia stores
├── services/    # Supabase data layer
└── lib/         # supabase.js client
```

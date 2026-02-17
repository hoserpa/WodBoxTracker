## 📌 Descripción General

Esta aplicación es un sistema web para la gestión y seguimiento de la rutina de gimnasio del usuario.

**Uso principal: Móvil** - La app está diseñada principalmente para uso desde el teléfono móvil durante el entrenamiento.

Su objetivo principal es:

- Mostrar automáticamente la rutina correspondiente al día actual.
- Organizar el entrenamiento de forma estructurada.
- Permitir registrar el peso utilizado en cada ejercicio.
- Facilitar el seguimiento progresivo del entrenamiento.
- Diseño optimizado para pantallas táctiles pequeñas.

La aplicación está desplegada en **GitHub Pages** y utiliza **Supabase** como backend.

---

## 🧠 Modelo de Organización del Entrenamiento

La estructura de la rutina sigue esta jerarquía:

```
Rutina
 └── Semana
      └── Día
           └── Ejercicios
                └── Registro de peso
```

### 📅 Rutina

Representa el programa general de entrenamiento (por ejemplo: Volumen, Definición, Fuerza).

### 📆 Semana

Cada rutina se organiza en semanas numeradas (Semana 1, Semana 2, etc.).

### 🗓 Día

Cada semana contiene varios días de entrenamiento (Día 1, Día 2, Día 3…).

### 🏋️ Ejercicios

Cada día contiene una lista de ejercicios con:

- Nombre del ejercicio
- Series
- Repeticiones
- Observaciones opcionales

---

## 📊 Registro de Peso

Para cada ejercicio, el usuario podrá:

- Anotar el peso utilizado.
- Registrar múltiples series si es necesario.
- Guardar el histórico asociado a su usuario autenticado.
- Consultar progresión futura (extensión prevista).

El registro de peso se almacenará en Supabase y estará protegido mediante políticas RLS para que cada usuario solo pueda acceder a sus propios datos.

---

## 🎯 Objetivo Funcional

La aplicación debe:

- Mostrar automáticamente la rutina correspondiente al día actual.
- Permitir navegar entre semanas y días.
- Permitir registrar y actualizar pesos.
- Mantener historial por usuario.
- Funcionar como SPA estática desplegada en GitHub Pages.

## 📌 Proyecto

Aplicación SPA desplegada en **GitHub Pages** con:

- Frontend y lógica en el mismo repositorio
- Framework: Vue 3
- Estilos: TailwindCSS
- Backend gestionado completamente por Supabase
- Sin API intermedia propia
- Sin servidor personalizado

---

# 🏗️ Arquitectura Oficial

```
[ Vue 3 SPA ]
        │
        ▼[ Supabase Client SDK ]
        │
        ▼[ Supabase Platform ]
   ├─ PostgreSQL
   ├─ Auth
   ├─ Storage (opcional)
   └─ Realtime
```

La aplicación es 100% estática y el backend es proporcionado como servicio.

---

# 🖥️ Stack Tecnológico

## Frontend

- **Vue.js** (Vue 3 – Composition API)
- SPA (Single Page Application)
- Vite para build

## Estilos

- **Tailwind CSS**
- Diseño responsive
- Sistema utilitario
- **Mobile-first**: todas las clases se diseñan primero para móvil

---

# 📱 Diseño Mobile-First (CRÍTICO)

La app está diseñada principalmente para **uso móvil** durante el entrenamiento. Todo el diseño debe priorizar la experiencia en dispositivos móviles.

## Principios

- **Diseño mobile-first**: Comenzar con el diseño móvil y escalar a desktop
- **Toques grandes**: Botones y elementos interactivos mínimos de 44x44px
- **Lectura fácil**: Texto legible sin hacer zoom
- **Navegación simple**: Thumb-friendly, acciones principales al alcance del pulgar
- **Funcionar offline**: Considerar Service Workers para caché básico

## UI/UX

- Usar **Tailwind CSS** con clases mobile-first (`w-full`, `p-4`, etc.)
- Layout vertical para móviles, max-width para desktop
- Inputs tipo number con teclado numérico para pesos
- Feedback visual inmediato en interacciones
- Loading states para operaciones async

## Viewport

```html
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
```

## Backend como Servicio (BaaS)

- **Supabase**
  - PostgreSQL administrado
  - API REST automática
  - SDK oficial
  - Autenticación integrada
  - Row Level Security (RLS)
  - Storage opcional

---

# 🔐 Seguridad (CRÍTICO)

## Permitido en frontend

- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`

Estas son claves públicas diseñadas para usarse en cliente.

---

## Prohibido en frontend

- `service_role`
- Connection strings de PostgreSQL
- Secrets privados
- Tokens administrativos

---

# 🔑 Configuración en Vue

Instalación:

```bash
npm install @supabase/supabase-js
```

Configuración:

```jsx
// src/lib/supabase.jsimport { createClient }from'@supabase/supabase-js'exportconst supabase =createClient(import.meta.env.VITE_SUPABASE_URL,import.meta.env.VITE_SUPABASE_ANON_KEY
)
```

---

# 🛡️ Row Level Security (OBLIGATORIO)

Todas las tablas deben:

1. Tener RLS activado.
2. Tener políticas explícitas definidas.
3. No permitir acceso abierto sin autenticación (salvo que sea intencional).

Ejemplo de política básica:

```sql
create policy "Users can read their own data"on registrosforselectusing (auth.uid()= user_id);
```

---

# 👤 Autenticación

Se utilizará el sistema Auth integrado de Supabase:

- Email + Password
- OAuth opcional
- JWT gestionado automáticamente

El frontend debe:

- Validar sesión activa
- Escuchar cambios de auth
- Proteger rutas privadas

---

# 📁 Estructura del Proyecto

```
/
├── index.html
├── src/
│   ├── main.js
│   ├── App.vue
│   ├── router/
│   ├── components/
│   ├── views/
│   ├── stores/
│   ├── lib/
│   │   └── supabase.js
│   └── services/
│
├──public/
├── tailwind.config.js
├── vite.config.js
└── AGENTS.md
```

---

# 🔄 Flujo de Datos

1. Usuario inicia sesión.
2. Supabase devuelve sesión JWT.
3. Vue mantiene estado reactivo.
4. Las consultas se realizan directamente vía SDK.
5. PostgreSQL aplica RLS.
6. Se devuelven solo datos permitidos.

---

# 🚀 Deploy

## Frontend

1. `npm run build`
2. Subir carpeta `dist/`
3. Activar GitHub Pages

## Backend

Gestionado completamente en Supabase (no requiere despliegue adicional).

---

# 📏 Restricciones Técnicas

- No backend propio.
- No API intermedia.
- No secrets en frontend.
- Todas las reglas de acceso deben vivir en Supabase.
- La seguridad depende de RLS correctamente configurado.

---

# 🎯 Objetivo del Proyecto

Construir una SPA moderna con:

- Vue 3
- TailwindCSS
- Supabase como backend
- Deploy estático en GitHub Pages
- Arquitectura limpia y profesional
- Sin infraestructura personalizada

---

# 🧠 Responsabilidades del Agente

El agente debe:

1. Mantener compatibilidad total con GitHub Pages.
2. No proponer backend adicional.
3. No exponer claves privadas.
4. Configurar correctamente RLS.
5. Diseñar arquitectura escalable.
6. Priorizar seguridad en base de datos.

---

# ⚙️ Comandos de Build, Lint y Test

## Comandos principales

```bash
npm run dev          # Iniciar servidor de desarrollo
npm run build        # Generar build de producción
npm run preview      # Preview del build de producción
npm run lint         # Ejecutar linter (ESLint)
npm run lint:fix     # Ejecutar linter y corregir errores automáticamente
```

## Testing (Vitest)

```bash
npm run test               # Ejecutar todos los tests
npm run test:watch        # Ejecutar tests en modo watch
npm run test:coverage     # Ejecutar tests con coverage
npm run test:single <file> # Ejecutar un solo archivo de test
```

---

# 📝 Guías de Estilo de Código

## Configuración del proyecto

- **Linter**: ESLint con configuración Vue 3
- **Formatter**: Prettier integrado con ESLint
- **Testing**: Vitest
- **TypeScript**: Configuración Strict

## Imports

- Usar imports absolutos desde `@/` para rutas del proyecto
- Agrupar imports en orden: Vue imports → Bibliotecas externas → Componentes internos → Utilidades
- Preferir imports con nombre en lugar de default exports

```jsx
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { supabase } from '@/lib/supabase'
import { formatDate } from '@/utils/date'
import ExerciseCard from '@/components/ExerciseCard.vue'
```

## Formato y Estructura

- Usar **Composition API** con `<script setup>`
- 2 espacios para indentación
- Punto y coma al final deStatements
- Comillas simples para strings
- Una línea en blanco entre imports y resto del código

## Nombramiento

- **Componentes**: PascalCase (`ExerciseCard.vue`, `WeightInput.vue`)
- **Utilidades/Composables**: camelCase con prefijo `use` (`useAuth.js`, `useWorkoutStore.js`)
- **Constantes**: SCREAMING_SNAKE_CASE
- **Props**: camelCase, usar TypeScript types cuando sea posible
- **Eventos**: kebab-case (emitir) / camelCase (manejar)

```jsx
// Componente
const props = defineProps<{
  exerciseName: string
  sets: number
}>()

const emit = defineEmits<{
  (e: 'weight-updated', weight: number): void
}>()
```

## TypeScript

- Usar **TypeScript** en todos los archivos nuevos
- Definir interfaces/types para datos de Supabase
- Usar `type` para tipos unions/aliases, `interface` para objetos

```typescript
interface WorkoutExercise {
  id: string
  name: string
  sets: number
  reps: number
  weight?: number
}

type WorkoutDay = 'A' | 'B' | 'C'
```

## Manejo de Errores

- Usar try/catch con mensajes descriptivos para operaciones async
- Mostrar feedback al usuario mediante toast/notifications
- No exponer errores técnicos sensibles al usuario

```typescript
async function saveWeight(exerciseId: string, weight: number) {
  try {
    const { error } = await supabase
      .from('registros')
      .insert({ ejercicio_id: exerciseId, peso: weight })
    
    if (error) throw error
    
    showSuccess('Peso guardado correctamente')
  } catch (error) {
    console.error('Error guardando peso:', error)
    showError('No se pudo guardar el peso')
  }
}
```

## Vue Components

- Props con defaults usando factory function para objetos/arrays
- Usar `v-model` con `.trim` y `.number` modifiers cuando corresponda
- Componentes pequeños y reutilizables (máximo ~200 líneas)
- Separar lógica compleja en composables

## Supabase

- Siempre manejar el caso de sesión null
- Usar Row Level Security en todas las tablas
- Validar datos antes de enviar a Supabase
- Preferir consultas tipadas con TypeScript

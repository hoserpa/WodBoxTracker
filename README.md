# WodBox Tracker

App web para la gestión y seguimiento de rutinas de gimnasio.

## Uso Principal: Móvil

Diseñado para uso desde el teléfono móvil durante el entrenamiento.

## Características

- Autenticación con Supabase
- Seguimiento de peso por ejercicio
- Diseño mobile-first
- Desplegado en GitHub Pages

## Tech Stack

- Vue 3 + Vite
- Tailwind CSS
- Supabase (Auth + Database)

## Desarrollo

```bash
npm install
npm run dev
```

## Build

```bash
npm run build
```

Cómo calcular el RPE según tu RM

Primero necesitas tu 1RM (una repetición máxima) en un ejercicio.

Ejemplo:
Si tu 1RM en sentadilla es 100 kg, usamos esta tabla aproximada:

% del 1RM Reps posibles RPE aproximado
100% 1 10
95% 2 9.5
92% 3 9
89% 4 8.5
86% 5 8
83% 6 7.5
80% 7 7
75% 8–9 6–7

🎯 Ejemplo práctico

Si tu 1RM es 100 kg y quieres entrenar a RPE 8 en 5 repeticiones:

5 reps a RPE 8 ≈ 86%

86% de 100 kg = 86 kg

👉 Entonces deberías usar aproximadamente 85–87 kg.

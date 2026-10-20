# Esquema de Base de Datos - WodBoxTracker

Este documento describe el esquema completo de la base de datos PostgreSQL (Supabase) utilizado por WodBoxTracker. Está pensado para que un agente de IA externo pueda entender la estructura, relaciones y formato correcto para procesar un nuevo PDF con una rutina de fuerza e insertarla correctamente.

## Configuración

- **Base de datos**: PostgreSQL (Supabase)
- **Autenticación**: Supabase Auth (`auth.users`)
- **Row Level Security (RLS)**: Habilitado en la mayoría de las tablas
- **Idioma**: Los nombres de tablas/columnas están en español

## Diagrama de Relaciones

```text
auth.users (Supabase Auth)
    ├── rutinas (user_id nullable -> plantillas con user_id NULL)
    │   ├── semanas
    │   │   └── dias
    │   │       └── series
    │   │           ├── registros (por usuario)
    │   │           └── dias_completados (por usuario)
    ├── user_rm
    ├── halterofilia_entrenamientos
    │   └── halterofilia_ejercicios
    │       └── halterofilia_rondas
    └── admins

tipos_ejercicio ──┐
                 ├── ejercicios
                 │   └── exercise_details (1:N vía exercise_detail_id)
                 └── series.tipo_ejercicio (ENUM)

wod_diario (global, por fecha)
```

## Enum Types

### `tipo_ejercicio`
```sql
CREATE TYPE tipo_ejercicio AS ENUM ('calentamiento', 'principal', 'secundario', 'core', 'halterofilia');
```

## Tablas

### 1. `tipos_ejercicio`
Catálogo de tipos de ejercicio.

| Columna | Tipo | Constraints | Descripción |
|---------|------|-------------|-------------|
| `id` | SERIAL | PRIMARY KEY | Identificador único |
| `nombre` | TEXT | NOT NULL, UNIQUE | Nombre del tipo |

**Ejemplo de registro:**
```sql
INSERT INTO tipos_ejercicio (nombre) VALUES ('principal');
-- id: 2, nombre: 'principal'
```

---

### 2. `ejercicios`
Catálogo de ejercicios. Puede ser global (catálogo base) o privado por usuario.

| Columna | Tipo | Constraints | Descripción |
|---------|------|-------------|-------------|
| `id` | SERIAL | PRIMARY KEY | Identificador único |
| `nombre` | TEXT | NOT NULL | Nombre del ejercicio |
| `tipo_id` | INTEGER | REFERENCES tipos_ejercicio(id) | Tipo de ejercicio |
| `url` | TEXT | NULL | URL opcional con información/demostración |
| `user_id` | UUID | REFERENCES auth.users(id) ON DELETE CASCADE, DEFAULT auth.uid() | NULL = catálogo global (solo admins), UUID = ejercicio privado del usuario |
| `exercise_detail_id` | VARCHAR(10) | REFERENCES exercise_details(id) | Relación con detalles del ejercicio |

**Restricciones únicas:**
- Global: `UNIQUE(LOWER(nombre)) WHERE user_id IS NULL`
- Por usuario: `UNIQUE(LOWER(nombre), user_id) WHERE user_id IS NOT NULL`

**Políticas RLS:**
- SELECT: `user_id IS NULL OR user_id = auth.uid()` (leer catálogo global y propios)
- INSERT: `user_id = auth.uid() OR (es_admin() AND user_id IS NULL)`
- UPDATE/DELETE: Propios o globales si es admin

**Ejemplo de registro:**
```sql
-- Ejercicio global (catálogo base)
INSERT INTO ejercicios (nombre, tipo_id, user_id) 
VALUES ('BACK SQUAT', 2, NULL);
-- id: 172, nombre: 'BACK SQUAT', tipo_id: 2, url: null, user_id: null, exercise_detail_id: null

-- Ejercicio privado de usuario
INSERT INTO ejercicios (nombre, tipo_id, user_id) 
VALUES ('MI EJERCICIO CUSTOM', 2, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11');
-- id: 200, nombre: 'MI EJERCICIO CUSTOM', tipo_id: 2, user_id: 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'
```

---

### 3. `exercise_details`
Tabla de referencia con detalles de ejercicios (imágenes/información). Solo lectura para usuarios autenticados.

| Columna | Tipo | Constraints | Descripción |
|---------|------|-------------|-------------|
| `id` | VARCHAR(10) | PRIMARY KEY | Identificador único (formato string) |
| (otras columnas) | - | - | Ver archivos en `import_bd/exercise_details/` |

**Políticas RLS:** SELECT para authenticated con `USING(true)`

**Ejemplo de registro:**
```sql
-- Ejemplo genérico (estructura real en exercise_details_*.sql)
INSERT INTO exercise_details (id, ...) VALUES ('ED0001', ...);
```

---

### 4. `rutinas`
Rutinas de entrenamiento. Pueden ser plantillas globales o creadas por el usuario.

| Columna | Tipo | Constraints | Descripción |
|---------|------|-------------|-------------|
| `id` | SERIAL | PRIMARY KEY | Identificador único |
| `nombre` | TEXT | NOT NULL | Nombre de la rutina |
| `descripcion` | TEXT | NULL | Descripción de la rutina |
| `created_at` | TIMESTAMPTZ | DEFAULT NOW() | Fecha de creación |
| `user_id` | UUID | REFERENCES auth.users(id) DEFAULT auth.uid() | NULL = plantilla global, UUID = rutina del usuario |

**Políticas RLS:**
- SELECT: `auth.uid() = user_id OR user_id IS NULL` (propias o plantillas)
- INSERT: `auth.uid() = user_id` (solo propias)
- UPDATE/DELETE: `auth.uid() = user_id` (solo propias)

**Ejemplo de registro:**
```sql
-- Plantilla global
INSERT INTO rutinas (nombre, descripcion, user_id) 
VALUES ('FUERZA AVANZADO 2', 'Rutina de fuerza avanzada - 8 semanas, 3 dias por semana, SIN ejercicios core', NULL);
-- id: 1

-- Rutina creada por usuario
INSERT INTO rutinas (nombre, descripcion, user_id) 
VALUES ('MI RUTINA PERSONALIZADA', 'Rutina creada desde PDF', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11');
-- id: 3
```

---

### 5. `semanas`
Semanas dentro de una rutina.

| Columna | Tipo | Constraints | Descripción |
|---------|------|-------------|-------------|
| `id` | SERIAL | PRIMARY KEY | Identificador único |
| `rutina_id` | INTEGER | NOT NULL, REFERENCES rutinas(id) ON DELETE CASCADE | Rutina a la que pertenece |
| `numero` | INTEGER | NOT NULL | Número de semana (1, 2, 3...) |
| `created_at` | TIMESTAMPTZ | DEFAULT NOW() | Fecha de creación |

**Políticas RLS:** Heredadas de la rutina padre (se puede leer si la rutina es propia o plantilla; solo se puede insertar/actualizar/eliminar en rutinas propias del usuario)

**Ejemplo de registro:**
```sql
INSERT INTO semanas (rutina_id, numero) VALUES (3, 1);
-- id: 17, rutina_id: 3, numero: 1
```

---

### 6. `dias`
Días dentro de una semana.

| Columna | Tipo | Constraints | Descripción |
|---------|------|-------------|-------------|
| `id` | SERIAL | PRIMARY KEY | Identificador único |
| `semana_id` | INTEGER | NOT NULL, REFERENCES semanas(id) ON DELETE CASCADE | Semana a la que pertenece |
| `numero` | INTEGER | NOT NULL | Número de día dentro de la semana (1, 2, 3...) |
| `nombre` | TEXT | NULL | Nombre descriptivo del día |
| `created_at` | TIMESTAMPTZ | DEFAULT NOW() | Fecha de creación |

**Políticas RLS:** Heredadas de rutina -> semana

**Ejemplo de registro:**
```sql
INSERT INTO dias (semana_id, numero, nombre) VALUES (17, 1, 'Día 1');
-- id: 49, semana_id: 17, numero: 1, nombre: 'Día 1'
```

---

### 7. `series`
Series/ejercicios programados para un día concreto.

| Columna | Tipo | Constraints | Descripción |
|---------|------|-------------|-------------|
| `id` | SERIAL | PRIMARY KEY | Identificador único |
| `dia_id` | INTEGER | NOT NULL, REFERENCES dias(id) ON DELETE CASCADE | Día al que pertenece |
| `ejercicio_id` | INTEGER | NOT NULL, REFERENCES ejercicios(id) | Ejercicio a realizar |
| `series` | INTEGER | NOT NULL | Número de series |
| `repeticiones` | TEXT | NOT NULL | Repeticiones (puede ser "3-5", "5", "AMRAP", etc.) |
| `observaciones` | TEXT | NULL | Notas/observaciones para el ejercicio |
| `tipo_ejercicio` | tipo_ejercicio | NOT NULL | Tipo: calentamiento/principal/secundario/core/halterofilia |
| `orden` | INTEGER | NOT NULL DEFAULT 0 | Orden de aparición en el día |
| `created_at` | TIMESTAMPTZ | DEFAULT NOW() | Fecha de creación |

**Políticas RLS:** Heredadas de rutina -> semana -> día

**Ejemplo de registro:**
```sql
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden)
VALUES (49, 172, 5, '3', 'RPE 7-8, pausa 3-4 min', 'principal', 1);
-- id: 1500, dia_id: 49, ejercicio_id: 172 (BACK SQUAT), series: 5, repeticiones: '3', tipo_ejercicio: 'principal', orden: 1
```

---

### 8. `registros`
Registro de peso utilizado por el usuario en cada serie.

| Columna | Tipo | Constraints | Descripción |
|---------|------|-------------|-------------|
| `id` | SERIAL | PRIMARY KEY | Identificador único |
| `serie_id` | INTEGER | NOT NULL, REFERENCES series(id) ON DELETE CASCADE | Serie a la que corresponde el registro |
| `user_id` | UUID | REFERENCES auth.users(id) DEFAULT auth.uid() | Usuario que registra el peso |
| `peso` | NUMERIC(6,2) | NULL | Peso utilizado (kg) |
| `fecha` | DATE | DEFAULT CURRENT_DATE | Fecha del registro |
| `created_at` | TIMESTAMPTZ | DEFAULT NOW() | Fecha/hora de creación |

**Políticas RLS:** Solo el propio usuario (`auth.uid() = user_id`)

**Ejemplo de registro:**
```sql
INSERT INTO registros (serie_id, user_id, peso, fecha)
VALUES (1500, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 95.50, '2026-10-20');
-- id: 5000
```

---

### 9. `dias_completados`
Seguimiento de días completados por usuario.

| Columna | Tipo | Constraints | Descripción |
|---------|------|-------------|-------------|
| `id` | SERIAL | PRIMARY KEY | Identificador único |
| `dia_id` | INTEGER | NOT NULL, REFERENCES dias(id) ON DELETE CASCADE | Día completado |
| `user_id` | UUID | REFERENCES auth.users(id) DEFAULT auth.uid() | Usuario |
| `completado` | BOOLEAN | DEFAULT TRUE | Estado de completado |
| `fecha` | DATE | DEFAULT CURRENT_DATE | Fecha de completado |
| `created_at` | TIMESTAMPTZ | DEFAULT NOW() | Fecha/hora de creación |

**Constraint único:** `UNIQUE(dia_id, user_id)`

**Políticas RLS:** Solo el propio usuario

**Ejemplo de registro:**
```sql
INSERT INTO dias_completados (dia_id, user_id, completado, fecha)
VALUES (49, 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', true, '2026-10-20');
-- id: 200
```

---

### 10. `user_rm`
Récords personales (1RM) por usuario y ejercicio.

| Columna | Tipo | Constraints | Descripción |
|---------|------|-------------|-------------|
| `id` | SERIAL | PRIMARY KEY | Identificador único |
| `user_id` | UUID | REFERENCES auth.users(id) NOT NULL | Usuario |
| `ejercicio_id` | INTEGER | REFERENCES ejercicios(id) NOT NULL | Ejercicio |
| `rm` | NUMERIC | NOT NULL | Valor del RM |
| `fecha` | TIMESTAMPTZ | DEFAULT NOW() | Fecha del registro |
| `notas` | TEXT | NULL | Notas opcionales |

**Constraint único:** `UNIQUE(user_id, ejercicio_id)`

**Políticas RLS:** Solo el propio usuario (`auth.uid() = user_id`)

**Ejemplo de registro:**
```sql
INSERT INTO user_rm (user_id, ejercicio_id, rm, notas)
VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 172, 110.0, '1RM estimado tras 5x3 @95kg');
-- id: 1
```

---

### 11. `admins`
Tabla de administradores del sistema.

| Columna | Tipo | Constraints | Descripción |
|---------|------|-------------|-------------|
| `user_id` | UUID | PRIMARY KEY, REFERENCES auth.users(id) ON DELETE CASCADE | Usuario administrador |
| `created_at` | TIMESTAMPTZ | DEFAULT NOW() | Fecha de asignación |

**Función auxiliar:** `public.es_admin()` retorna BOOLEAN (SECURITY DEFINER)

**Políticas RLS:** Solo puede leer su propia fila

**Ejemplo de registro:**
```sql
INSERT INTO admins (user_id) VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11');
```

---

### 12. `halterofilia_entrenamientos`
Entrenamientos de halterofilia (sistema alternativo al de rutinas/series).

| Columna | Tipo | Constraints | Descripción |
|---------|------|-------------|-------------|
| `id` | SERIAL | PRIMARY KEY | Identificador único |
| `user_id` | UUID | REFERENCES auth.users(id) DEFAULT auth.uid() | Usuario propietario |
| `fecha` | TIMESTAMPTZ | DEFAULT NOW() | Fecha del entrenamiento |
| `notas` | TEXT | NULL | Notas del entrenamiento |

**Políticas RLS:** Solo el propio usuario

**Ejemplo de registro:**
```sql
INSERT INTO halterofilia_entrenamientos (user_id, notas)
VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Sesión de halterofilia - enfoque en arranque');
-- id: 1
```

---

### 13. `halterofilia_ejercicios`
Ejercicios dentro de un entrenamiento de halterofilia.

| Columna | Tipo | Constraints | Descripción |
|---------|------|-------------|-------------|
| `id` | SERIAL | PRIMARY KEY | Identificador único |
| `entrenamiento_id` | INTEGER | NOT NULL, REFERENCES halterofilia_entrenamientos(id) ON DELETE CASCADE | Entrenamiento al que pertenece |
| `ejercicio_id` | INTEGER | NOT NULL, REFERENCES ejercicios(id) | Ejercicio |
| `orden` | INTEGER | NOT NULL DEFAULT 0 | Orden de aparición |

**Políticas RLS:** Solo si el entrenamiento pertenece al usuario

**Ejemplo de registro:**
```sql
INSERT INTO halterofilia_ejercicios (entrenamiento_id, ejercicio_id, orden)
VALUES (1, 172, 1);
-- id: 1
```

---

### 14. `halterofilia_rondas`
Rondas/series dentro de un ejercicio de halterofilia.

| Columna | Tipo | Constraints | Descripción |
|---------|------|-------------|-------------|
| `id` | SERIAL | PRIMARY KEY | Identificador único |
| `ejercicio_entrenamiento_id` | INTEGER | NOT NULL, REFERENCES halterofilia_ejercicios(id) ON DELETE CASCADE | Ejercicio de halterofilia al que pertenece |
| `repeticiones` | INTEGER | NOT NULL | Número de repeticiones |
| `series` | INTEGER | NOT NULL | Número de series |
| `porcentaje` | INTEGER | NOT NULL | Porcentaje del RM a utilizar |
| `peso` | NUMERIC(6,2) | NULL | Peso calculado/utilizado |
| `orden` | INTEGER | NOT NULL DEFAULT 0 | Orden de aparición |

**Políticas RLS:** Solo si el entrenamiento pertenece al usuario

**Ejemplo de registro:**
```sql
INSERT INTO halterofilia_rondas (ejercicio_entrenamiento_id, repeticiones, series, porcentaje, peso, orden)
VALUES (1, 3, 5, 85, 93.5, 1);
-- id: 1
```

---

### 15. `wod_diario`
WOD del día global para todos los usuarios. Gestionado por función `obtener_wod_del_dia()`.

| Columna | Tipo | Constraints | Descripción |
|---------|------|-------------|-------------|
| `fecha` | DATE | PRIMARY KEY | Fecha del WOD |
| `wod_id` | BIGINT | NOT NULL | ID del WOD seleccionado del catálogo (wods.json) |
| `created_at` | TIMESTAMPTZ | NOT NULL DEFAULT NOW() | Fecha/hora de creación |

**Políticas RLS:** SELECT para authenticated con `USING(true)`

**Funcionamiento:** La función selecciona aleatoriamente un WOD no usado anteriormente. Cuando se han usado todos (actualmente `total_wods = 5168`), reinicia el ciclo borrando la tabla.

**Ejemplo de registro:**
```sql
INSERT INTO wod_diario (fecha, wod_id) VALUES ('2026-10-20', 1234);
```

**Uso:**
```sql
SELECT * FROM obtener_wod_del_dia();
-- Retorna: (wod_fecha, wod_elegido)
```

## Índices

```sql
CREATE INDEX IF NOT EXISTS idx_semanas_rutina ON semanas(rutina_id);
CREATE INDEX IF NOT EXISTS idx_dias_semana ON dias(semana_id);
CREATE INDEX IF NOT EXISTS idx_series_dia ON series(dia_id);
CREATE INDEX IF NOT EXISTS idx_series_ejercicio ON series(ejercicio_id);
CREATE INDEX IF NOT EXISTS idx_registros_serie ON registros(serie_id);
CREATE INDEX IF NOT EXISTS idx_registros_user ON registros(user_id);
CREATE INDEX IF NOT EXISTS idx_dias_completados_dia ON dias_completados(dia_id);
CREATE INDEX IF NOT EXISTS idx_dias_completados_user ON dias_completados(user_id);
```

## Guía para el Agente IA (Procesar PDF de Nueva Rutina de Fuerza)

Cuando proceses un PDF con una nueva rutina de fuerza para insertar en Supabase, sigue estos pasos:

### 1. Identificar estructura del PDF
Extrae: nombre de rutina, descripción, número de semanas, días por semana, ejercicios por día con series/repeticiones/observaciones/tipo.

### 2. Preparar IDs necesarios
- **Usuario**: Necesitarás `auth.uid()` del usuario o `user_id` UUID. Las rutinas creadas por usuarios deben tener `user_id` = UUID del usuario (NO NULL).
- **Ejercicios**: Busca ejercicios existentes en `ejercicios`. Si no existe, crea uno nuevo con `user_id = auth.uid()` (será privado). Usa `tipo_id` correcto según `tipos_ejercicio`.
- **Tipos**: Mapea a `tipo_ejercicio` enum: `calentamiento`, `principal`, `secundario`, `core`, `halterofilia`.

### 3. Orden de inserción (respetando FKs)
```sql
-- 1. Crear rutina
INSERT INTO rutinas (nombre, descripcion, user_id) VALUES (...) RETURNING id;

-- 2. Crear semanas
INSERT INTO semanas (rutina_id, numero) VALUES (...) RETURNING id;

-- 3. Crear días
INSERT INTO dias (semana_id, numero, nombre) VALUES (...) RETURNING id;

-- 4. Crear series
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden)
VALUES (...) RETURNING id;
```

### 4. Recomendaciones importantes
- **Orden**: Usa `orden` incremental (0, 1, 2...) para mantener el orden de ejercicios tal como aparece en el PDF.
- **Repeticiones**: Puede ser texto libre ("3-5", "5 x 5", "AMRAP", "1-2"). El campo es `TEXT` NOT NULL.
- **Ejercicios no existentes**: Si creas ejercicios nuevos, siempre asigna `user_id = auth.uid()` para que sean privados. No uses `user_id = NULL` a menos que seas admin creando para el catálogo global.
- **RLS**: Las políticas ya están configuradas. Al insertar desde la app autenticada con el `user_id` correcto, funcionará. Desde SQL Editor sin contexto de auth, hay que tener cuidado con `DEFAULT auth.uid()`.
- **Plantillas**: Las plantillas globales tienen `user_id = NULL`. NO modifiques plantillas globales, crea siempre una copia para el usuario.
- **`dias_completados` y `registros`**: Estos se crean por el usuario desde la app, NO al importar la rutina.

### 5. Ejemplo completo de inserción

```sql
-- Asumiendo user_id = 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11'

-- 1. Rutina
INSERT INTO rutinas (nombre, descripcion, user_id)
VALUES ('RUTINA FUERZA PDF - OCTUBRE 2026', 'Importada desde PDF', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11')
RETURNING id; -- obtener rutina_id = 10

-- 2. Semana 1
INSERT INTO semanas (rutina_id, numero) VALUES (10, 1) RETURNING id; -- semana_id = 25

-- 3. Día 1
INSERT INTO dias (semana_id, numero, nombre) VALUES (25, 1, 'Día 1 - Fuerza') RETURNING id; -- dia_id = 70

-- 4. Series
-- Buscar ejercicio_id para BACK SQUAT
-- INSERTAR series
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden)
VALUES 
  (70, 172, 5, '3', 'RPE 7-8, 3-4 min descanso', 'principal', 0),
  (70, 173, 4, '4-5', 'RPE 7, 2-3 min descanso', 'principal', 1),
  (70, 180, 3, '8-10', '2-2.5 min descanso', 'secundario', 2);
```

## Archivos SQL de referencia

- `import_bd/import_bd.sql` - Esquema base, RLS inicial, datos de plantillas
- `supabase/rls_seguridad.sql` - Endurecimiento RLS, sistema de admins, ejercicios privados
- `import_bd/create_user_rm.sql` - Tabla user_rm
- `import_bd/halterofilia_entrenamiento.sql` - Sistema halterofilia
- `supabase/wod_diario.sql` - Sistema WOD del día
- `import_bd/add_exercise_detail_id.sql` - Relación con exercise_details
- `import_bd/ejercicios_faltantes.sql` - Ejercicios adicionales
- `import_bd/exercise_details/` - Detalles de ejercicios
- Archivos `fuerza*.sql` - Datos de las rutinas plantilla existentes

---

**Nota:** Este esquema refleja el estado actual del proyecto. Al procesar un PDF, asegúrate de respetar las políticas RLS y las relaciones FK. Las rutinas importadas deben pertenecer al usuario (`user_id` no NULL).

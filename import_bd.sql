-- =====================================================
-- BASE DE DATOS WODBOX TRACKER
-- Estructura basada en Rutinas.txt
-- =====================================================

-- =====================================================
-- TABLAS
-- =====================================================

-- Rutinas: Programas de entrenamiento principales
CREATE TABLE rutinas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Semanas: Semanas dentro de una rutina
CREATE TABLE semanas (
    id SERIAL PRIMARY KEY,
    rutina_id INTEGER NOT NULL REFERENCES rutinas(id) ON DELETE CASCADE,
    numero INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(rutina_id, numero)
);

-- Dias: Días de entrenamiento dentro de una semana
CREATE TABLE dias (
    id SERIAL PRIMARY KEY,
    semana_id INTEGER NOT NULL REFERENCES semanas(id) ON DELETE CASCADE,
    numero INTEGER NOT NULL,
    nombre VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(semana_id, numero)
);

-- Tipos de ejercicio
CREATE TABLE tipos_ejercicio (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

-- Ejercicios: Catálogo de ejercicios
CREATE TABLE ejercicios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    tipo_id INTEGER REFERENCES tipos_ejercicio(id),
    descripcion TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Series: Configuración de series/repeticiones por ejercicio/día
CREATE TABLE series (
    id SERIAL PRIMARY KEY,
    dia_id INTEGER NOT NULL REFERENCES dias(id) ON DELETE CASCADE,
    ejercicio_id INTEGER NOT NULL REFERENCES ejercicios(id) ON DELETE CASCADE,
    tipo_ejercicio VARCHAR(50) NOT NULL, -- 'calentamiento', 'principal', 'secundario', 'core'
    orden INTEGER NOT NULL DEFAULT 0,
    sets INTEGER NOT NULL,
    reps INTEGER NOT NULL,
    tempo VARCHAR(20),
    rir INTEGER,
    rpe INTEGER,
    observaciones TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Registros: Registro de peso por usuario
CREATE TABLE registros (
    id SERIAL PRIMARY KEY,
    user_id UUID NOT NULL, -- UUID del usuario en Supabase Auth
    serie_id INTEGER NOT NULL REFERENCES series(id) ON DELETE CASCADE,
    peso DECIMAL(6, 2),
    reps_completadas INTEGER,
    fecha TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =====================================================
-- DATOS INICIALES
-- =====================================================

-- Tipos de ejercicio
INSERT INTO tipos_ejercicio (nombre, descripcion) VALUES
    ('calentamiento', 'Ejercicios de calentamiento y movilidad'),
    ('principal', 'Ejercicios principales de la rutina'),
    ('secundario', 'Ejercicios secundarios de apoyo'),
    ('core', 'Ejercicios de core y estabilidad');

-- Rutinas
INSERT INTO rutinas (nombre, descripcion) VALUES
    ('FUERZA AVANZADO 2', 'Programa de fuerza avanzado - 8 semanas'),
    ('FUERZA AVANZADO 3 HIPERTROFIA', 'Programa de hipertrofia avanzada - 8 semanas');

-- =====================================================
-- RUTINA: FUERZA AVANZADO 2 (id=1)
-- =====================================================

-- Semanas 1-8 para Fuerza Avanzado 2
INSERT INTO semanas (rutina_id, numero) VALUES
    (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8);

-- Días para cada semana (3 días por semana)
-- Semana 1 (semana_id=1)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (1, 1, 'Día 1'),
    (1, 2, 'Día 2'),
    (1, 3, 'Día 3');
-- Semana 2 (semana_id=2)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (2, 1, 'Día 1'),
    (2, 2, 'Día 2'),
    (2, 3, 'Día 3');
-- Semana 3 (semana_id=3)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (3, 1, 'Día 1'),
    (3, 2, 'Día 2'),
    (3, 3, 'Día 3');
-- Semana 4 (semana_id=4)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (4, 1, 'Día 1'),
    (4, 2, 'Día 2'),
    (4, 3, 'Día 3');
-- Semana 5 (semana_id=5)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (5, 1, 'Día 1'),
    (5, 2, 'Día 2'),
    (5, 3, 'Día 3');
-- Semana 6 (semana_id=6)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (6, 1, 'Día 1'),
    (6, 2, 'Día 2'),
    (6, 3, 'Día 3');
-- Semana 7 (semana_id=7)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (7, 1, 'Día 1'),
    (7, 2, 'Día 2'),
    (7, 3, 'Día 3');
-- Semana 8 (semana_id=8)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (8, 1, 'Día 1'),
    (8, 2, 'Día 2'),
    (8, 3, 'Día 3');

-- =====================================================
-- RUTINA: FUERZA AVANZADO 3 HIPERTROFIA (id=2)
-- =====================================================

-- Semanas 1-8 para Hipertrofia
INSERT INTO semanas (rutina_id, numero) VALUES
    (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8);

-- Días semanas 9-16 (Hipertrofia)
-- Semana 1 Hipertrofia (semana_id=9)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (9, 1, 'Día 1'),
    (9, 2, 'Día 2');
-- Semana 2 (semana_id=10)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (10, 1, 'Día 1'),
    (10, 2, 'Día 2');
-- Semana 3 (semana_id=11)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (11, 1, 'Día 1'),
    (11, 2, 'Día 2');
-- Semana 4 (semana_id=12)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (12, 1, 'Día 1'),
    (12, 2, 'Día 2');
-- Semana 5 (semana_id=13)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (13, 1, 'Día 1'),
    (13, 2, 'Día 2');
-- Semana 6 (semana_id=14)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (14, 1, 'Día 1'),
    (14, 2, 'Día 2');
-- Semana 7 (semana_id=15)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (15, 1, 'Día 1'),
    (15, 2, 'Día 2');
-- Semana 8 (semana_id=16)
INSERT INTO dias (semana_id, numero, nombre) VALUES
    (16, 1, 'Día 1'),
    (16, 2, 'Día 2');

-- =====================================================
-- EJERCICIOS CATÁLOGO
-- =====================================================

-- Ejercicios principales
INSERT INTO ejercicios (nombre, tipo_id) VALUES
    ('BACK SQUAT', 2),
    ('PULL UP', 2),
    ('DL', 2),
    ('PRESS DE BANCA', 2),
    ('SHOULDER PRESS', 2),
    ('FRONT SQUAT', 2),
    ('HIP THRUST', 3);

-- Ejercicios secundarios
INSERT INTO ejercicios (nombre, tipo_id) VALUES
    ('SEATED DB SHOULDER PRESS ALTERNO', 3),
    ('TRICEP KICKBACK EXTENSION', 3),
    ('COPENHAGEN HIP ABDUCTION HOLD', 3),
    ('BULGARIAN SQUAT', 3),
    ('BAR ROW', 3),
    ('CURL DE BICEP', 3),
    ('ALTERNATING DUMBBELL FLOOR PRESS', 3),
    ('KB ONE ARM ROW', 3),
    ('KB RDL', 3),
    ('BANDED TRICEPS EXTENSION', 3),
    ('BAND GLUTE KICKBACK', 3),
    ('KB SPLIT SQUAT', 3),
    ('FLEXO-EXTENSION DE GEMELOS', 3);

-- Ejercicios de core
INSERT INTO ejercicios (nombre, tipo_id) VALUES
    ('HOLLOW HOLD', 4),
    ('ARCH HOLD', 4),
    ('LATERAL SIDE PLANK', 4),
    ('AB WHEEL', 4);

-- Ejercicios de calentamiento
INSERT INTO ejercicios (nombre, tipo_id) VALUES
    ('HALF-KNEELING LOADED DORSIFLEXION', 1),
    ('CAT CAMEL', 1),
    ('KB HALO', 1),
    ('WALL SQUAT HOLD', 1),
    ('KB PLANK HAND TAPS', 1),
    ('ELEVACION Y DEPRESION ESCAPULAR', 1),
    ('WALL ANGEL', 1),
    ('PVC THORACIC EXTENSION ON THE WALL', 1),
    ('PVC FRONT RACK OPENER', 1),
    ('DEAD BUG', 1),
    ('QUADRUPED HIP ROCKING', 1),
    ('KB TATER', 1),
    ('BANDED SQUAT', 1),
    ('PULLS APART', 1),
    ('WALL LEANING DOUBLE LEG CALF RAISE', 1),
    ('DORSIFLEXION TOBILLO', 1),
    ('SPIDERMAN', 1),
    ('KB HIP OPENER', 1),
    ('BOX SHOULDER STRETCH', 1),
    ('PNF TO IMPROVE ANKLE DORSIFLEXION', 1),
    ('BOX QUAD T-SPINE ROT', 1),
    ('KB GOOD MORNING', 1),
    ('PLATE ROMANIAN DEADLIFT', 1),
    ('KNEELING HIP FLEXOR STRETCH', 1),
    ('PIRIFORMIS STRETCH FOR HIPS', 1),
    ('SCAPULAR PUSH UP', 1),
    ('RUN', 1),
    ('JUMPING JACK', 1);

-- =====================================================
-- SERIES - RUTINA: FUERZA AVANZADO 2
-- =====================================================

-- =====================================================
-- DÍA 1 - SEMANA 1 (dia_id=1)
-- =====================================================

-- Ejercicios principales
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (1, 1, 'principal', 1, 1, 5, '3-1-X-1', 4, 6),
    (1, 1, 'principal', 2, 1, 5, '3-1-X-1', 3, 7),
    (1, 1, 'principal', 3, 3, 5, '3-1-X-1', 2, 8),
    (1, 2, 'principal', 4, 1, 5, '2-1-X-1', 4, 6),
    (1, 2, 'principal', 5, 1, 5, '2-1-X-1', 3, 7),
    (1, 2, 'principal', 6, 3, 5, '2-1-X-1', 2, 8);

-- Ejercicios secundarios
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (1, 7, 'secundario', 1, 1, 8, '2-1-X-1', 4, 6),
    (1, 7, 'secundario', 2, 1, 8, '2-1-X-1', 3, 7),
    (1, 7, 'secundario', 3, 2, 8, '2-1-X-1', 2, 8),
    (1, 8, 'secundario', 4, 1, 8, '2-1-X-1', 4, 6),
    (1, 8, 'secundario', 5, 1, 8, '2-1-X-1', 3, 7),
    (1, 8, 'secundario', 6, 2, 8, '2-1-X-1', 2, 8),
    (1, 9, 'secundario', 7, 1, 1, NULL, NULL, NULL);

-- =====================================================
-- DÍA 2 - SEMANA 1 (dia_id=2)
-- =====================================================

-- Ejercicios principales
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (2, 3, 'principal', 1, 1, 5, '3-1-X-1', 4, 6),
    (2, 3, 'principal', 2, 1, 5, '3-1-X-1', 3, 7),
    (2, 3, 'principal', 3, 3, 5, '3-1-X-1', 2, 8),
    (2, 4, 'principal', 4, 1, 5, '3-1-X-1', 4, 6),
    (2, 4, 'principal', 5, 1, 5, '3-1-X-1', 3, 7),
    (2, 4, 'principal', 6, 3, 5, '3-1-X-1', 2, 8);

-- Ejercicios secundarios
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (2, 10, 'secundario', 1, 1, 8, '2-1-X-1', 4, 6),
    (2, 10, 'secundario', 2, 1, 8, '2-1-X-1', 3, 7),
    (2, 10, 'secundario', 3, 2, 8, '2-1-X-1', 2, 8),
    (2, 11, 'secundario', 4, 1, 8, '2-1-X-1', 4, 6),
    (2, 11, 'secundario', 5, 1, 8, '2-1-X-1', 3, 7),
    (2, 11, 'secundario', 6, 2, 8, '2-1-X-1', 2, 8),
    (2, 12, 'secundario', 7, 1, 8, '2-1-X-1', 4, 6),
    (2, 12, 'secundario', 8, 1, 8, '2-1-X-1', 3, 7),
    (2, 12, 'secundario', 9, 2, 8, '2-1-X-1', 2, 8);

-- =====================================================
-- DÍA 3 - SEMANA 1 (dia_id=3)
-- =====================================================

-- Ejercicios principales
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (3, 5, 'principal', 1, 1, 5, '3-1-X-1', 4, 6),
    (3, 5, 'principal', 2, 1, 5, '3-1-X-1', 3, 7),
    (3, 5, 'principal', 3, 3, 5, '3-1-X-1', 2, 8),
    (3, 6, 'principal', 4, 1, 5, '3-1-X-1', 4, 6),
    (3, 6, 'principal', 5, 1, 5, '3-1-X-1', 3, 7),
    (3, 6, 'principal', 6, 3, 5, '3-1-X-1', 2, 8);

-- Ejercicios secundarios
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (3, 13, 'secundario', 1, 1, 8, '2-1-X-1', 4, 6),
    (3, 13, 'secundario', 2, 1, 8, '2-1-X-1', 3, 7),
    (3, 13, 'secundario', 3, 2, 8, '2-1-X-1', 2, 8),
    (3, 14, 'secundario', 4, 1, 8, '2-1-X-1', 4, 6),
    (3, 14, 'secundario', 5, 1, 8, '2-1-X-1', 3, 7),
    (3, 14, 'secundario', 6, 2, 8, '2-1-X-1', 2, 8),
    (3, 15, 'secundario', 7, 1, 8, '2-1-X-1', 4, 6),
    (3, 15, 'secundario', 8, 1, 8, '2-1-X-1', 3, 7),
    (3, 15, 'secundario', 9, 2, 8, '2-1-X-1', 2, 8);

-- =====================================================
-- SEMANAS 2-8 (ejemplo: mismos ejercicios, diferentes repeticiones)
-- NOTA: Añadir según archivo Rutinas.txt
-- =====================================================

-- =====================================================
-- RUTINA: FUERZA AVANZADO 3 HIPERTROFIA
-- =====================================================

-- DÍA 1 - SEMANA 1 (dia_id=25) - Hipertrofia
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 1, 'principal', 1, 1, 14, '2-0-X-1', 3, 7),
    (25, 1, 'principal', 2, 2, 14, '2-0-X-1', 2, 8),
    (25, 1, 'principal', 3, 1, 14, '2-0-X-1', 1, 9),
    (25, 4, 'principal', 4, 1, 14, '2-0-X-1', 3, 7),
    (25, 4, 'principal', 5, 2, 14, '2-0-X-1', 2, 8),
    (25, 4, 'principal', 6, 1, 14, '2-0-X-1', 1, 9);

-- Ejercicios secundarios Hipertrofia
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 16, 'secundario', 1, 1, 14, '2-1-X-2', 3, 7),
    (25, 16, 'secundario', 2, 2, 14, '2-1-X-2', 2, 8),
    (25, 16, 'secundario', 3, 1, 14, '2-1-X-2', 1, 9),
    (25, 10, 'secundario', 4, 1, 14, '2-1-X-1', 3, 7),
    (25, 10, 'secundario', 5, 2, 14, '2-1-X-1', 2, 8),
    (25, 10, 'secundario', 6, 1, 14, '2-1-X-1', 1, 9),
    (25, 17, 'secundario', 7, 1, 14, '2-1-X-2', 3, 7),
    (25, 17, 'secundario', 8, 2, 14, '2-1-X-2', 2, 8),
    (25, 17, 'secundario', 9, 1, 14, '2-1-X-2', 1, 9);

-- Core Hipertrofia
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 20, 'core', 1, 4, 1, NULL, 4, 6),
    (25, 21, 'core', 2, 3, 1, NULL, 4, 6);

-- =====================================================
-- ROW LEVEL SECURITY (RLS)
-- =====================================================

ALTER TABLE rutinas ENABLE ROW LEVEL SECURITY;
ALTER TABLE semanas ENABLE ROW LEVEL SECURITY;
ALTER TABLE dias ENABLE ROW LEVEL SECURITY;
ALTER TABLE tipos_ejercicio ENABLE ROW LEVEL SECURITY;
ALTER TABLE ejercicios ENABLE ROW LEVEL SECURITY;
ALTER TABLE series ENABLE ROW LEVEL SECURITY;
ALTER TABLE registros ENABLE ROW LEVEL SECURITY;

-- Políticas para tablas públicas
CREATE POLICY "Anyone can read rutinas" ON rutinas FOR SELECT USING (true);
CREATE POLICY "Anyone can read semanas" ON semanas FOR SELECT USING (true);
CREATE POLICY "Anyone can read dias" ON dias FOR SELECT USING (true);
CREATE POLICY "Anyone can read tipos_ejercicio" ON tipos_ejercicio FOR SELECT USING (true);
CREATE POLICY "Anyone can read ejercicios" ON ejercicios FOR SELECT USING (true);
CREATE POLICY "Anyone can read series" ON series FOR SELECT USING (true);

-- Políticas para registros (solo usuario autenticado)
CREATE POLICY "Users can read own registros" ON registros FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own registros" ON registros FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own registros" ON registros FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own registros" ON registros FOR DELETE USING (auth.uid() = user_id);

-- =====================================================
-- ÍNDICES
-- =====================================================

CREATE INDEX idx_semanas_rutina ON semanas(rutina_id);
CREATE INDEX idx_dias_semana ON dias(semana_id);
CREATE INDEX idx_series_dia ON series(dia_id);
CREATE INDEX idx_series_ejercicio ON series(ejercicio_id);
CREATE INDEX idx_registros_user ON registros(user_id);
CREATE INDEX idx_registros_serie ON registros(serie_id);
CREATE INDEX idx_registros_fecha ON registros(fecha);

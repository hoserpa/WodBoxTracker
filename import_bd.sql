-- =====================================================
-- WODBOX TRACKER - BASE DE DATOS COMPLETA
-- Datos basados en Rutinas.txt
-- =====================================================

-- =====================================================
-- LIMPIEZA DE TABLAS EXISTENTES
-- =====================================================

DROP TABLE IF EXISTS registros CASCADE;
DROP TABLE IF EXISTS series CASCADE;
DROP TABLE IF EXISTS dias CASCADE;
DROP TABLE IF EXISTS semanas CASCADE;
DROP TABLE IF EXISTS rutinas CASCADE;
DROP TABLE IF EXISTS ejercicios CASCADE;
DROP TABLE IF EXISTS tipos_ejercicio CASCADE;

-- =====================================================
-- CREACIÓN DE TABLAS
-- =====================================================

CREATE TABLE tipos_ejercicio (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT
);

CREATE TABLE rutinas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

CREATE TABLE ejercicios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo_id INTEGER REFERENCES tipos_ejercicio(id)
);

CREATE TABLE semanas (
    id SERIAL PRIMARY KEY,
    rutina_id INTEGER REFERENCES rutinas(id),
    numero INTEGER NOT NULL
);

CREATE TABLE dias (
    id SERIAL PRIMARY KEY,
    semana_id INTEGER REFERENCES semanas(id),
    numero INTEGER NOT NULL,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE series (
    id SERIAL PRIMARY KEY,
    dia_id INTEGER REFERENCES dias(id),
    ejercicio_id INTEGER REFERENCES ejercicios(id),
    tipo_ejercicio VARCHAR(20) NOT NULL,
    orden INTEGER NOT NULL,
    sets INTEGER NOT NULL,
    reps INTEGER NOT NULL,
    tempo VARCHAR(20),
    rir INTEGER,
    rpe INTEGER
);

CREATE TABLE registros (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id),
    serie_id INTEGER REFERENCES series(id),
    peso DECIMAL(6,2),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- BASE DE DATOS WODBOX TRACKER
-- Datos basados en Rutinas.txt
-- =====================================================

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
-- EJERCICIOS
-- =====================================================

INSERT INTO ejercicios (nombre, tipo_id) VALUES
-- Calentamiento
    ('HALF-KNEELING LOADED DORSIFLEXION', 1),
    ('CAT CAMEL', 1),
    ('KB HALO', 1),
    ('WALL SQUAT HOLD', 1),
    ('KB PLANK HAND TAPS', 1),
    ('ELEVACION Y DEPRESION ESCAPULAR', 1),
    ('WALL ANGEL', 1),
    ('SHOULDER BOX STRETCH', 1),
    ('BANDED SQUAT', 1),
    ('PULLS APART', 1),
    ('PNF TO IMPROVE ANKLE DORSIFLEXION', 1),
    ('BOX QUAD T-SPINE ROT', 1),
    ('KB GOOD MORNING', 1),
    ('PLATE ROMANIAN DEADLIFT', 1),
    ('RUN', 1),
    ('KNEELING HIP FLEXOR STRETCH', 1),
    ('PIRIFORMIS STRETCH', 1),
    ('SCAPULAR PUSH UP', 1),
    ('RUMANIAN DL', 1),
    ('WALL LEANING DOUBLE LEG CALF RAISE', 1),
    ('DORSIFLEXION TOBILLO', 1),
    ('SPIDERMAN', 1),
    ('KB HIP OPENER', 1),
    ('JUMPING JACK', 1),
    ('3 POSITION ANKLE DISTRACTION', 1),
    ('QUADRUPED HIP ROCKING', 1),
    ('KB TATER', 1),
    ('BANDED OHS', 1),
-- Principales
    ('BACK SQUAT', 2),
    ('PULL UP', 2),
    ('DL', 2),
    ('PRESS DE BANCA', 2),
    ('SHOULDER PRESS', 2),
    ('FRONT SQUAT', 2),
-- Secundarios
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
    ('FLEXO-EXTENSION DE GEMELOS', 3),
    ('HIP THRUST', 3),
    ('SEATED ALTERNATE DB SHOULDER PRESS', 3),
    ('CURL DE BICEP MARTILLO', 3),
    ('DB LATERAL RISE', 3),
    ('DB FRONT SHOULDER', 3),
-- Core
    ('HOLLOW HOLD', 4),
    ('ARCH HOLD', 4),
    ('LATERAL SIDE PLANK', 4),
    ('AB WHEEL', 4),
    ('SUPERMAN CONTRALATERAL', 4),
    ('PRESS PALLOF', 4);

-- =====================================================
-- SEMANAS Y DÍAS
-- =====================================================

-- Fuerza Avanzado 2: semanas 1-8, 3 días cada una
INSERT INTO semanas (rutina_id, numero) VALUES (1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8);

-- Días semana 1 (semana 1)
INSERT INTO dias (semana_id, numero, nombre) VALUES 
    (1, 29, 'Día 1'), (1, 30, 'Día 2'), (1, 31, 'Día 3'),
    (2, 29, 'Día 1'), (2, 30, 'Día 2'), (2, 31, 'Día 3'),
    (3, 29, 'Día 1'), (3, 30, 'Día 2'), (3, 31, 'Día 3'),
    (4, 29, 'Día 1'), (4, 30, 'Día 2'), (4, 31, 'Día 3'),
    (5, 29, 'Día 1'), (5, 30, 'Día 2'), (5, 31, 'Día 3'),
    (6, 29, 'Día 1'), (6, 30, 'Día 2'), (6, 31, 'Día 3'),
    (7, 29, 'Día 1'), (7, 30, 'Día 2'), (7, 31, 'Día 3'),
    (8, 29, 'Día 1'), (8, 30, 'Día 2'), (8, 31, 'Día 3');

-- Fuerza Avanzado 3 Hipertrofia: semanas 1-8
INSERT INTO semanas (rutina_id, numero) VALUES (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8);

-- Días Fuerza Avanzado 3 Hipertrofia (semanas 9-16)
INSERT INTO dias (semana_id, numero, nombre) VALUES 
    (9, 29, 'Día 1'), (9, 30, 'Día 2'),
    (10, 29, 'Día 1'), (10, 30, 'Día 2'),
    (11, 29, 'Día 1'), (11, 30, 'Día 2'),
    (12, 29, 'Día 1'), (12, 30, 'Día 2'),
    (13, 29, 'Día 1'), (13, 30, 'Día 2'),
    (14, 29, 'Día 1'), (14, 30, 'Día 2'),
    (15, 29, 'Día 1'), (15, 30, 'Día 2'),
    (16, 29, 'Día 1'), (16, 30, 'Día 2');

-- =====================================================
-- SERIES - FUERZA AVANZADO 2 - DÍA 1 - SEMANA 1 (dia_id=1)
-- =====================================================

-- CALENTAMIENTO (2 RONDAS)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (1, 1, 'calentamiento', 1, 2, 20, NULL, NULL, NULL),
    (1, 2, 'calentamiento', 2, 2, 5, NULL, NULL, NULL),
    (1, 3, 'calentamiento', 3, 2, 10, NULL, NULL, NULL),
    (1, 4, 'calentamiento', 4, 2, 30, NULL, NULL, NULL),
    (1, 5, 'calentamiento', 5, 2, 10, NULL, NULL, NULL),
    (1, 6, 'calentamiento', 6, 2, 5, NULL, NULL, NULL);

-- BACK SQUAT (ejercicio_id=29)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (1, 29, 'principal', 1, 1, 5, '3-1-X-1', 4, 6),
    (1, 29, 'principal', 2, 1, 5, '3-1-X-1', 3, 7),
    (1, 29, 'principal', 3, 3, 5, '3-1-X-1', 2, 8);

-- PULL UP (ejercicio_id=310)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (1, 30, 'principal', 4, 1, 5, '2-1-X-1', 4, 6),
    (1, 30, 'principal', 5, 1, 5, '2-1-X-1', 3, 7),
    (1, 30, 'principal', 6, 3, 5, '2-1-X-1', 2, 8);

-- SEATED DB SHOULDER PRESS ALTERNO (ejercicio_id=35)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (1, 35, 'secundario', 7, 1, 8, '2-1-X-1', 4, 6),
    (1, 35, 'secundario', 8, 1, 8, '2-1-X-1', 3, 7),
    (1, 35, 'secundario', 9, 2, 8, '2-1-X-1', 2, 8);

-- TRICEP KICKBACK EXTENSION (ejercicio_id=36)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (1, 36, 'secundario', 10, 1, 8, '2-1-X-1', 4, 6),
    (1, 36, 'secundario', 11, 1, 8, '2-1-X-1', 3, 7),
    (1, 36, 'secundario', 12, 2, 8, '2-1-X-1', 2, 8);

-- COPENHAGEN HIP ABDUCTION HOLD (ejercicio_id=37)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (1, 37, 'secundario', 13, 2, 20, NULL, NULL, NULL);

-- =====================================================
-- SERIES - FUERZA AVANZADO 2 - DÍA 2 - SEMANA 1 (dia_id=2)
-- =====================================================

-- CALENTAMIENTO (2 RONDAS): PNF TO IMPROVE ANKLE DORSIFLEXION, KB GOOD MORNING, PLATE ROMANIAN DEADLIFT, BAR ROW
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (2, 11, 'calentamiento', 1, 2, 20, NULL, NULL, NULL),
    (2, 13, 'calentamiento', 2, 2, 10, NULL, NULL, NULL),
    (2, 14, 'calentamiento', 3, 2, 10, NULL, NULL, NULL),
    (2, 39, 'calentamiento', 4, 2, 10, NULL, NULL, NULL);

-- DL (ejercicio_id=31)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (2, 31, 'principal', 1, 1, 5, '3-1-X-1', 4, 6),
    (2, 31, 'principal', 2, 1, 5, '3-1-X-1', 3, 7),
    (2, 31, 'principal', 3, 3, 5, '3-1-X-1', 2, 8);

-- PRESS DE BANCA (ejercicio_id=32)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (2, 32, 'principal', 4, 1, 5, '3-1-X-1', 4, 6),
    (2, 32, 'principal', 5, 1, 5, '3-1-X-1', 3, 7),
    (2, 32, 'principal', 6, 3, 5, '3-1-X-1', 2, 8);

-- BULGARIAN SQUAT (ejercicio_id=31090)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (2, 38, 'secundario', 7, 1, 8, '2-1-X-1', 4, 6),
    (2, 38, 'secundario', 8, 1, 8, '2-1-X-1', 3, 7),
    (2, 38, 'secundario', 9, 2, 8, '2-1-X-1', 2, 8);

-- BAR ROW (ejercicio_id=31091)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (2, 39, 'secundario', 10, 1, 8, '2-1-X-1', 4, 6),
    (2, 39, 'secundario', 11, 1, 8, '2-1-X-1', 3, 7),
    (2, 39, 'secundario', 12, 2, 8, '2-1-X-1', 2, 8);

-- CURL DE BICEP (ejercicio_id=31092)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (2, 40, 'secundario', 13, 1, 8, '2-1-X-1', 4, 6),
    (2, 40, 'secundario', 14, 1, 8, '2-1-X-1', 3, 7),
    (2, 40, 'secundario', 15, 2, 8, '2-1-X-1', 2, 8);

-- =====================================================
-- SERIES - FUERZA AVANZADO 2 - DÍA 3 - SEMANA 1 (dia_id=3)
-- =====================================================

-- CALENTAMIENTO (2 RONDAS): PNF TO IMPROVE ANKLE DORSIFLEXION, KB GOOD MORNING, PLATE ROMANIAN DEADLIFT, BAR ROW
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (3, 11, 'calentamiento', 1, 2, 20, NULL, NULL, NULL),
    (3, 13, 'calentamiento', 2, 2, 10, NULL, NULL, NULL),
    (3, 14, 'calentamiento', 3, 2, 10, NULL, NULL, NULL),
    (3, 39, 'calentamiento', 4, 2, 10, NULL, NULL, NULL);

-- SHOULDER PRESS (ejercicio_id=33)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (3, 33, 'principal', 1, 1, 5, '3-1-X-1', 4, 6),
    (3, 33, 'principal', 2, 1, 5, '3-1-X-1', 3, 7),
    (3, 33, 'principal', 3, 3, 5, '3-1-X-1', 2, 8);

-- FRONT SQUAT (ejercicio_id=34)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (3, 34, 'principal', 4, 1, 5, '3-1-X-1', 4, 6),
    (3, 34, 'principal', 5, 1, 5, '3-1-X-1', 3, 7),
    (3, 34, 'principal', 6, 3, 5, '3-1-X-1', 2, 8);

-- ALTERNATING DUMBBELL FLOOR PRESS (ejercicio_id=31093)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (3, 41, 'secundario', 7, 1, 8, '2-1-X-1', 4, 6),
    (3, 41, 'secundario', 8, 1, 8, '2-1-X-1', 3, 7),
    (3, 41, 'secundario', 9, 2, 8, '2-1-X-1', 2, 8);

-- KB ONE ARM ROW (ejercicio_id=31094)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (3, 42, 'secundario', 10, 1, 8, '2-1-X-1', 4, 6),
    (3, 42, 'secundario', 11, 1, 8, '2-1-X-1', 3, 7),
    (3, 42, 'secundario', 12, 2, 8, '2-1-X-1', 2, 8);

-- KB RDL (ejercicio_id=31095)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (3, 43, 'secundario', 13, 1, 8, '2-1-X-1', 4, 6),
    (3, 43, 'secundario', 14, 1, 8, '2-1-X-1', 3, 7),
    (3, 43, 'secundario', 15, 2, 8, '2-1-X-1', 2, 8);

-- =====================================================
-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 1 - SEMANA 1 (dia_id=25)
-- =====================================================

-- CALENTAMIENTO (2 RONDAS)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 20, 'calentamiento', 1, 2, 20, NULL, NULL, NULL),
    (25, 21, 'calentamiento', 2, 2, 20, NULL, NULL, NULL),
    (25, 22, 'calentamiento', 3, 2, 5, NULL, NULL, NULL),
    (25, 23, 'calentamiento', 4, 2, 10, NULL, NULL, NULL),
    (25, 18, 'calentamiento', 5, 2, 10, NULL, NULL, NULL),
    (25, 8, 'calentamiento', 6, 2, 20, NULL, NULL, NULL);

-- BACK SQUAT (ejercicio_id=29)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 29, 'principal', 1, 1, 14, '2-0-X-1', 3, 7),
    (25, 29, 'principal', 2, 2, 14, '2-0-X-1', 2, 8),
    (25, 29, 'principal', 3, 1, 14, '2-0-X-1', 1, 9);

-- PRESS DE BANCA (ejercicio_id=32)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 32, 'principal', 4, 1, 14, '2-0-X-1', 3, 7),
    (25, 32, 'principal', 5, 2, 14, '2-0-X-1', 2, 8),
    (25, 32, 'principal', 6, 1, 14, '2-0-X-1', 1, 9);

-- BANDED TRICEPS EXTENSION (ejercicio_id=31096)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 44, 'secundario', 7, 1, 14, '2-1-X-2', 3, 7),
    (25, 44, 'secundario', 8, 2, 14, '2-1-X-2', 2, 8),
    (25, 44, 'secundario', 9, 1, 14, '2-1-X-2', 1, 9);

-- BULGARIAN SQUAT (ejercicio_id=31090)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 38, 'secundario', 10, 1, 14, '2-1-X-1', 3, 7),
    (25, 38, 'secundario', 11, 2, 14, '2-1-X-1', 2, 8),
    (25, 38, 'secundario', 12, 1, 14, '2-1-X-1', 1, 9);

-- BAND GLUTE KICKBACK (ejercicio_id=31097)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 45, 'secundario', 13, 1, 14, '2-1-X-2', 3, 7),
    (25, 45, 'secundario', 14, 2, 14, '2-1-X-2', 2, 8),
    (25, 45, 'secundario', 15, 1, 14, '2-1-X-2', 1, 9);

-- HOLLOW HOLD (ejercicio_id=3102)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 50, 'core', 16, 4, 20, NULL, NULL, NULL);

-- ARCH HOLD (ejercicio_id=3103)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 51, 'core', 17, 3, 20, NULL, NULL, NULL);

-- =====================================================
-- SERIES - FUERZA AVANZADO 2 - DÍA 1 - SEMANAS 2-8
-- =====================================================

-- ---------- SEMANA 2 (dia_id=4) ----------
-- CALENTAMIENTO (2 RONDAS)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (4, 1, 'calentamiento', 1, 2, 20, NULL, NULL, NULL),
    (4, 2, 'calentamiento', 2, 2, 5, NULL, NULL, NULL),
    (4, 7, 'calentamiento', 3, 2, 10, NULL, NULL, NULL),
    (4, 8, 'calentamiento', 4, 2, 20, NULL, NULL, NULL),
    (4, 10, 'calentamiento', 5, 2, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (4, 29, 'principal', 6, 1, 5, '3-1-X-1', 4, 6),
    (4, 29, 'principal', 2, 1, 5, '3-1-X-1', 3, 7),
    (4, 29, 'principal', 3, 2, 5, '3-1-X-1', 2, 8),
    (4, 29, 'principal', 4, 1, 4, '3-1-X-1', 2, 8),
    (4, 30, 'principal', 5, 1, 5, '2-1-X-1', 4, 6),
    (4, 30, 'principal', 6, 1, 5, '2-1-X-1', 3, 7),
    (4, 30, 'principal', 7, 2, 5, '2-1-X-1', 2, 8),
    (4, 30, 'principal', 8, 1, 4, '2-1-X-1', 2, 8),
    (4, 35, 'secundario', 9, 1, 7, '2-1-X-1', 4, 6),
    (4, 35, 'secundario', 10, 1, 7, '2-1-X-1', 3, 7),
    (4, 35, 'secundario', 11, 2, 7, '2-1-X-1', 2, 8),
    (4, 36, 'secundario', 12, 1, 7, '2-1-X-1', 4, 6),
    (4, 36, 'secundario', 13, 1, 7, '2-1-X-1', 3, 7),
    (4, 36, 'secundario', 14, 2, 7, '2-1-X-1', 2, 8),
    (4, 37, 'secundario', 15, 2, 20, NULL, NULL, NULL);

-- ---------- SEMANA 3 (dia_id=7) ----------
-- CALENTAMIENTO (2 RONDAS)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (7, 7, 'calentamiento', 1, 2, 10, NULL, NULL, NULL),
    (7, 15, 'calentamiento', 2, 2, 10, NULL, NULL, NULL),
    (7, 16, 'calentamiento', 3, 2, 15, NULL, NULL, NULL),
    (7, 17, 'calentamiento', 4, 2, 10, NULL, NULL, NULL),
    (7, 2, 'calentamiento', 5, 2, 10, NULL, NULL, NULL),
    (7, 27, 'calentamiento', 6, 2, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (7, 29, 'principal', 7, 1, 4, '2-1-X-1', 4, 6),
    (7, 29, 'principal', 2, 1, 4, '2-1-X-1', 3, 7),
    (7, 29, 'principal', 3, 3, 4, '2-1-X-1', 2, 8),
    (7, 30, 'principal', 4, 1, 4, '2-1-X-1', 4, 6),
    (7, 30, 'principal', 5, 1, 4, '2-1-X-1', 3, 7),
    (7, 30, 'principal', 6, 3, 4, '2-1-X-1', 2, 8),
    (7, 35, 'secundario', 7, 1, 6, '2-1-X-1', 4, 6),
    (7, 35, 'secundario', 8, 1, 6, '2-1-X-1', 3, 7),
    (7, 35, 'secundario', 9, 2, 6, '2-1-X-1', 2, 8),
    (7, 36, 'secundario', 10, 1, 6, '2-1-X-1', 4, 6),
    (7, 36, 'secundario', 11, 1, 6, '2-1-X-1', 3, 7),
    (7, 36, 'secundario', 12, 2, 6, '2-1-X-1', 2, 8),
    (7, 37, 'secundario', 13, 2, 20, NULL, NULL, NULL);

-- ---------- SEMANA 4 (dia_id=10) ----------
-- CALENTAMIENTO (2 RONDAS)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (10, 1, 'calentamiento', 1, 2, 20, NULL, NULL, NULL),
    (10, 2, 'calentamiento', 2, 2, 5, NULL, NULL, NULL),
    (10, 7, 'calentamiento', 3, 2, 10, NULL, NULL, NULL),
    (10, 8, 'calentamiento', 4, 2, 20, NULL, NULL, NULL),
    (10, 10, 'calentamiento', 5, 2, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (10, 29, 'principal', 6, 1, 4, '2-1-X-1', 4, 6),
    (10, 29, 'principal', 2, 1, 4, '2-1-X-1', 3, 7),
    (10, 29, 'principal', 3, 2, 4, '2-1-X-1', 2, 8),
    (10, 29, 'principal', 4, 1, 3, '2-1-X-1', 2, 8),
    (10, 30, 'principal', 5, 1, 4, '2-1-X-1', 4, 6),
    (10, 30, 'principal', 6, 1, 4, '2-1-X-1', 3, 7),
    (10, 30, 'principal', 7, 2, 4, '2-1-X-1', 2, 8),
    (10, 30, 'principal', 8, 1, 3, '2-1-X-1', 2, 8),
    (10, 35, 'secundario', 9, 1, 5, '2-1-X-1', 4, 6),
    (10, 35, 'secundario', 10, 1, 5, '2-1-X-1', 3, 7),
    (10, 35, 'secundario', 11, 2, 5, '2-1-X-1', 2, 8),
    (10, 36, 'secundario', 12, 1, 5, '2-1-X-1', 4, 6),
    (10, 36, 'secundario', 13, 1, 5, '2-1-X-1', 3, 7),
    (10, 36, 'secundario', 14, 2, 5, '2-1-X-1', 2, 8),
    (10, 37, 'secundario', 15, 2, 20, NULL, NULL, NULL);

-- ---------- SEMANA 5 (dia_id=13) ----------
-- CALENTAMIENTO (2 RONDAS)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (13, 1, 'calentamiento', 1, 2, 20, NULL, NULL, NULL),
    (13, 2, 'calentamiento', 2, 2, 5, NULL, NULL, NULL),
    (13, 7, 'calentamiento', 3, 2, 10, NULL, NULL, NULL),
    (13, 8, 'calentamiento', 4, 2, 20, NULL, NULL, NULL),
    (13, 10, 'calentamiento', 5, 2, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (13, 29, 'principal', 6, 1, 3, '2-0-X-1', 4, 6),
    (13, 29, 'principal', 2, 1, 3, '2-0-X-1', 3, 7),
    (13, 29, 'principal', 3, 3, 3, '2-0-X-1', 2, 8),
    (13, 30, 'principal', 4, 1, 3, '2-1-X-1', 4, 6),
    (13, 30, 'principal', 5, 1, 3, '2-1-X-1', 3, 7),
    (13, 30, 'principal', 6, 3, 3, '2-1-X-1', 2, 8),
    (13, 35, 'secundario', 7, 1, 4, '2-1-X-1', 4, 6),
    (13, 35, 'secundario', 8, 1, 4, '2-1-X-1', 3, 7),
    (13, 35, 'secundario', 9, 2, 4, '2-1-X-1', 2, 8),
    (13, 36, 'secundario', 10, 1, 4, '2-1-X-1', 4, 6),
    (13, 36, 'secundario', 11, 1, 4, '2-1-X-1', 3, 7),
    (13, 36, 'secundario', 12, 2, 4, '2-1-X-1', 2, 8),
    (13, 37, 'secundario', 13, 2, 30, NULL, NULL, NULL);

-- ---------- SEMANA 6 (dia_id=16) ----------
-- CALENTAMIENTO (2 RONDAS)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (16, 7, 'calentamiento', 1, 2, 10, NULL, NULL, NULL),
    (16, 15, 'calentamiento', 2, 2, 10, NULL, NULL, NULL),
    (16, 16, 'calentamiento', 3, 2, 15, NULL, NULL, NULL),
    (16, 17, 'calentamiento', 4, 2, 10, NULL, NULL, NULL),
    (16, 2, 'calentamiento', 5, 2, 10, NULL, NULL, NULL),
    (16, 27, 'calentamiento', 6, 2, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (16, 29, 'principal', 7, 1, 3, '2-0-X-1', 4, 6),
    (16, 29, 'principal', 2, 1, 3, '2-0-X-1', 3, 7),
    (16, 29, 'principal', 3, 2, 3, '2-0-X-1', 2, 8),
    (16, 29, 'principal', 4, 1, 2, '2-0-X-1', 2, 8),
    (16, 30, 'principal', 5, 1, 3, '2-1-X-1', 4, 6),
    (16, 30, 'principal', 6, 1, 3, '2-1-X-1', 3, 7),
    (16, 30, 'principal', 7, 2, 3, '2-1-X-1', 2, 8),
    (16, 30, 'principal', 8, 1, 2, '2-1-X-1', 2, 8),
    (16, 35, 'secundario', 9, 1, 3, '2-1-X-1', 4, 6),
    (16, 35, 'secundario', 10, 1, 3, '2-1-X-1', 3, 7),
    (16, 35, 'secundario', 11, 2, 3, '2-1-X-1', 2, 8),
    (16, 36, 'secundario', 12, 1, 3, '2-1-X-1', 4, 6),
    (16, 36, 'secundario', 13, 1, 3, '2-1-X-1', 3, 7),
    (16, 36, 'secundario', 14, 2, 3, '2-1-X-1', 2, 8),
    (16, 37, 'secundario', 15, 2, 30, NULL, NULL, NULL);

-- ---------- SEMANA 7 (dia_id=19) ----------
-- CALENTAMIENTO (2 RONDAS)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (19, 1, 'calentamiento', 1, 2, 20, NULL, NULL, NULL),
    (19, 2, 'calentamiento', 2, 2, 5, NULL, NULL, NULL),
    (19, 7, 'calentamiento', 3, 2, 10, NULL, NULL, NULL),
    (19, 8, 'calentamiento', 4, 2, 20, NULL, NULL, NULL),
    (19, 10, 'calentamiento', 5, 2, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (19, 29, 'principal', 6, 1, 2, '1-0-X-1', 4, 6),
    (19, 29, 'principal', 2, 1, 2, '1-0-X-1', 3, 7),
    (19, 29, 'principal', 3, 3, 2, '1-0-X-1', 2, 8),
    (19, 30, 'principal', 4, 1, 2, '2-1-X-1', 4, 6),
    (19, 30, 'principal', 5, 1, 2, '2-1-X-1', 3, 7),
    (19, 30, 'principal', 6, 3, 2, '2-1-X-1', 2, 8),
    (19, 35, 'secundario', 7, 1, 2, '2-1-X-1', 4, 6),
    (19, 35, 'secundario', 8, 1, 2, '2-1-X-1', 3, 7),
    (19, 35, 'secundario', 9, 2, 2, '2-1-X-1', 2, 8),
    (19, 36, 'secundario', 10, 1, 2, '2-1-X-1', 4, 6),
    (19, 36, 'secundario', 11, 1, 2, '2-1-X-1', 3, 7),
    (19, 36, 'secundario', 12, 2, 2, '2-1-X-1', 2, 8),
    (19, 37, 'secundario', 13, 2, 30, NULL, NULL, NULL);

-- ---------- SEMANA 8 (dia_id=22) ----------
-- CALENTAMIENTO (2 RONDAS)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (22, 1, 'calentamiento', 1, 2, 20, NULL, NULL, NULL),
    (22, 2, 'calentamiento', 2, 2, 5, NULL, NULL, NULL),
    (22, 7, 'calentamiento', 3, 2, 10, NULL, NULL, NULL),
    (22, 8, 'calentamiento', 4, 2, 20, NULL, NULL, NULL),
    (22, 10, 'calentamiento', 5, 2, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (22, 29, 'principal', 6, 1, 1, '1-0-X-1', 4, 6),
    (22, 29, 'principal', 2, 1, 1, '1-0-X-1', 3, 7),
    (22, 29, 'principal', 3, 3, 1, '1-0-X-1', 2, 8),
    (22, 30, 'principal', 4, 1, 1, '2-1-X-1', 4, 6),
    (22, 30, 'principal', 5, 1, 1, '2-1-X-1', 3, 7),
    (22, 30, 'principal', 6, 3, 1, '2-1-X-1', 2, 8),
    (22, 35, 'secundario', 7, 1, 1, '2-1-X-1', 4, 6),
    (22, 35, 'secundario', 8, 1, 1, '2-1-X-1', 3, 7),
    (22, 35, 'secundario', 9, 2, 1, '2-1-X-1', 2, 8),
    (22, 36, 'secundario', 10, 1, 1, '2-1-X-1', 4, 6),
    (22, 36, 'secundario', 11, 1, 1, '2-1-X-1', 3, 7),
    (22, 36, 'secundario', 12, 2, 1, '2-1-X-1', 2, 8),
    (22, 37, 'secundario', 13, 2, 30, NULL, NULL, NULL);

-- =====================================================
-- SERIES - FUERZA AVANZADO 2 - DÍA 2 - SEMANAS 2-8
-- =====================================================

-- ---------- SEMANA 2 (dia_id=5) ----------
-- CALENTAMIENTO (2 RONDAS): PNF TO IMPROVE ANKLE DORSIFLEXION, KB GOOD MORNING, PLATE ROMANIAN DEADLIFT, BAR ROW
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (5, 11, 'calentamiento', 1, 2, 20, NULL, NULL, NULL),
    (5, 12, 'calentamiento', 2, 2, 20, NULL, NULL, NULL),
    (5, 13, 'calentamiento', 3, 2, 10, NULL, NULL, NULL),
    (5, 14, 'calentamiento', 4, 2, 10, NULL, NULL, NULL),
    (5, 39, 'calentamiento', 5, 2, 10, NULL, NULL, NULL),
    (5, 16, 'calentamiento', 6, 2, 15, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (5, 31, 'principal', 7, 1, 5, '3-1-X-1', 4, 6),
    (5, 31, 'principal', 2, 1, 5, '3-1-X-1', 3, 7),
    (5, 31, 'principal', 3, 2, 5, '3-1-X-1', 2, 8),
    (5, 31, 'principal', 4, 1, 4, '3-1-X-1', 2, 8),
    (5, 32, 'principal', 5, 1, 5, '3-1-X-1', 4, 6),
    (5, 32, 'principal', 6, 1, 5, '3-1-X-1', 3, 7),
    (5, 32, 'principal', 7, 2, 5, '3-1-X-1', 2, 8),
    (5, 32, 'principal', 8, 1, 4, '3-1-X-1', 2, 8),
    (5, 38, 'secundario', 9, 1, 7, '2-1-X-1', 4, 6),
    (5, 38, 'secundario', 10, 1, 7, '2-1-X-1', 3, 7),
    (5, 38, 'secundario', 11, 2, 7, '2-1-X-1', 2, 8),
    (5, 39, 'secundario', 12, 1, 7, '2-1-X-1', 4, 6),
    (5, 39, 'secundario', 13, 1, 7, '2-1-X-1', 3, 7),
    (5, 39, 'secundario', 14, 2, 7, '2-1-X-1', 2, 8),
    (5, 40, 'secundario', 15, 1, 7, '2-1-X-1', 4, 6),
    (5, 40, 'secundario', 16, 1, 7, '2-1-X-1', 3, 7),
    (5, 40, 'secundario', 17, 2, 7, '2-1-X-1', 2, 8);

-- ---------- SEMANA 3 (dia_id=8) ----------
-- CALENTAMIENTO (2 RONDAS): RUN, KNEELING HIP FLEXOR STRETCH, PIRIFORMIS STRETCH, SCAPULAR PUSH UP, BAR ROW, ROMANIAN DL
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (8, 15, 'calentamiento', 1, 2, 3, NULL, NULL, NULL),
    (8, 16, 'calentamiento', 2, 2, 20, NULL, NULL, NULL),
    (8, 17, 'calentamiento', 3, 2, 20, NULL, NULL, NULL),
    (8, 18, 'calentamiento', 4, 2, 10, NULL, NULL, NULL),
    (8, 39, 'calentamiento', 5, 2, 10, NULL, NULL, NULL),
    (8, 19, 'calentamiento', 6, 2, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (8, 31, 'principal', 7, 1, 4, '2-1-X-1', 4, 6),
    (8, 31, 'principal', 2, 1, 4, '2-1-X-1', 3, 7),
    (8, 31, 'principal', 3, 3, 4, '2-1-X-1', 2, 8),
    (8, 32, 'principal', 4, 1, 4, '2-1-X-1', 4, 6),
    (8, 32, 'principal', 5, 1, 4, '2-1-X-1', 3, 7),
    (8, 32, 'principal', 6, 3, 4, '2-1-X-1', 2, 8),
    (8, 38, 'secundario', 7, 1, 6, '2-1-X-1', 4, 6),
    (8, 38, 'secundario', 8, 1, 6, '2-1-X-1', 3, 7),
    (8, 38, 'secundario', 9, 2, 6, '2-1-X-1', 2, 8),
    (8, 39, 'secundario', 10, 1, 6, '2-1-X-1', 4, 6),
    (8, 39, 'secundario', 11, 1, 6, '2-1-X-1', 3, 7),
    (8, 39, 'secundario', 12, 2, 6, '2-1-X-1', 2, 8),
    (8, 40, 'secundario', 13, 1, 6, '2-1-X-1', 4, 6),
    (8, 40, 'secundario', 14, 1, 6, '2-1-X-1', 3, 7),
    (8, 40, 'secundario', 15, 2, 6, '2-1-X-1', 2, 8);

-- ---------- SEMANA 4 (dia_id=11) ----------
-- CALENTAMIENTO (2 RONDAS): PNF TO IMPROVE ANKLE DORSIFLEXION, KB GOOD MORNING, PLATE ROMANIAN DEADLIFT, BAR ROW
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (11, 11, 'calentamiento', 1, 2, 20, NULL, NULL, NULL),
    (11, 13, 'calentamiento', 2, 2, 10, NULL, NULL, NULL),
    (11, 14, 'calentamiento', 3, 2, 10, NULL, NULL, NULL),
    (11, 39, 'calentamiento', 4, 2, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (11, 31, 'principal', 5, 1, 4, '2-1-X-1', 4, 6),
    (11, 31, 'principal', 2, 1, 4, '2-1-X-1', 3, 7),
    (11, 31, 'principal', 3, 2, 4, '2-1-X-1', 2, 8),
    (11, 31, 'principal', 4, 1, 3, '2-1-X-1', 2, 8),
    (11, 32, 'principal', 5, 1, 4, '2-1-X-1', 4, 6),
    (11, 32, 'principal', 6, 1, 4, '2-1-X-1', 3, 7),
    (11, 32, 'principal', 7, 2, 4, '2-1-X-1', 2, 8),
    (11, 32, 'principal', 8, 1, 3, '2-1-X-1', 2, 8),
    (11, 38, 'secundario', 9, 1, 5, '2-1-X-1', 4, 6),
    (11, 38, 'secundario', 10, 1, 5, '2-1-X-1', 3, 7),
    (11, 38, 'secundario', 11, 2, 5, '2-1-X-1', 2, 8),
    (11, 39, 'secundario', 12, 1, 5, '2-1-X-1', 4, 6),
    (11, 39, 'secundario', 13, 1, 5, '2-1-X-1', 3, 7),
    (11, 39, 'secundario', 14, 2, 5, '2-1-X-1', 2, 8),
    (11, 40, 'secundario', 15, 1, 5, '2-1-X-1', 4, 6),
    (11, 40, 'secundario', 16, 1, 5, '2-1-X-1', 3, 7),
    (11, 40, 'secundario', 17, 2, 5, '2-1-X-1', 2, 8);

-- ---------- SEMANA 5 (dia_id=14) ----------
-- CALENTAMIENTO (2 RONDAS): PNF TO IMPROVE ANKLE DORSIFLEXION, KB GOOD MORNING, PLATE ROMANIAN DEADLIFT, BAR ROW
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (14, 11, 'calentamiento', 1, 2, 20, NULL, NULL, NULL),
    (14, 13, 'calentamiento', 2, 2, 10, NULL, NULL, NULL),
    (14, 14, 'calentamiento', 3, 2, 10, NULL, NULL, NULL),
    (14, 39, 'calentamiento', 4, 2, 10, NULL, NULL, NULL),
    (14, 16, 'calentamiento', 5, 2, 15, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (14, 31, 'principal', 6, 1, 3, '2-0-X-1', 4, 6),
    (14, 31, 'principal', 2, 1, 3, '2-0-X-1', 3, 7),
    (14, 31, 'principal', 3, 3, 3, '2-0-X-1', 2, 8),
    (14, 32, 'principal', 4, 1, 3, '2-0-X-1', 4, 6),
    (14, 32, 'principal', 5, 1, 3, '2-0-X-1', 3, 7),
    (14, 32, 'principal', 6, 3, 3, '2-0-X-1', 2, 8),
    (14, 38, 'secundario', 7, 1, 4, '2-1-X-1', 4, 6),
    (14, 38, 'secundario', 8, 1, 4, '2-1-X-1', 3, 7),
    (14, 38, 'secundario', 9, 2, 4, '2-1-X-1', 2, 8),
    (14, 39, 'secundario', 10, 1, 4, '2-1-X-1', 4, 6),
    (14, 39, 'secundario', 11, 1, 4, '2-1-X-1', 3, 7),
    (14, 39, 'secundario', 12, 2, 4, '2-1-X-1', 2, 8),
    (14, 40, 'secundario', 13, 1, 4, '2-1-X-1', 4, 6),
    (14, 40, 'secundario', 14, 1, 4, '2-1-X-1', 3, 7),
    (14, 40, 'secundario', 15, 2, 4, '2-1-X-1', 2, 8);

-- ---------- SEMANA 6 (dia_id=17) ----------
-- CALENTAMIENTO (2 RONDAS): RUN, KNEELING HIP FLEXOR STRETCH, PIRIFORMIS STRETCH, SCAPULAR PUSH UP, BAR ROW, ROMANIAN DL
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (17, 15, 'calentamiento', 1, 2, 3, NULL, NULL, NULL),
    (17, 16, 'calentamiento', 2, 2, 20, NULL, NULL, NULL),
    (17, 17, 'calentamiento', 3, 2, 20, NULL, NULL, NULL),
    (17, 18, 'calentamiento', 4, 2, 10, NULL, NULL, NULL),
    (17, 39, 'calentamiento', 5, 2, 10, NULL, NULL, NULL),
    (17, 19, 'calentamiento', 6, 2, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (17, 31, 'principal', 7, 1, 3, '2-0-X-1', 4, 6),
    (17, 31, 'principal', 2, 1, 3, '2-0-X-1', 3, 7),
    (17, 31, 'principal', 3, 2, 3, '2-0-X-1', 2, 8),
    (17, 31, 'principal', 4, 1, 2, '2-0-X-1', 2, 8),
    (17, 32, 'principal', 5, 1, 3, '2-0-X-1', 4, 6),
    (17, 32, 'principal', 6, 1, 3, '2-0-X-1', 3, 7),
    (17, 32, 'principal', 7, 2, 3, '2-0-X-1', 2, 8),
    (17, 32, 'principal', 8, 1, 2, '2-0-X-1', 2, 8),
    (17, 38, 'secundario', 9, 1, 3, '2-1-X-1', 4, 6),
    (17, 38, 'secundario', 10, 1, 3, '2-1-X-1', 3, 7),
    (17, 38, 'secundario', 11, 2, 3, '2-1-X-1', 2, 8),
    (17, 39, 'secundario', 12, 1, 3, '2-1-X-1', 4, 6),
    (17, 39, 'secundario', 13, 1, 3, '2-1-X-1', 3, 7),
    (17, 39, 'secundario', 14, 2, 3, '2-1-X-1', 2, 8),
    (17, 40, 'secundario', 15, 1, 3, '2-1-X-1', 4, 6),
    (17, 40, 'secundario', 16, 1, 3, '2-1-X-1', 3, 7),
    (17, 40, 'secundario', 17, 2, 3, '2-1-X-1', 2, 8);

-- ---------- SEMANA 7 (dia_id=20) ----------
-- CALENTAMIENTO (2 RONDAS): PNF TO IMPROVE ANKLE DORSIFLEXION, KB GOOD MORNING, PLATE ROMANIAN DEADLIFT, BAR ROW
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (20, 11, 'calentamiento', 1, 2, 20, NULL, NULL, NULL),
    (20, 13, 'calentamiento', 2, 2, 10, NULL, NULL, NULL),
    (20, 14, 'calentamiento', 3, 2, 10, NULL, NULL, NULL),
    (20, 39, 'calentamiento', 4, 2, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (20, 31, 'principal', 5, 1, 2, '1-0-X-1', 4, 6),
    (20, 31, 'principal', 2, 1, 2, '1-0-X-1', 3, 7),
    (20, 31, 'principal', 3, 3, 2, '1-0-X-1', 2, 8),
    (20, 32, 'principal', 4, 1, 2, '1-0-X-1', 4, 6),
    (20, 32, 'principal', 5, 1, 2, '1-0-X-1', 3, 7),
    (20, 32, 'principal', 6, 3, 2, '1-0-X-1', 2, 8),
    (20, 38, 'secundario', 7, 1, 2, '2-1-X-1', 4, 6),
    (20, 38, 'secundario', 8, 1, 2, '2-1-X-1', 3, 7),
    (20, 38, 'secundario', 9, 2, 2, '2-1-X-1', 2, 8),
    (20, 39, 'secundario', 10, 1, 2, '2-1-X-1', 4, 6),
    (20, 39, 'secundario', 11, 1, 2, '2-1-X-1', 3, 7),
    (20, 39, 'secundario', 12, 2, 2, '2-1-X-1', 2, 8),
    (20, 40, 'secundario', 13, 1, 2, '2-1-X-1', 4, 6),
    (20, 40, 'secundario', 14, 1, 2, '2-1-X-1', 3, 7),
    (20, 40, 'secundario', 15, 2, 2, '2-1-X-1', 2, 8);

-- ---------- SEMANA 8 (dia_id=23) ----------
-- CALENTAMIENTO (2 RONDAS): PNF TO IMPROVE ANKLE DORSIFLEXION, KB GOOD MORNING, PLATE ROMANIAN DEADLIFT, BAR ROW
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (23, 11, 'calentamiento', 1, 2, 20, NULL, NULL, NULL),
    (23, 12, 'calentamiento', 2, 2, 20, NULL, NULL, NULL),
    (23, 13, 'calentamiento', 3, 2, 10, NULL, NULL, NULL),
    (23, 14, 'calentamiento', 4, 2, 10, NULL, NULL, NULL),
    (23, 39, 'calentamiento', 5, 2, 10, NULL, NULL, NULL),
    (23, 16, 'calentamiento', 6, 2, 15, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (23, 31, 'principal', 7, 1, 1, '1-0-X-1', 4, 6),
    (23, 31, 'principal', 2, 1, 1, '1-0-X-1', 3, 7),
    (23, 31, 'principal', 3, 3, 1, '1-0-X-1', 2, 8),
    (23, 32, 'principal', 4, 1, 1, '1-0-X-1', 4, 6),
    (23, 32, 'principal', 5, 1, 1, '1-0-X-1', 3, 7),
    (23, 32, 'principal', 6, 3, 1, '1-0-X-1', 2, 8),
    (23, 38, 'secundario', 7, 1, 1, '2-1-X-1', 4, 6),
    (23, 38, 'secundario', 8, 1, 1, '2-1-X-1', 3, 7),
    (23, 38, 'secundario', 9, 2, 1, '2-1-X-1', 2, 8),
    (23, 39, 'secundario', 10, 1, 1, '2-1-X-1', 4, 6),
    (23, 39, 'secundario', 11, 1, 1, '2-1-X-1', 3, 7),
    (23, 39, 'secundario', 12, 2, 1, '2-1-X-1', 2, 8),
    (23, 40, 'secundario', 13, 1, 1, '2-1-X-1', 4, 6),
    (23, 40, 'secundario', 14, 1, 1, '2-1-X-1', 3, 7),
    (23, 40, 'secundario', 15, 2, 1, '2-1-X-1', 2, 8);

-- =====================================================
-- SERIES - FUERZA AVANZADO 2 - DÍA 3 - SEMANAS 2-8
-- =====================================================

-- ---------- SEMANA 2 (dia_id=6) ----------
-- CALENTAMIENTO (3 RONDAS): RUN, ANKLE DISTRACTION, QUADRUPED HIP ROCKING, CAT CAMEL, KB TATER, BANDED OHS
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (6, 15, 'calentamiento', 1, 3, 3, NULL, NULL, NULL),
    (6, 25, 'calentamiento', 2, 3, 20, NULL, NULL, NULL),
    (6, 26, 'calentamiento', 3, 3, 10, NULL, NULL, NULL),
    (6, 2, 'calentamiento', 4, 3, 10, NULL, NULL, NULL),
    (6, 27, 'calentamiento', 5, 3, 10, NULL, NULL, NULL),
    (6, 28, 'calentamiento', 6, 3, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (6, 33, 'principal', 7, 1, 5, '3-1-X-1', 4, 6),
    (6, 33, 'principal', 2, 1, 5, '3-1-X-1', 3, 7),
    (6, 33, 'principal', 3, 2, 5, '3-1-X-1', 2, 8),
    (6, 33, 'principal', 4, 1, 4, '3-1-X-1', 2, 8),
    (6, 34, 'principal', 5, 1, 5, '3-1-X-1', 4, 6),
    (6, 34, 'principal', 6, 1, 5, '3-1-X-1', 3, 7),
    (6, 34, 'principal', 7, 2, 5, '3-1-X-1', 2, 8),
    (6, 34, 'principal', 8, 1, 4, '3-1-X-1', 2, 8),
    (6, 41, 'secundario', 9, 1, 7, '2-1-X-1', 4, 6),
    (6, 41, 'secundario', 10, 1, 7, '2-1-X-1', 3, 7),
    (6, 41, 'secundario', 11, 2, 7, '2-1-X-1', 2, 8),
    (6, 42, 'secundario', 12, 1, 7, '2-1-X-1', 4, 6),
    (6, 42, 'secundario', 13, 1, 7, '2-1-X-1', 3, 7),
    (6, 42, 'secundario', 14, 2, 7, '2-1-X-1', 2, 8),
    (6, 43, 'secundario', 15, 1, 7, '2-1-X-1', 4, 6),
    (6, 43, 'secundario', 16, 1, 7, '2-1-X-1', 3, 7),
    (6, 43, 'secundario', 17, 2, 7, '2-1-X-1', 2, 8);

-- ---------- SEMANA 3 (dia_id=9) ----------
-- CALENTAMIENTO (2 RONDAS): JUMPING JACK, HALF-KNEELING LOADED DORSIFLEXION, SHOULDER BOX STRETCH, KB HALO, WALL SQUAT HOLD, KB PLANK HAND TAPS
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (9, 24, 'calentamiento', 1, 2, 30, NULL, NULL, NULL),
    (9, 1, 'calentamiento', 2, 2, 20, NULL, NULL, NULL),
    (9, 8, 'calentamiento', 3, 2, 20, NULL, NULL, NULL),
    (9, 3, 'calentamiento', 4, 2, 10, NULL, NULL, NULL),
    (9, 4, 'calentamiento', 5, 2, 30, NULL, NULL, NULL),
    (9, 5, 'calentamiento', 6, 2, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (9, 33, 'principal', 7, 1, 4, '2-1-X-1', 4, 6),
    (9, 33, 'principal', 2, 1, 4, '2-1-X-1', 3, 7),
    (9, 33, 'principal', 3, 3, 4, '2-1-X-1', 2, 8),
    (9, 34, 'principal', 4, 1, 4, '2-1-X-1', 4, 6),
    (9, 34, 'principal', 5, 1, 4, '2-1-X-1', 3, 7),
    (9, 34, 'principal', 6, 3, 4, '2-1-X-1', 2, 8),
    (9, 41, 'secundario', 7, 1, 6, '2-1-X-1', 4, 6),
    (9, 41, 'secundario', 8, 1, 6, '2-1-X-1', 3, 7),
    (9, 41, 'secundario', 9, 2, 6, '2-1-X-1', 2, 8),
    (9, 42, 'secundario', 10, 1, 6, '2-1-X-1', 4, 6),
    (9, 42, 'secundario', 11, 1, 6, '2-1-X-1', 3, 7),
    (9, 42, 'secundario', 12, 2, 6, '2-1-X-1', 2, 8),
    (9, 43, 'secundario', 13, 1, 6, '2-1-X-1', 4, 6),
    (9, 43, 'secundario', 14, 1, 6, '2-1-X-1', 3, 7),
    (9, 43, 'secundario', 15, 2, 6, '2-1-X-1', 2, 8);

-- ---------- SEMANA 4 (dia_id=12) ----------
-- CALENTAMIENTO (3 RONDAS): PNF TO IMPROVE ANKLE DORSIFLEXION, KB GOOD MORNING, PLATE ROMANIAN DEADLIFT, BAR ROW
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (12, 11, 'calentamiento', 1, 3, 20, NULL, NULL, NULL),
    (12, 13, 'calentamiento', 2, 3, 10, NULL, NULL, NULL),
    (12, 14, 'calentamiento', 3, 3, 10, NULL, NULL, NULL),
    (12, 39, 'calentamiento', 4, 3, 10, NULL, NULL, NULL),
    (12, 16, 'calentamiento', 5, 3, 15, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (12, 33, 'principal', 6, 1, 4, '2-1-X-1', 4, 6),
    (12, 33, 'principal', 2, 1, 4, '2-1-X-1', 3, 7),
    (12, 33, 'principal', 3, 2, 4, '2-1-X-1', 2, 8),
    (12, 33, 'principal', 4, 1, 3, '2-1-X-1', 2, 8),
    (12, 34, 'principal', 5, 1, 4, '2-1-X-1', 4, 6),
    (12, 34, 'principal', 6, 1, 4, '2-1-X-1', 3, 7),
    (12, 34, 'principal', 7, 2, 4, '2-1-X-1', 2, 8),
    (12, 34, 'principal', 8, 1, 3, '2-1-X-1', 2, 8),
    (12, 41, 'secundario', 9, 1, 5, '2-1-X-1', 4, 6),
    (12, 41, 'secundario', 10, 1, 5, '2-1-X-1', 3, 7),
    (12, 41, 'secundario', 11, 2, 5, '2-1-X-1', 2, 8),
    (12, 42, 'secundario', 12, 1, 5, '2-1-X-1', 4, 6),
    (12, 42, 'secundario', 13, 1, 5, '2-1-X-1', 3, 7),
    (12, 42, 'secundario', 14, 2, 5, '2-1-X-1', 2, 8),
    (12, 43, 'secundario', 15, 1, 5, '2-1-X-1', 4, 6),
    (12, 43, 'secundario', 16, 1, 5, '2-1-X-1', 3, 7),
    (12, 43, 'secundario', 17, 2, 5, '2-1-X-1', 2, 8);

-- ---------- SEMANA 5 (dia_id=15) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (15, 33, 'principal', 1, 1, 3, '2-0-X-1', 4, 6),
    (15, 33, 'principal', 2, 1, 3, '2-0-X-1', 3, 7),
    (15, 33, 'principal', 3, 3, 3, '2-0-X-1', 2, 8),
    (15, 34, 'principal', 4, 1, 3, '2-0-X-1', 4, 6),
    (15, 34, 'principal', 5, 1, 3, '2-0-X-1', 3, 7),
    (15, 34, 'principal', 6, 3, 3, '2-0-X-1', 2, 8),
    (15, 41, 'secundario', 7, 1, 4, '2-1-X-1', 4, 6),
    (15, 41, 'secundario', 8, 1, 4, '2-1-X-1', 3, 7),
    (15, 41, 'secundario', 9, 2, 4, '2-1-X-1', 2, 8),
    (15, 42, 'secundario', 10, 1, 4, '2-1-X-1', 4, 6),
    (15, 42, 'secundario', 11, 1, 4, '2-1-X-1', 3, 7),
    (15, 42, 'secundario', 12, 2, 4, '2-1-X-1', 2, 8),
    (15, 43, 'secundario', 13, 1, 4, '2-1-X-1', 4, 6),
    (15, 43, 'secundario', 14, 1, 4, '2-1-X-1', 3, 7),
    (15, 43, 'secundario', 15, 2, 4, '2-1-X-1', 2, 8);

-- ---------- SEMANA 6 (dia_id=18) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (18, 33, 'principal', 1, 1, 3, '2-0-X-1', 4, 6),
    (18, 33, 'principal', 2, 1, 3, '2-0-X-1', 3, 7),
    (18, 33, 'principal', 3, 2, 3, '2-0-X-1', 2, 8),
    (18, 33, 'principal', 4, 1, 2, '2-0-X-1', 2, 8),
    (18, 34, 'principal', 5, 1, 3, '2-0-X-1', 4, 6),
    (18, 34, 'principal', 6, 1, 3, '2-0-X-1', 3, 7),
    (18, 34, 'principal', 7, 2, 3, '2-0-X-1', 2, 8),
    (18, 34, 'principal', 8, 1, 2, '2-0-X-1', 2, 8),
    (18, 41, 'secundario', 9, 1, 3, '2-1-X-1', 4, 6),
    (18, 41, 'secundario', 10, 1, 3, '2-1-X-1', 3, 7),
    (18, 41, 'secundario', 11, 2, 3, '2-1-X-1', 2, 8),
    (18, 42, 'secundario', 12, 1, 3, '2-1-X-1', 4, 6),
    (18, 42, 'secundario', 13, 1, 3, '2-1-X-1', 3, 7),
    (18, 42, 'secundario', 14, 2, 3, '2-1-X-1', 2, 8),
    (18, 43, 'secundario', 15, 1, 3, '2-1-X-1', 4, 6),
    (18, 43, 'secundario', 16, 1, 3, '2-1-X-1', 3, 7),
    (18, 43, 'secundario', 17, 2, 3, '2-1-X-1', 2, 8);

-- ---------- SEMANA 7 (dia_id=21) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (21, 33, 'principal', 1, 1, 2, '2-0-X-1', 4, 6),
    (21, 33, 'principal', 2, 1, 2, '2-0-X-1', 3, 7),
    (21, 33, 'principal', 3, 3, 2, '2-0-X-1', 2, 8),
    (21, 34, 'principal', 4, 1, 2, '1-0-X-1', 4, 6),
    (21, 34, 'principal', 5, 1, 2, '1-0-X-1', 3, 7),
    (21, 34, 'principal', 6, 3, 2, '1-0-X-1', 2, 8),
    (21, 41, 'secundario', 7, 1, 2, '2-1-X-1', 4, 6),
    (21, 41, 'secundario', 8, 1, 2, '2-1-X-1', 3, 7),
    (21, 41, 'secundario', 9, 2, 2, '2-1-X-1', 2, 8),
    (21, 42, 'secundario', 10, 1, 2, '2-1-X-1', 4, 6),
    (21, 42, 'secundario', 11, 1, 2, '2-1-X-1', 3, 7),
    (21, 42, 'secundario', 12, 2, 2, '2-1-X-1', 2, 8),
    (21, 43, 'secundario', 13, 1, 2, '2-1-X-1', 4, 6),
    (21, 43, 'secundario', 14, 1, 2, '2-1-X-1', 3, 7),
    (21, 43, 'secundario', 15, 2, 2, '2-1-X-1', 2, 8);

-- ---------- SEMANA 8 (dia_id=24) ----------
-- CALENTAMIENTO (3 RONDAS): RUN, ANKLE DISTRACTION, QUADRUPED HIP ROCKING, CAT CAMEL, KB TATER, BANDED OHS
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (24, 15, 'calentamiento', 1, 3, 3, NULL, NULL, NULL),
    (24, 25, 'calentamiento', 2, 3, 20, NULL, NULL, NULL),
    (24, 26, 'calentamiento', 3, 3, 10, NULL, NULL, NULL),
    (24, 2, 'calentamiento', 4, 3, 10, NULL, NULL, NULL),
    (24, 27, 'calentamiento', 5, 3, 10, NULL, NULL, NULL),
    (24, 28, 'calentamiento', 6, 3, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (24, 33, 'principal', 7, 1, 1, '2-0-X-1', 4, 6),
    (24, 33, 'principal', 2, 1, 1, '2-0-X-1', 3, 7),
    (24, 33, 'principal', 3, 3, 1, '2-0-X-1', 2, 8),
    (24, 34, 'principal', 4, 1, 1, '1-0-X-1', 4, 6),
    (24, 34, 'principal', 5, 1, 1, '1-0-X-1', 3, 7),
    (24, 34, 'principal', 6, 3, 1, '1-0-X-1', 2, 8),
    (24, 41, 'secundario', 7, 1, 1, '2-1-X-1', 4, 6),
    (24, 41, 'secundario', 8, 1, 1, '2-1-X-1', 3, 7),
    (24, 41, 'secundario', 9, 2, 1, '2-1-X-1', 2, 8),
    (24, 42, 'secundario', 10, 1, 1, '2-1-X-1', 4, 6),
    (24, 42, 'secundario', 11, 1, 1, '2-1-X-1', 3, 7),
    (24, 42, 'secundario', 12, 2, 1, '2-1-X-1', 2, 8),
    (24, 43, 'secundario', 13, 1, 1, '2-1-X-1', 4, 6),
    (24, 43, 'secundario', 14, 1, 1, '2-1-X-1', 3, 7),
    (24, 43, 'secundario', 15, 2, 1, '2-1-X-1', 2, 8);

-- =====================================================
-- SERIES - FUERZA AVANZADO 3 HIPERTROFIA - DÍA 1 - SEMANAS 2-8
-- =====================================================

-- ---------- SEMANA 2 (dia_id=27) ----------
-- CALENTAMIENTO (3 RONDAS): HALF-KNEELING LOADED DORSIFLEXION, CAT CAMEL, WALL ANGEL, SHOULDER BOX STRETCH, BANDED SQUAT
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (27, 1, 'calentamiento', 1, 3, 20, NULL, NULL, NULL),
    (27, 2, 'calentamiento', 2, 3, 5, NULL, NULL, NULL),
    (27, 7, 'calentamiento', 3, 3, 10, NULL, NULL, NULL),
    (27, 8, 'calentamiento', 4, 3, 20, NULL, NULL, NULL),
    (27, 10, 'calentamiento', 5, 3, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (27, 29, 'principal', 6, 1, 12, '2-0-X-1', 3, 7),
    (27, 29, 'principal', 2, 2, 12, '2-0-X-1', 2, 8),
    (27, 29, 'principal', 3, 2, 12, '2-0-X-1', 1, 9),
    (27, 32, 'principal', 4, 1, 12, '2-0-X-1', 3, 7),
    (27, 32, 'principal', 5, 2, 12, '2-0-X-1', 2, 8),
    (27, 32, 'principal', 6, 2, 12, '2-0-X-1', 1, 9),
    (27, 44, 'secundario', 7, 1, 12, '2-1-X-2', 3, 7),
    (27, 44, 'secundario', 8, 2, 12, '2-1-X-2', 2, 8),
    (27, 44, 'secundario', 9, 2, 12, '2-1-X-2', 1, 9),
    (27, 38, 'secundario', 10, 1, 12, '2-1-X-1', 3, 7),
    (27, 38, 'secundario', 11, 2, 12, '2-1-X-1', 2, 8),
    (27, 38, 'secundario', 12, 2, 12, '2-1-X-1', 1, 9),
    (27, 45, 'secundario', 13, 1, 12, '2-1-X-2', 3, 7),
    (27, 45, 'secundario', 14, 2, 12, '2-1-X-2', 2, 8),
    (27, 45, 'secundario', 15, 2, 12, '2-1-X-2', 1, 9),
    (27, 50, 'core', 16, 4, 20, NULL, NULL, NULL),
    (27, 51, 'core', 17, 3, 20, NULL, NULL, NULL);

-- ---------- SEMANA 3 (dia_id=29) ----------
-- CALENTAMIENTO (2 RONDAS): WALL LEANING DOUBLE LEG CALF RAISE, DORSIFLEXION TOBILLO, SPIDERMAN, KB HIP OPENER, SCAPULAR PUSH UP, BOX SHOULDER STRETCH
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (29, 20, 'calentamiento', 1, 2, 20, NULL, NULL, NULL),
    (29, 21, 'calentamiento', 2, 2, 20, NULL, NULL, NULL),
    (29, 22, 'calentamiento', 3, 2, 5, NULL, NULL, NULL),
    (29, 23, 'calentamiento', 4, 2, 10, NULL, NULL, NULL),
    (29, 18, 'calentamiento', 5, 2, 10, NULL, NULL, NULL),
    (29, 8, 'calentamiento', 6, 2, 20, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (29, 29, 'principal', 7, 1, 10, '2-0-X-1', 3, 7),
    (29, 29, 'principal', 2, 1, 10, '2-0-X-1', 2, 8),
    (29, 29, 'principal', 3, 3, 10, '2-0-X-1', 1, 9),
    (29, 32, 'principal', 4, 1, 10, '2-0-X-1', 3, 7),
    (29, 32, 'principal', 5, 1, 10, '2-0-X-1', 2, 8),
    (29, 32, 'principal', 6, 3, 10, '2-0-X-1', 1, 9),
    (29, 44, 'secundario', 7, 1, 10, '2-2-X-2', 3, 7),
    (29, 44, 'secundario', 8, 1, 10, '2-2-X-2', 2, 8),
    (29, 44, 'secundario', 9, 3, 10, '2-2-X-2', 1, 9),
    (29, 38, 'secundario', 10, 1, 10, '2-1-X-1', 3, 7),
    (29, 38, 'secundario', 11, 1, 10, '2-1-X-1', 2, 8),
    (29, 38, 'secundario', 12, 3, 10, '2-1-X-1', 1, 9),
    (29, 45, 'secundario', 13, 1, 10, '2-1-X-2', 3, 7),
    (29, 45, 'secundario', 14, 1, 10, '2-1-X-2', 2, 8),
    (29, 45, 'secundario', 15, 3, 10, '2-1-X-2', 1, 9),
    (29, 50, 'core', 16, 4, 25, NULL, NULL, NULL),
    (29, 51, 'core', 17, 3, 20, NULL, NULL, NULL);

-- ---------- SEMANA 4 (dia_id=31) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (31, 29, 'principal', 1, 1, 9, '2-0-X-1', 3, 7),
    (31, 29, 'principal', 2, 1, 9, '2-0-X-1', 2, 8),
    (31, 29, 'principal', 3, 3, 9, '2-0-X-1', 1, 9),
    (31, 32, 'principal', 4, 1, 9, '2-0-X-1', 3, 7),
    (31, 32, 'principal', 5, 1, 9, '2-0-X-1', 2, 8),
    (31, 32, 'principal', 6, 3, 9, '2-0-X-1', 1, 9),
    (31, 44, 'secundario', 7, 1, 9, '2-2-X-2', 3, 7),
    (31, 44, 'secundario', 8, 1, 9, '2-2-X-2', 2, 8),
    (31, 44, 'secundario', 9, 3, 9, '2-2-X-2', 1, 9),
    (31, 38, 'secundario', 10, 1, 9, '2-1-X-1', 3, 7),
    (31, 38, 'secundario', 11, 1, 9, '2-1-X-1', 2, 8),
    (31, 38, 'secundario', 12, 3, 9, '2-1-X-1', 1, 9),
    (31, 45, 'secundario', 13, 1, 9, '2-1-X-2', 3, 7),
    (31, 45, 'secundario', 14, 1, 9, '2-1-X-2', 2, 8),
    (31, 45, 'secundario', 15, 3, 9, '2-1-X-2', 1, 9),
    (31, 50, 'core', 16, 4, 25, NULL, NULL, NULL),
    (31, 51, 'core', 17, 3, 20, NULL, NULL, NULL);

-- ---------- SEMANA 5 (dia_id=33) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (33, 29, 'principal', 1, 1, 8, '2-0-X-1', 3, 7),
    (33, 29, 'principal', 2, 2, 8, '2-0-X-1', 2, 8),
    (33, 29, 'principal', 3, 2, 8, '2-0-X-1', 1, 9),
    (33, 32, 'principal', 4, 1, 8, '2-0-X-1', 3, 7),
    (33, 32, 'principal', 5, 2, 8, '2-0-X-1', 2, 8),
    (33, 32, 'principal', 6, 2, 8, '2-0-X-1', 1, 9),
    (33, 44, 'secundario', 7, 1, 8, '2-1-X-2', 3, 7),
    (33, 44, 'secundario', 8, 2, 8, '2-1-X-2', 2, 8),
    (33, 44, 'secundario', 9, 2, 8, '2-1-X-2', 1, 9),
    (33, 38, 'secundario', 10, 1, 8, '2-1-X-1', 3, 7),
    (33, 38, 'secundario', 11, 2, 8, '2-1-X-1', 2, 8),
    (33, 38, 'secundario', 12, 2, 8, '2-1-X-1', 1, 9),
    (33, 45, 'secundario', 13, 1, 8, '2-1-X-2', 3, 7),
    (33, 45, 'secundario', 14, 2, 8, '2-1-X-2', 2, 8),
    (33, 45, 'secundario', 15, 2, 8, '2-1-X-2', 1, 9),
    (33, 50, 'core', 16, 4, 30, NULL, NULL, NULL),
    (33, 51, 'core', 17, 3, 25, NULL, NULL, NULL);

-- ---------- SEMANA 6 (dia_id=35) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (35, 29, 'principal', 1, 1, 8, '2-0-X-1', 3, 7),
    (35, 29, 'principal', 2, 1, 8, '2-0-X-1', 2, 8),
    (35, 29, 'principal', 3, 3, 8, '2-0-X-1', 1, 9),
    (35, 32, 'principal', 4, 1, 8, '2-0-X-1', 3, 7),
    (35, 32, 'principal', 5, 1, 8, '2-0-X-1', 2, 8),
    (35, 32, 'principal', 6, 3, 8, '2-0-X-1', 1, 9),
    (35, 44, 'secundario', 7, 1, 8, '2-1-X-2', 3, 7),
    (35, 44, 'secundario', 8, 1, 8, '2-1-X-2', 2, 8),
    (35, 44, 'secundario', 9, 3, 8, '2-1-X-2', 1, 9),
    (35, 38, 'secundario', 10, 1, 8, '2-1-X-1', 3, 7),
    (35, 38, 'secundario', 11, 1, 8, '2-1-X-1', 2, 8),
    (35, 38, 'secundario', 12, 3, 8, '2-1-X-1', 1, 9),
    (35, 45, 'secundario', 13, 1, 8, '2-1-X-2', 3, 7),
    (35, 45, 'secundario', 14, 1, 8, '2-1-X-2', 2, 8),
    (35, 45, 'secundario', 15, 3, 8, '2-1-X-2', 1, 9),
    (35, 50, 'core', 16, 4, 30, NULL, NULL, NULL),
    (35, 51, 'core', 17, 3, 25, NULL, NULL, NULL);

-- ---------- SEMANA 7 (dia_id=37) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (37, 29, 'principal', 1, 1, 7, '2-0-X-1', 3, 7),
    (37, 29, 'principal', 2, 2, 7, '2-0-X-1', 2, 8),
    (37, 29, 'principal', 3, 2, 7, '2-0-X-1', 1, 9),
    (37, 32, 'principal', 4, 1, 7, '2-0-X-1', 3, 7),
    (37, 32, 'principal', 5, 2, 7, '2-0-X-1', 2, 8),
    (37, 32, 'principal', 6, 2, 7, '2-0-X-1', 1, 9),
    (37, 44, 'secundario', 7, 1, 7, '2-1-X-2', 3, 7),
    (37, 44, 'secundario', 8, 2, 7, '2-1-X-2', 2, 8),
    (37, 44, 'secundario', 9, 2, 7, '2-1-X-2', 1, 9),
    (37, 38, 'secundario', 10, 1, 7, '2-1-X-1', 3, 7),
    (37, 38, 'secundario', 11, 2, 7, '2-1-X-1', 2, 8),
    (37, 38, 'secundario', 12, 2, 7, '2-1-X-1', 1, 9),
    (37, 45, 'secundario', 13, 1, 7, '2-1-X-2', 3, 7),
    (37, 45, 'secundario', 14, 2, 7, '2-1-X-2', 2, 8),
    (37, 45, 'secundario', 15, 2, 7, '2-1-X-2', 1, 9),
    (37, 50, 'core', 16, 4, 35, NULL, NULL, NULL),
    (37, 51, 'core', 17, 3, 30, NULL, NULL, NULL);

-- ---------- SEMANA 8 (dia_id=39) ----------
-- CALENTAMIENTO (3 RONDAS): HALF-KNEELING LOADED DORSIFLEXION, CAT CAMEL, WALL ANGEL, SHOULDER BOX STRETCH, BANDED SQUAT
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (39, 1, 'calentamiento', 1, 3, 20, NULL, NULL, NULL),
    (39, 2, 'calentamiento', 2, 3, 5, NULL, NULL, NULL),
    (39, 7, 'calentamiento', 3, 3, 10, NULL, NULL, NULL),
    (39, 8, 'calentamiento', 4, 3, 20, NULL, NULL, NULL),
    (39, 10, 'calentamiento', 5, 3, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (39, 29, 'principal', 6, 1, 7, '2-0-X-1', 3, 7),
    (39, 29, 'principal', 2, 1, 7, '2-0-X-1', 2, 8),
    (39, 29, 'principal', 3, 3, 7, '2-0-X-1', 1, 9),
    (39, 32, 'principal', 4, 1, 7, '2-0-X-1', 3, 7),
    (39, 32, 'principal', 5, 1, 7, '2-0-X-1', 2, 8),
    (39, 32, 'principal', 6, 3, 7, '2-0-X-1', 1, 9),
    (39, 44, 'secundario', 7, 1, 7, '2-1-X-2', 3, 7),
    (39, 44, 'secundario', 8, 1, 7, '2-1-X-2', 2, 8),
    (39, 44, 'secundario', 9, 3, 7, '2-1-X-2', 1, 9),
    (39, 38, 'secundario', 10, 1, 7, '2-1-X-1', 3, 7),
    (39, 38, 'secundario', 11, 1, 7, '2-1-X-1', 2, 8),
    (39, 38, 'secundario', 12, 3, 7, '2-1-X-1', 1, 9),
    (39, 45, 'secundario', 13, 1, 7, '2-1-X-2', 3, 7),
    (39, 45, 'secundario', 14, 1, 7, '2-1-X-2', 2, 8),
    (39, 45, 'secundario', 15, 3, 7, '2-1-X-2', 1, 9),
    (39, 50, 'core', 16, 4, 35, NULL, NULL, NULL),
    (39, 51, 'core', 17, 3, 30, NULL, NULL, NULL);

-- =====================================================
-- SERIES - FUERZA AVANZADO 3 HIPERTROFIA - DÍA 2 - SEMANAS 1-8
-- =====================================================

-- ---------- SEMANA 1 (dia_id=26) ----------
-- CALENTAMIENTO (2 RONDAS)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (26, 2, 'calentamiento', 1, 2, 5, NULL, NULL, NULL),
    (26, 3, 'calentamiento', 2, 2, 10, NULL, NULL, NULL),
    (26, 4, 'calentamiento', 3, 2, 30, NULL, NULL, NULL),
    (26, 5, 'calentamiento', 4, 2, 10, NULL, NULL, NULL),
    (26, 6, 'calentamiento', 5, 2, 5, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (26, 30, 'principal', 6, 1, 14, '2-1-X-1', 3, 7),
    (26, 30, 'principal', 7, 2, 14, '2-1-X-1', 2, 8),
    (26, 30, 'principal', 8, 1, 14, '2-1-X-1', 1, 9),
    (26, 49, 'principal', 9, 1, 14, '2-1-X-1', 3, 7),
    (26, 49, 'principal', 10, 2, 14, '2-1-X-1', 2, 8),
    (26, 49, 'principal', 11, 1, 14, '2-1-X-1', 1, 9),
    (26, 47, 'secundario', 12, 1, 14, '2-1-X-1', 3, 7),
    (26, 47, 'secundario', 13, 2, 14, '2-1-X-1', 2, 8),
    (26, 47, 'secundario', 14, 1, 14, '2-1-X-1', 1, 9),
    (26, 46, 'secundario', 15, 1, 14, '2-1-X-1', 3, 7),
    (26, 46, 'secundario', 16, 2, 14, '2-1-X-1', 2, 8),
    (26, 46, 'secundario', 17, 1, 14, '2-1-X-1', 1, 9),
    (26, 48, 'secundario', 18, 1, 20, '3-1-X-2', 4, 6),
    (26, 48, 'secundario', 19, 2, 20, '3-1-X-2', 3, 7),
    (26, 48, 'secundario', 20, 1, 20, '3-1-X-2', 2, 8),
    (26, 55, 'core', 21, 4, 20, NULL, NULL, NULL),
    (26, 56, 'core', 22, 4, 20, NULL, NULL, NULL);

-- ---------- SEMANA 2 (dia_id=28) ----------
-- CALENTAMIENTO (2 RONDAS): JUMPING JACK, HALF-KNEELING LOADED DORSIFLEXION, SHOULDER BOX STRETCH, KB HALO, WALL SQUAT HOLD, KB PLANK HAND TAPS
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (28, 24, 'calentamiento', 1, 2, 30, NULL, NULL, NULL),
    (28, 1, 'calentamiento', 2, 2, 20, NULL, NULL, NULL),
    (28, 8, 'calentamiento', 3, 2, 20, NULL, NULL, NULL),
    (28, 3, 'calentamiento', 4, 2, 10, NULL, NULL, NULL),
    (28, 4, 'calentamiento', 5, 2, 30, NULL, NULL, NULL),
    (28, 5, 'calentamiento', 6, 2, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (28, 30, 'principal', 7, 1, 12, '2-1-X-1', 3, 7),
    (28, 30, 'principal', 2, 2, 12, '2-1-X-1', 2, 8),
    (28, 30, 'principal', 3, 2, 12, '2-1-X-1', 1, 9),
    (28, 49, 'principal', 4, 1, 12, '2-1-X-1', 3, 7),
    (28, 49, 'principal', 5, 2, 12, '2-1-X-1', 2, 8),
    (28, 49, 'principal', 6, 2, 12, '2-1-X-1', 1, 9),
    (28, 47, 'secundario', 7, 1, 12, '2-1-X-1', 3, 7),
    (28, 47, 'secundario', 8, 2, 12, '2-1-X-1', 2, 8),
    (28, 47, 'secundario', 9, 2, 12, '2-1-X-1', 1, 9),
    (28, 46, 'secundario', 10, 1, 12, '2-1-X-1', 3, 7),
    (28, 46, 'secundario', 11, 2, 12, '2-1-X-1', 2, 8),
    (28, 46, 'secundario', 12, 2, 12, '2-1-X-1', 1, 9),
    (28, 48, 'secundario', 13, 1, 20, '3-1-X-2', 4, 6),
    (28, 48, 'secundario', 14, 2, 20, '3-1-X-2', 3, 7),
    (28, 48, 'secundario', 15, 2, 20, '3-1-X-2', 2, 8),
    (28, 52, 'core', 16, 4, 20, NULL, NULL, NULL),
    (28, 53, 'core', 17, 4, 20, NULL, NULL, NULL);

-- ---------- SEMANA 3 (dia_id=30) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (30, 30, 'principal', 1, 1, 10, '2-1-X-1', 3, 7),
    (30, 30, 'principal', 2, 1, 10, '2-1-X-1', 2, 8),
    (30, 30, 'principal', 3, 3, 10, '2-1-X-1', 1, 9),
    (30, 49, 'principal', 4, 1, 10, '2-1-X-1', 3, 7),
    (30, 49, 'principal', 5, 1, 10, '2-1-X-1', 2, 8),
    (30, 49, 'principal', 6, 3, 10, '2-1-X-1', 1, 9),
    (30, 47, 'secundario', 7, 1, 10, '2-1-X-1', 3, 7),
    (30, 47, 'secundario', 8, 1, 10, '2-1-X-1', 2, 8),
    (30, 47, 'secundario', 9, 3, 10, '2-1-X-1', 1, 9),
    (30, 46, 'secundario', 10, 1, 10, '2-1-X-1', 3, 7),
    (30, 46, 'secundario', 11, 1, 10, '2-1-X-1', 2, 8),
    (30, 46, 'secundario', 12, 3, 10, '2-1-X-1', 1, 9),
    (30, 48, 'secundario', 13, 1, 20, '3-1-X-2', 4, 6),
    (30, 48, 'secundario', 14, 1, 20, '3-1-X-2', 3, 7),
    (30, 48, 'secundario', 15, 3, 20, '3-1-X-2', 2, 8),
    (30, 52, 'core', 16, 4, 20, NULL, NULL, NULL),
    (30, 53, 'core', 17, 4, 20, NULL, NULL, NULL);

-- ---------- SEMANA 4 (dia_id=32) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (32, 30, 'principal', 1, 1, 9, '2-1-X-1', 3, 7),
    (32, 30, 'principal', 2, 1, 9, '2-1-X-1', 2, 8),
    (32, 30, 'principal', 3, 3, 9, '2-1-X-1', 1, 9),
    (32, 49, 'principal', 4, 1, 9, '2-1-X-1', 3, 7),
    (32, 49, 'principal', 5, 1, 9, '2-1-X-1', 2, 8),
    (32, 49, 'principal', 6, 3, 9, '2-1-X-1', 1, 9),
    (32, 47, 'secundario', 7, 1, 9, '2-1-X-1', 3, 7),
    (32, 47, 'secundario', 8, 1, 9, '2-1-X-1', 2, 8),
    (32, 47, 'secundario', 9, 3, 9, '2-1-X-1', 1, 9),
    (32, 46, 'secundario', 10, 1, 9, '2-1-X-1', 3, 7),
    (32, 46, 'secundario', 11, 1, 9, '2-1-X-1', 2, 8),
    (32, 46, 'secundario', 12, 3, 9, '2-1-X-1', 1, 9),
    (32, 48, 'secundario', 13, 1, 18, '3-1-X-2', 4, 6),
    (32, 48, 'secundario', 14, 1, 18, '3-1-X-2', 3, 7),
    (32, 48, 'secundario', 15, 3, 18, '3-1-X-2', 2, 8),
    (32, 52, 'core', 16, 4, 20, NULL, NULL, NULL),
    (32, 53, 'core', 17, 4, 20, NULL, NULL, NULL);

-- ---------- SEMANA 5 (dia_id=34) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (34, 30, 'principal', 1, 1, 8, '2-0-X-1', 3, 7),
    (34, 30, 'principal', 2, 2, 8, '2-0-X-1', 2, 8),
    (34, 30, 'principal', 3, 2, 8, '2-0-X-1', 1, 9),
    (34, 49, 'principal', 4, 1, 8, '2-1-X-1', 3, 7),
    (34, 49, 'principal', 5, 2, 8, '2-1-X-1', 2, 8),
    (34, 49, 'principal', 6, 2, 8, '2-1-X-1', 1, 9),
    (34, 47, 'secundario', 7, 1, 8, '2-0-X-1', 3, 7),
    (34, 47, 'secundario', 8, 2, 8, '2-0-X-1', 2, 8),
    (34, 47, 'secundario', 9, 2, 8, '2-0-X-1', 1, 9),
    (34, 46, 'secundario', 10, 1, 8, '2-1-X-1', 3, 7),
    (34, 46, 'secundario', 11, 2, 8, '2-1-X-1', 2, 8),
    (34, 46, 'secundario', 12, 2, 8, '2-1-X-1', 1, 9),
    (34, 48, 'secundario', 13, 1, 16, '3-1-X-2', 4, 6),
    (34, 48, 'secundario', 14, 2, 16, '3-1-X-2', 3, 7),
    (34, 48, 'secundario', 15, 2, 16, '3-1-X-2', 2, 8),
    (34, 52, 'core', 16, 4, 20, NULL, NULL, NULL),
    (34, 53, 'core', 17, 4, 20, NULL, NULL, NULL);

-- ---------- SEMANA 6 (dia_id=36) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (36, 30, 'principal', 1, 1, 8, '2-0-X-1', 3, 7),
    (36, 30, 'principal', 2, 1, 8, '2-0-X-1', 2, 8),
    (36, 30, 'principal', 3, 3, 8, '2-0-X-1', 1, 9),
    (36, 49, 'principal', 4, 1, 8, '2-1-X-1', 3, 7),
    (36, 49, 'principal', 5, 1, 8, '2-1-X-1', 2, 8),
    (36, 49, 'principal', 6, 3, 8, '2-1-X-1', 1, 9),
    (36, 47, 'secundario', 7, 1, 8, '2-0-X-1', 3, 7),
    (36, 47, 'secundario', 8, 1, 8, '2-0-X-1', 2, 8),
    (36, 47, 'secundario', 9, 3, 8, '2-0-X-1', 1, 9),
    (36, 46, 'secundario', 10, 1, 8, '2-1-X-1', 3, 7),
    (36, 46, 'secundario', 11, 1, 8, '2-1-X-1', 2, 8),
    (36, 46, 'secundario', 12, 3, 8, '2-1-X-1', 1, 9),
    (36, 48, 'secundario', 13, 1, 16, '3-1-X-2', 4, 6),
    (36, 48, 'secundario', 14, 1, 16, '3-1-X-2', 3, 7),
    (36, 48, 'secundario', 15, 3, 16, '3-1-X-2', 2, 8),
    (36, 52, 'core', 16, 4, 20, NULL, NULL, NULL),
    (36, 53, 'core', 17, 4, 20, NULL, NULL, NULL);

-- ---------- SEMANA 7 (dia_id=38) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (38, 30, 'principal', 1, 1, 7, '2-0-X-1', 3, 7),
    (38, 30, 'principal', 2, 2, 7, '2-0-X-1', 2, 8),
    (38, 30, 'principal', 3, 2, 7, '2-0-X-1', 1, 9),
    (38, 49, 'principal', 4, 1, 7, '2-1-X-1', 3, 7),
    (38, 49, 'principal', 5, 2, 7, '2-1-X-1', 2, 8),
    (38, 49, 'principal', 6, 2, 7, '2-1-X-1', 1, 9),
    (38, 47, 'secundario', 7, 1, 7, '2-0-X-1', 3, 7),
    (38, 47, 'secundario', 8, 2, 7, '2-0-X-1', 2, 8),
    (38, 47, 'secundario', 9, 2, 7, '2-0-X-1', 1, 9),
    (38, 46, 'secundario', 10, 1, 7, '2-1-X-1', 3, 7),
    (38, 46, 'secundario', 11, 2, 7, '2-1-X-1', 2, 8),
    (38, 46, 'secundario', 12, 2, 7, '2-1-X-1', 1, 9),
    (38, 48, 'secundario', 13, 1, 14, '3-1-X-2', 4, 6),
    (38, 48, 'secundario', 14, 2, 14, '3-1-X-2', 3, 7),
    (38, 48, 'secundario', 15, 2, 14, '3-1-X-2', 2, 8),
    (38, 52, 'core', 16, 4, 20, NULL, NULL, NULL),
    (38, 53, 'core', 17, 4, 20, NULL, NULL, NULL);

-- ---------- SEMANA 8 (dia_id=40) ----------
-- CALENTAMIENTO (2 RONDAS): JUMPING JACK, HALF-KNEELING LOADED DORSIFLEXION, SHOULDER BOX STRETCH, KB HALO, WALL SQUAT HOLD, KB PLANK HAND TAPS
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (40, 24, 'calentamiento', 1, 2, 30, NULL, NULL, NULL),
    (40, 1, 'calentamiento', 2, 2, 20, NULL, NULL, NULL),
    (40, 8, 'calentamiento', 3, 2, 20, NULL, NULL, NULL),
    (40, 3, 'calentamiento', 4, 2, 10, NULL, NULL, NULL),
    (40, 4, 'calentamiento', 5, 2, 30, NULL, NULL, NULL),
    (40, 5, 'calentamiento', 6, 2, 10, NULL, NULL, NULL);

INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (40, 30, 'principal', 7, 1, 7, '2-0-X-1', 3, 7),
    (40, 30, 'principal', 2, 1, 7, '2-0-X-1', 2, 8),
    (40, 30, 'principal', 3, 3, 7, '2-0-X-1', 1, 9),
    (40, 49, 'principal', 4, 1, 7, '2-1-X-1', 3, 7),
    (40, 49, 'principal', 5, 1, 7, '2-1-X-1', 2, 8),
    (40, 49, 'principal', 6, 3, 7, '2-1-X-1', 1, 9),
    (40, 47, 'secundario', 7, 1, 7, '2-0-X-1', 3, 7),
    (40, 47, 'secundario', 8, 1, 7, '2-0-X-1', 2, 8),
    (40, 47, 'secundario', 9, 3, 7, '2-0-X-1', 1, 9),
    (40, 46, 'secundario', 10, 1, 7, '2-1-X-1', 3, 7),
    (40, 46, 'secundario', 11, 1, 7, '2-1-X-1', 2, 8),
    (40, 46, 'secundario', 12, 3, 7, '2-1-X-1', 1, 9),
    (40, 48, 'secundario', 13, 1, 14, '3-1-X-2', 4, 6),
    (40, 48, 'secundario', 14, 1, 14, '3-1-X-2', 3, 7),
    (40, 48, 'secundario', 15, 3, 14, '3-1-X-2', 2, 8),
    (40, 52, 'core', 16, 4, 20, NULL, NULL, NULL),
    (40, 53, 'core', 17, 4, 20, NULL, NULL, NULL);

-- =====================================================
-- RLS (Row Level Security)
-- =====================================================

ALTER TABLE rutinas ENABLE ROW LEVEL SECURITY;
ALTER TABLE semanas ENABLE ROW LEVEL SECURITY;
ALTER TABLE dias ENABLE ROW LEVEL SECURITY;
ALTER TABLE tipos_ejercicio ENABLE ROW LEVEL SECURITY;
ALTER TABLE ejercicios ENABLE ROW LEVEL SECURITY;
ALTER TABLE series ENABLE ROW LEVEL SECURITY;
ALTER TABLE registros ENABLE ROW LEVEL SECURITY;

-- Políticas públicas
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

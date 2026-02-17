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
    (1, 1, 'Día 1'), (1, 2, 'Día 2'), (1, 3, 'Día 3'),
    (2, 1, 'Día 1'), (2, 2, 'Día 2'), (2, 3, 'Día 3'),
    (3, 1, 'Día 1'), (3, 2, 'Día 2'), (3, 3, 'Día 3'),
    (4, 1, 'Día 1'), (4, 2, 'Día 2'), (4, 3, 'Día 3'),
    (5, 1, 'Día 1'), (5, 2, 'Día 2'), (5, 3, 'Día 3'),
    (6, 1, 'Día 1'), (6, 2, 'Día 2'), (6, 3, 'Día 3'),
    (7, 1, 'Día 1'), (7, 2, 'Día 2'), (7, 3, 'Día 3'),
    (8, 1, 'Día 1'), (8, 2, 'Día 2'), (8, 3, 'Día 3');

-- Fuerza Avanzado 3 Hipertrofia: semanas 1-8
INSERT INTO semanas (rutina_id, numero) VALUES (2, 1), (2, 2), (2, 3), (2, 4), (2, 5), (2, 6), (2, 7), (2, 8);

-- Días Fuerza Avanzado 3 Hipertrofia (semanas 9-16)
INSERT INTO dias (semana_id, numero, nombre) VALUES 
    (9, 1, 'Día 1'), (9, 2, 'Día 2'),
    (10, 1, 'Día 1'), (10, 2, 'Día 2'),
    (11, 1, 'Día 1'), (11, 2, 'Día 2'),
    (12, 1, 'Día 1'), (12, 2, 'Día 2'),
    (13, 1, 'Día 1'), (13, 2, 'Día 2'),
    (14, 1, 'Día 1'), (14, 2, 'Día 2'),
    (15, 1, 'Día 1'), (15, 2, 'Día 2'),
    (16, 1, 'Día 1'), (16, 2, 'Día 2');

-- =====================================================
-- SERIES - FUERZA AVANZADO 2 - DÍA 1 - SEMANA 1 (dia_id=1)
-- =====================================================

-- BACK SQUAT (ejercicio_id=1)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (1, 1, 'principal', 1, 1, 5, '3-1-X-1', 4, 6),
    (1, 1, 'principal', 2, 1, 5, '3-1-X-1', 3, 7),
    (1, 1, 'principal', 3, 3, 5, '3-1-X-1', 2, 8);

-- PULL UP (ejercicio_id=2)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (1, 2, 'principal', 4, 1, 5, '2-1-X-1', 4, 6),
    (1, 2, 'principal', 5, 1, 5, '2-1-X-1', 3, 7),
    (1, 2, 'principal', 6, 3, 5, '2-1-X-1', 2, 8);

-- SEATED DB SHOULDER PRESS ALTERNO (ejercicio_id=7)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (1, 7, 'secundario', 7, 1, 8, '2-1-X-1', 4, 6),
    (1, 7, 'secundario', 8, 1, 8, '2-1-X-1', 3, 7),
    (1, 7, 'secundario', 9, 2, 8, '2-1-X-1', 2, 8);

-- TRICEP KICKBACK EXTENSION (ejercicio_id=8)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (1, 8, 'secundario', 10, 1, 8, '2-1-X-1', 4, 6),
    (1, 8, 'secundario', 11, 1, 8, '2-1-X-1', 3, 7),
    (1, 8, 'secundario', 12, 2, 8, '2-1-X-1', 2, 8);

-- COPENHAGEN HIP ABDUCTION HOLD (ejercicio_id=9)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (1, 9, 'secundario', 13, 2, 20, NULL, NULL, NULL);

-- =====================================================
-- SERIES - FUERZA AVANZADO 2 - DÍA 2 - SEMANA 1 (dia_id=2)
-- =====================================================

-- DL (ejercicio_id=3)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (2, 3, 'principal', 1, 1, 5, '3-1-X-1', 4, 6),
    (2, 3, 'principal', 2, 1, 5, '3-1-X-1', 3, 7),
    (2, 3, 'principal', 3, 3, 5, '3-1-X-1', 2, 8);

-- PRESS DE BANCA (ejercicio_id=4)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (2, 4, 'principal', 4, 1, 5, '3-1-X-1', 4, 6),
    (2, 4, 'principal', 5, 1, 5, '3-1-X-1', 3, 7),
    (2, 4, 'principal', 6, 3, 5, '3-1-X-1', 2, 8);

-- BULGARIAN SQUAT (ejercicio_id=10)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (2, 10, 'secundario', 7, 1, 8, '2-1-X-1', 4, 6),
    (2, 10, 'secundario', 8, 1, 8, '2-1-X-1', 3, 7),
    (2, 10, 'secundario', 9, 2, 8, '2-1-X-1', 2, 8);

-- BAR ROW (ejercicio_id=11)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (2, 11, 'secundario', 10, 1, 8, '2-1-X-1', 4, 6),
    (2, 11, 'secundario', 11, 1, 8, '2-1-X-1', 3, 7),
    (2, 11, 'secundario', 12, 2, 8, '2-1-X-1', 2, 8);

-- CURL DE BICEP (ejercicio_id=12)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (2, 12, 'secundario', 13, 1, 8, '2-1-X-1', 4, 6),
    (2, 12, 'secundario', 14, 1, 8, '2-1-X-1', 3, 7),
    (2, 12, 'secundario', 15, 2, 8, '2-1-X-1', 2, 8);

-- =====================================================
-- SERIES - FUERZA AVANZADO 2 - DÍA 3 - SEMANA 1 (dia_id=3)
-- =====================================================

-- SHOULDER PRESS (ejercicio_id=5)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (3, 5, 'principal', 1, 1, 5, '3-1-X-1', 4, 6),
    (3, 5, 'principal', 2, 1, 5, '3-1-X-1', 3, 7),
    (3, 5, 'principal', 3, 3, 5, '3-1-X-1', 2, 8);

-- FRONT SQUAT (ejercicio_id=6)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (3, 6, 'principal', 4, 1, 5, '3-1-X-1', 4, 6),
    (3, 6, 'principal', 5, 1, 5, '3-1-X-1', 3, 7),
    (3, 6, 'principal', 6, 3, 5, '3-1-X-1', 2, 8);

-- ALTERNATING DUMBBELL FLOOR PRESS (ejercicio_id=13)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (3, 13, 'secundario', 7, 1, 8, '2-1-X-1', 4, 6),
    (3, 13, 'secundario', 8, 1, 8, '2-1-X-1', 3, 7),
    (3, 13, 'secundario', 9, 2, 8, '2-1-X-1', 2, 8);

-- KB ONE ARM ROW (ejercicio_id=14)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (3, 14, 'secundario', 10, 1, 8, '2-1-X-1', 4, 6),
    (3, 14, 'secundario', 11, 1, 8, '2-1-X-1', 3, 7),
    (3, 14, 'secundario', 12, 2, 8, '2-1-X-1', 2, 8);

-- KB RDL (ejercicio_id=15)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (3, 15, 'secundario', 13, 1, 8, '2-1-X-1', 4, 6),
    (3, 15, 'secundario', 14, 1, 8, '2-1-X-1', 3, 7),
    (3, 15, 'secundario', 15, 2, 8, '2-1-X-1', 2, 8);

-- =====================================================
-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 1 - SEMANA 1 (dia_id=25)
-- =====================================================

-- BACK SQUAT (ejercicio_id=1)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 1, 'principal', 1, 1, 14, '2-0-X-1', 3, 7),
    (25, 1, 'principal', 2, 2, 14, '2-0-X-1', 2, 8),
    (25, 1, 'principal', 3, 1, 14, '2-0-X-1', 1, 9);

-- PRESS DE BANCA (ejercicio_id=4)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 4, 'principal', 4, 1, 14, '2-0-X-1', 3, 7),
    (25, 4, 'principal', 5, 2, 14, '2-0-X-1', 2, 8),
    (25, 4, 'principal', 6, 1, 14, '2-0-X-1', 1, 9);

-- BANDED TRICEPS EXTENSION (ejercicio_id=16)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 16, 'secundario', 7, 1, 14, '2-1-X-2', 3, 7),
    (25, 16, 'secundario', 8, 2, 14, '2-1-X-2', 2, 8),
    (25, 16, 'secundario', 9, 1, 14, '2-1-X-2', 1, 9);

-- BULGARIAN SQUAT (ejercicio_id=10)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 10, 'secundario', 10, 1, 14, '2-1-X-1', 3, 7),
    (25, 10, 'secundario', 11, 2, 14, '2-1-X-1', 2, 8),
    (25, 10, 'secundario', 12, 1, 14, '2-1-X-1', 1, 9);

-- BAND GLUTE KICKBACK (ejercicio_id=17)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 17, 'secundario', 13, 1, 14, '2-1-X-2', 3, 7),
    (25, 17, 'secundario', 14, 2, 14, '2-1-X-2', 2, 8),
    (25, 17, 'secundario', 15, 1, 14, '2-1-X-2', 1, 9);

-- HOLLOW HOLD (ejercicio_id=22)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 22, 'core', 16, 4, 20, NULL, NULL, NULL);

-- ARCH HOLD (ejercicio_id=23)
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (25, 23, 'core', 17, 3, 20, NULL, NULL, NULL);

-- =====================================================
-- SERIES - FUERZA AVANZADO 2 - DÍA 1 - SEMANAS 2-8
-- =====================================================

-- ---------- SEMANA 2 (dia_id=4) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (4, 1, 'principal', 1, 1, 5, '3-1-X-1', 4, 6),
    (4, 1, 'principal', 2, 1, 5, '3-1-X-1', 3, 7),
    (4, 1, 'principal', 3, 2, 5, '3-1-X-1', 2, 8),
    (4, 1, 'principal', 4, 1, 4, '3-1-X-1', 2, 8),
    (4, 2, 'principal', 5, 1, 5, '2-1-X-1', 4, 6),
    (4, 2, 'principal', 6, 1, 5, '2-1-X-1', 3, 7),
    (4, 2, 'principal', 7, 2, 5, '2-1-X-1', 2, 8),
    (4, 2, 'principal', 8, 1, 4, '2-1-X-1', 2, 8),
    (4, 7, 'secundario', 9, 1, 7, '2-1-X-1', 4, 6),
    (4, 7, 'secundario', 10, 1, 7, '2-1-X-1', 3, 7),
    (4, 7, 'secundario', 11, 2, 7, '2-1-X-1', 2, 8),
    (4, 8, 'secundario', 12, 1, 7, '2-1-X-1', 4, 6),
    (4, 8, 'secundario', 13, 1, 7, '2-1-X-1', 3, 7),
    (4, 8, 'secundario', 14, 2, 7, '2-1-X-1', 2, 8),
    (4, 9, 'secundario', 15, 2, 20, NULL, NULL, NULL);

-- ---------- SEMANA 3 (dia_id=7) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (7, 1, 'principal', 1, 1, 4, '2-1-X-1', 4, 6),
    (7, 1, 'principal', 2, 1, 4, '2-1-X-1', 3, 7),
    (7, 1, 'principal', 3, 3, 4, '2-1-X-1', 2, 8),
    (7, 2, 'principal', 4, 1, 4, '2-1-X-1', 4, 6),
    (7, 2, 'principal', 5, 1, 4, '2-1-X-1', 3, 7),
    (7, 2, 'principal', 6, 3, 4, '2-1-X-1', 2, 8),
    (7, 7, 'secundario', 7, 1, 6, '2-1-X-1', 4, 6),
    (7, 7, 'secundario', 8, 1, 6, '2-1-X-1', 3, 7),
    (7, 7, 'secundario', 9, 2, 6, '2-1-X-1', 2, 8),
    (7, 8, 'secundario', 10, 1, 6, '2-1-X-1', 4, 6),
    (7, 8, 'secundario', 11, 1, 6, '2-1-X-1', 3, 7),
    (7, 8, 'secundario', 12, 2, 6, '2-1-X-1', 2, 8),
    (7, 9, 'secundario', 13, 2, 20, NULL, NULL, NULL);

-- ---------- SEMANA 4 (dia_id=10) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (10, 1, 'principal', 1, 1, 4, '2-1-X-1', 4, 6),
    (10, 1, 'principal', 2, 1, 4, '2-1-X-1', 3, 7),
    (10, 1, 'principal', 3, 2, 4, '2-1-X-1', 2, 8),
    (10, 1, 'principal', 4, 1, 3, '2-1-X-1', 2, 8),
    (10, 2, 'principal', 5, 1, 4, '2-1-X-1', 4, 6),
    (10, 2, 'principal', 6, 1, 4, '2-1-X-1', 3, 7),
    (10, 2, 'principal', 7, 2, 4, '2-1-X-1', 2, 8),
    (10, 2, 'principal', 8, 1, 3, '2-1-X-1', 2, 8),
    (10, 7, 'secundario', 9, 1, 5, '2-1-X-1', 4, 6),
    (10, 7, 'secundario', 10, 1, 5, '2-1-X-1', 3, 7),
    (10, 7, 'secundario', 11, 2, 5, '2-1-X-1', 2, 8),
    (10, 8, 'secundario', 12, 1, 5, '2-1-X-1', 4, 6),
    (10, 8, 'secundario', 13, 1, 5, '2-1-X-1', 3, 7),
    (10, 8, 'secundario', 14, 2, 5, '2-1-X-1', 2, 8),
    (10, 9, 'secundario', 15, 2, 20, NULL, NULL, NULL);

-- ---------- SEMANA 5 (dia_id=13) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (13, 1, 'principal', 1, 1, 3, '2-0-X-1', 4, 6),
    (13, 1, 'principal', 2, 1, 3, '2-0-X-1', 3, 7),
    (13, 1, 'principal', 3, 3, 3, '2-0-X-1', 2, 8),
    (13, 2, 'principal', 4, 1, 3, '2-1-X-1', 4, 6),
    (13, 2, 'principal', 5, 1, 3, '2-1-X-1', 3, 7),
    (13, 2, 'principal', 6, 3, 3, '2-1-X-1', 2, 8),
    (13, 7, 'secundario', 7, 1, 4, '2-1-X-1', 4, 6),
    (13, 7, 'secundario', 8, 1, 4, '2-1-X-1', 3, 7),
    (13, 7, 'secundario', 9, 2, 4, '2-1-X-1', 2, 8),
    (13, 8, 'secundario', 10, 1, 4, '2-1-X-1', 4, 6),
    (13, 8, 'secundario', 11, 1, 4, '2-1-X-1', 3, 7),
    (13, 8, 'secundario', 12, 2, 4, '2-1-X-1', 2, 8),
    (13, 9, 'secundario', 13, 2, 30, NULL, NULL, NULL);

-- ---------- SEMANA 6 (dia_id=16) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (16, 1, 'principal', 1, 1, 3, '2-0-X-1', 4, 6),
    (16, 1, 'principal', 2, 1, 3, '2-0-X-1', 3, 7),
    (16, 1, 'principal', 3, 2, 3, '2-0-X-1', 2, 8),
    (16, 1, 'principal', 4, 1, 2, '2-0-X-1', 2, 8),
    (16, 2, 'principal', 5, 1, 3, '2-1-X-1', 4, 6),
    (16, 2, 'principal', 6, 1, 3, '2-1-X-1', 3, 7),
    (16, 2, 'principal', 7, 2, 3, '2-1-X-1', 2, 8),
    (16, 2, 'principal', 8, 1, 2, '2-1-X-1', 2, 8),
    (16, 7, 'secundario', 9, 1, 3, '2-1-X-1', 4, 6),
    (16, 7, 'secundario', 10, 1, 3, '2-1-X-1', 3, 7),
    (16, 7, 'secundario', 11, 2, 3, '2-1-X-1', 2, 8),
    (16, 8, 'secundario', 12, 1, 3, '2-1-X-1', 4, 6),
    (16, 8, 'secundario', 13, 1, 3, '2-1-X-1', 3, 7),
    (16, 8, 'secundario', 14, 2, 3, '2-1-X-1', 2, 8),
    (16, 9, 'secundario', 15, 2, 30, NULL, NULL, NULL);

-- ---------- SEMANA 7 (dia_id=19) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (19, 1, 'principal', 1, 1, 2, '1-0-X-1', 4, 6),
    (19, 1, 'principal', 2, 1, 2, '1-0-X-1', 3, 7),
    (19, 1, 'principal', 3, 3, 2, '1-0-X-1', 2, 8),
    (19, 2, 'principal', 4, 1, 2, '2-1-X-1', 4, 6),
    (19, 2, 'principal', 5, 1, 2, '2-1-X-1', 3, 7),
    (19, 2, 'principal', 6, 3, 2, '2-1-X-1', 2, 8),
    (19, 7, 'secundario', 7, 1, 2, '2-1-X-1', 4, 6),
    (19, 7, 'secundario', 8, 1, 2, '2-1-X-1', 3, 7),
    (19, 7, 'secundario', 9, 2, 2, '2-1-X-1', 2, 8),
    (19, 8, 'secundario', 10, 1, 2, '2-1-X-1', 4, 6),
    (19, 8, 'secundario', 11, 1, 2, '2-1-X-1', 3, 7),
    (19, 8, 'secundario', 12, 2, 2, '2-1-X-1', 2, 8),
    (19, 9, 'secundario', 13, 2, 30, NULL, NULL, NULL);

-- ---------- SEMANA 8 (dia_id=22) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (22, 1, 'principal', 1, 1, 1, '1-0-X-1', 4, 6),
    (22, 1, 'principal', 2, 1, 1, '1-0-X-1', 3, 7),
    (22, 1, 'principal', 3, 3, 1, '1-0-X-1', 2, 8),
    (22, 2, 'principal', 4, 1, 1, '2-1-X-1', 4, 6),
    (22, 2, 'principal', 5, 1, 1, '2-1-X-1', 3, 7),
    (22, 2, 'principal', 6, 3, 1, '2-1-X-1', 2, 8),
    (22, 7, 'secundario', 7, 1, 1, '2-1-X-1', 4, 6),
    (22, 7, 'secundario', 8, 1, 1, '2-1-X-1', 3, 7),
    (22, 7, 'secundario', 9, 2, 1, '2-1-X-1', 2, 8),
    (22, 8, 'secundario', 10, 1, 1, '2-1-X-1', 4, 6),
    (22, 8, 'secundario', 11, 1, 1, '2-1-X-1', 3, 7),
    (22, 8, 'secundario', 12, 2, 1, '2-1-X-1', 2, 8),
    (22, 9, 'secundario', 13, 2, 30, NULL, NULL, NULL);

-- =====================================================
-- SERIES - FUERZA AVANZADO 2 - DÍA 2 - SEMANAS 2-8
-- =====================================================

-- ---------- SEMANA 2 (dia_id=5) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (5, 3, 'principal', 1, 1, 5, '3-1-X-1', 4, 6),
    (5, 3, 'principal', 2, 1, 5, '3-1-X-1', 3, 7),
    (5, 3, 'principal', 3, 2, 5, '3-1-X-1', 2, 8),
    (5, 3, 'principal', 4, 1, 4, '3-1-X-1', 2, 8),
    (5, 4, 'principal', 5, 1, 5, '3-1-X-1', 4, 6),
    (5, 4, 'principal', 6, 1, 5, '3-1-X-1', 3, 7),
    (5, 4, 'principal', 7, 2, 5, '3-1-X-1', 2, 8),
    (5, 4, 'principal', 8, 1, 4, '3-1-X-1', 2, 8),
    (5, 10, 'secundario', 9, 1, 7, '2-1-X-1', 4, 6),
    (5, 10, 'secundario', 10, 1, 7, '2-1-X-1', 3, 7),
    (5, 10, 'secundario', 11, 2, 7, '2-1-X-1', 2, 8),
    (5, 11, 'secundario', 12, 1, 7, '2-1-X-1', 4, 6),
    (5, 11, 'secundario', 13, 1, 7, '2-1-X-1', 3, 7),
    (5, 11, 'secundario', 14, 2, 7, '2-1-X-1', 2, 8),
    (5, 12, 'secundario', 15, 1, 7, '2-1-X-1', 4, 6),
    (5, 12, 'secundario', 16, 1, 7, '2-1-X-1', 3, 7),
    (5, 12, 'secundario', 17, 2, 7, '2-1-X-1', 2, 8);

-- ---------- SEMANA 3 (dia_id=8) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (8, 3, 'principal', 1, 1, 4, '2-1-X-1', 4, 6),
    (8, 3, 'principal', 2, 1, 4, '2-1-X-1', 3, 7),
    (8, 3, 'principal', 3, 3, 4, '2-1-X-1', 2, 8),
    (8, 4, 'principal', 4, 1, 4, '2-1-X-1', 4, 6),
    (8, 4, 'principal', 5, 1, 4, '2-1-X-1', 3, 7),
    (8, 4, 'principal', 6, 3, 4, '2-1-X-1', 2, 8),
    (8, 10, 'secundario', 7, 1, 6, '2-1-X-1', 4, 6),
    (8, 10, 'secundario', 8, 1, 6, '2-1-X-1', 3, 7),
    (8, 10, 'secundario', 9, 2, 6, '2-1-X-1', 2, 8),
    (8, 11, 'secundario', 10, 1, 6, '2-1-X-1', 4, 6),
    (8, 11, 'secundario', 11, 1, 6, '2-1-X-1', 3, 7),
    (8, 11, 'secundario', 12, 2, 6, '2-1-X-1', 2, 8),
    (8, 12, 'secundario', 13, 1, 6, '2-1-X-1', 4, 6),
    (8, 12, 'secundario', 14, 1, 6, '2-1-X-1', 3, 7),
    (8, 12, 'secundario', 15, 2, 6, '2-1-X-1', 2, 8);

-- ---------- SEMANA 4 (dia_id=11) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (11, 3, 'principal', 1, 1, 4, '2-1-X-1', 4, 6),
    (11, 3, 'principal', 2, 1, 4, '2-1-X-1', 3, 7),
    (11, 3, 'principal', 3, 2, 4, '2-1-X-1', 2, 8),
    (11, 3, 'principal', 4, 1, 3, '2-1-X-1', 2, 8),
    (11, 4, 'principal', 5, 1, 4, '2-1-X-1', 4, 6),
    (11, 4, 'principal', 6, 1, 4, '2-1-X-1', 3, 7),
    (11, 4, 'principal', 7, 2, 4, '2-1-X-1', 2, 8),
    (11, 4, 'principal', 8, 1, 3, '2-1-X-1', 2, 8),
    (11, 10, 'secundario', 9, 1, 5, '2-1-X-1', 4, 6),
    (11, 10, 'secundario', 10, 1, 5, '2-1-X-1', 3, 7),
    (11, 10, 'secundario', 11, 2, 5, '2-1-X-1', 2, 8),
    (11, 11, 'secundario', 12, 1, 5, '2-1-X-1', 4, 6),
    (11, 11, 'secundario', 13, 1, 5, '2-1-X-1', 3, 7),
    (11, 11, 'secundario', 14, 2, 5, '2-1-X-1', 2, 8),
    (11, 12, 'secundario', 15, 1, 5, '2-1-X-1', 4, 6),
    (11, 12, 'secundario', 16, 1, 5, '2-1-X-1', 3, 7),
    (11, 12, 'secundario', 17, 2, 5, '2-1-X-1', 2, 8);

-- ---------- SEMANA 5 (dia_id=14) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (14, 3, 'principal', 1, 1, 3, '2-0-X-1', 4, 6),
    (14, 3, 'principal', 2, 1, 3, '2-0-X-1', 3, 7),
    (14, 3, 'principal', 3, 3, 3, '2-0-X-1', 2, 8),
    (14, 4, 'principal', 4, 1, 3, '2-0-X-1', 4, 6),
    (14, 4, 'principal', 5, 1, 3, '2-0-X-1', 3, 7),
    (14, 4, 'principal', 6, 3, 3, '2-0-X-1', 2, 8),
    (14, 10, 'secundario', 7, 1, 4, '2-1-X-1', 4, 6),
    (14, 10, 'secundario', 8, 1, 4, '2-1-X-1', 3, 7),
    (14, 10, 'secundario', 9, 2, 4, '2-1-X-1', 2, 8),
    (14, 11, 'secundario', 10, 1, 4, '2-1-X-1', 4, 6),
    (14, 11, 'secundario', 11, 1, 4, '2-1-X-1', 3, 7),
    (14, 11, 'secundario', 12, 2, 4, '2-1-X-1', 2, 8),
    (14, 12, 'secundario', 13, 1, 4, '2-1-X-1', 4, 6),
    (14, 12, 'secundario', 14, 1, 4, '2-1-X-1', 3, 7),
    (14, 12, 'secundario', 15, 2, 4, '2-1-X-1', 2, 8);

-- ---------- SEMANA 6 (dia_id=17) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (17, 3, 'principal', 1, 1, 3, '2-0-X-1', 4, 6),
    (17, 3, 'principal', 2, 1, 3, '2-0-X-1', 3, 7),
    (17, 3, 'principal', 3, 2, 3, '2-0-X-1', 2, 8),
    (17, 3, 'principal', 4, 1, 2, '2-0-X-1', 2, 8),
    (17, 4, 'principal', 5, 1, 3, '2-0-X-1', 4, 6),
    (17, 4, 'principal', 6, 1, 3, '2-0-X-1', 3, 7),
    (17, 4, 'principal', 7, 2, 3, '2-0-X-1', 2, 8),
    (17, 4, 'principal', 8, 1, 2, '2-0-X-1', 2, 8),
    (17, 10, 'secundario', 9, 1, 3, '2-1-X-1', 4, 6),
    (17, 10, 'secundario', 10, 1, 3, '2-1-X-1', 3, 7),
    (17, 10, 'secundario', 11, 2, 3, '2-1-X-1', 2, 8),
    (17, 11, 'secundario', 12, 1, 3, '2-1-X-1', 4, 6),
    (17, 11, 'secundario', 13, 1, 3, '2-1-X-1', 3, 7),
    (17, 11, 'secundario', 14, 2, 3, '2-1-X-1', 2, 8),
    (17, 12, 'secundario', 15, 1, 3, '2-1-X-1', 4, 6),
    (17, 12, 'secundario', 16, 1, 3, '2-1-X-1', 3, 7),
    (17, 12, 'secundario', 17, 2, 3, '2-1-X-1', 2, 8);

-- ---------- SEMANA 7 (dia_id=20) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (20, 3, 'principal', 1, 1, 2, '1-0-X-1', 4, 6),
    (20, 3, 'principal', 2, 1, 2, '1-0-X-1', 3, 7),
    (20, 3, 'principal', 3, 3, 2, '1-0-X-1', 2, 8),
    (20, 4, 'principal', 4, 1, 2, '1-0-X-1', 4, 6),
    (20, 4, 'principal', 5, 1, 2, '1-0-X-1', 3, 7),
    (20, 4, 'principal', 6, 3, 2, '1-0-X-1', 2, 8),
    (20, 10, 'secundario', 7, 1, 2, '2-1-X-1', 4, 6),
    (20, 10, 'secundario', 8, 1, 2, '2-1-X-1', 3, 7),
    (20, 10, 'secundario', 9, 2, 2, '2-1-X-1', 2, 8),
    (20, 11, 'secundario', 10, 1, 2, '2-1-X-1', 4, 6),
    (20, 11, 'secundario', 11, 1, 2, '2-1-X-1', 3, 7),
    (20, 11, 'secundario', 12, 2, 2, '2-1-X-1', 2, 8),
    (20, 12, 'secundario', 13, 1, 2, '2-1-X-1', 4, 6),
    (20, 12, 'secundario', 14, 1, 2, '2-1-X-1', 3, 7),
    (20, 12, 'secundario', 15, 2, 2, '2-1-X-1', 2, 8);

-- ---------- SEMANA 8 (dia_id=23) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (23, 3, 'principal', 1, 1, 1, '1-0-X-1', 4, 6),
    (23, 3, 'principal', 2, 1, 1, '1-0-X-1', 3, 7),
    (23, 3, 'principal', 3, 3, 1, '1-0-X-1', 2, 8),
    (23, 4, 'principal', 4, 1, 1, '1-0-X-1', 4, 6),
    (23, 4, 'principal', 5, 1, 1, '1-0-X-1', 3, 7),
    (23, 4, 'principal', 6, 3, 1, '1-0-X-1', 2, 8),
    (23, 10, 'secundario', 7, 1, 1, '2-1-X-1', 4, 6),
    (23, 10, 'secundario', 8, 1, 1, '2-1-X-1', 3, 7),
    (23, 10, 'secundario', 9, 2, 1, '2-1-X-1', 2, 8),
    (23, 11, 'secundario', 10, 1, 1, '2-1-X-1', 4, 6),
    (23, 11, 'secundario', 11, 1, 1, '2-1-X-1', 3, 7),
    (23, 11, 'secundario', 12, 2, 1, '2-1-X-1', 2, 8),
    (23, 12, 'secundario', 13, 1, 1, '2-1-X-1', 4, 6),
    (23, 12, 'secundario', 14, 1, 1, '2-1-X-1', 3, 7),
    (23, 12, 'secundario', 15, 2, 1, '2-1-X-1', 2, 8);

-- =====================================================
-- SERIES - FUERZA AVANZADO 2 - DÍA 3 - SEMANAS 2-8
-- =====================================================

-- ---------- SEMANA 2 (dia_id=6) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (6, 5, 'principal', 1, 1, 5, '3-1-X-1', 4, 6),
    (6, 5, 'principal', 2, 1, 5, '3-1-X-1', 3, 7),
    (6, 5, 'principal', 3, 2, 5, '3-1-X-1', 2, 8),
    (6, 5, 'principal', 4, 1, 4, '3-1-X-1', 2, 8),
    (6, 6, 'principal', 5, 1, 5, '3-1-X-1', 4, 6),
    (6, 6, 'principal', 6, 1, 5, '3-1-X-1', 3, 7),
    (6, 6, 'principal', 7, 2, 5, '3-1-X-1', 2, 8),
    (6, 6, 'principal', 8, 1, 4, '3-1-X-1', 2, 8),
    (6, 13, 'secundario', 9, 1, 7, '2-1-X-1', 4, 6),
    (6, 13, 'secundario', 10, 1, 7, '2-1-X-1', 3, 7),
    (6, 13, 'secundario', 11, 2, 7, '2-1-X-1', 2, 8),
    (6, 14, 'secundario', 12, 1, 7, '2-1-X-1', 4, 6),
    (6, 14, 'secundario', 13, 1, 7, '2-1-X-1', 3, 7),
    (6, 14, 'secundario', 14, 2, 7, '2-1-X-1', 2, 8),
    (6, 15, 'secundario', 15, 1, 7, '2-1-X-1', 4, 6),
    (6, 15, 'secundario', 16, 1, 7, '2-1-X-1', 3, 7),
    (6, 15, 'secundario', 17, 2, 7, '2-1-X-1', 2, 8);

-- ---------- SEMANA 3 (dia_id=9) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (9, 5, 'principal', 1, 1, 4, '2-1-X-1', 4, 6),
    (9, 5, 'principal', 2, 1, 4, '2-1-X-1', 3, 7),
    (9, 5, 'principal', 3, 3, 4, '2-1-X-1', 2, 8),
    (9, 6, 'principal', 4, 1, 4, '2-1-X-1', 4, 6),
    (9, 6, 'principal', 5, 1, 4, '2-1-X-1', 3, 7),
    (9, 6, 'principal', 6, 3, 4, '2-1-X-1', 2, 8),
    (9, 13, 'secundario', 7, 1, 6, '2-1-X-1', 4, 6),
    (9, 13, 'secundario', 8, 1, 6, '2-1-X-1', 3, 7),
    (9, 13, 'secundario', 9, 2, 6, '2-1-X-1', 2, 8),
    (9, 14, 'secundario', 10, 1, 6, '2-1-X-1', 4, 6),
    (9, 14, 'secundario', 11, 1, 6, '2-1-X-1', 3, 7),
    (9, 14, 'secundario', 12, 2, 6, '2-1-X-1', 2, 8),
    (9, 15, 'secundario', 13, 1, 6, '2-1-X-1', 4, 6),
    (9, 15, 'secundario', 14, 1, 6, '2-1-X-1', 3, 7),
    (9, 15, 'secundario', 15, 2, 6, '2-1-X-1', 2, 8);

-- ---------- SEMANA 4 (dia_id=12) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (12, 5, 'principal', 1, 1, 4, '2-1-X-1', 4, 6),
    (12, 5, 'principal', 2, 1, 4, '2-1-X-1', 3, 7),
    (12, 5, 'principal', 3, 2, 4, '2-1-X-1', 2, 8),
    (12, 5, 'principal', 4, 1, 3, '2-1-X-1', 2, 8),
    (12, 6, 'principal', 5, 1, 4, '2-1-X-1', 4, 6),
    (12, 6, 'principal', 6, 1, 4, '2-1-X-1', 3, 7),
    (12, 6, 'principal', 7, 2, 4, '2-1-X-1', 2, 8),
    (12, 6, 'principal', 8, 1, 3, '2-1-X-1', 2, 8),
    (12, 13, 'secundario', 9, 1, 5, '2-1-X-1', 4, 6),
    (12, 13, 'secundario', 10, 1, 5, '2-1-X-1', 3, 7),
    (12, 13, 'secundario', 11, 2, 5, '2-1-X-1', 2, 8),
    (12, 14, 'secundario', 12, 1, 5, '2-1-X-1', 4, 6),
    (12, 14, 'secundario', 13, 1, 5, '2-1-X-1', 3, 7),
    (12, 14, 'secundario', 14, 2, 5, '2-1-X-1', 2, 8),
    (12, 15, 'secundario', 15, 1, 5, '2-1-X-1', 4, 6),
    (12, 15, 'secundario', 16, 1, 5, '2-1-X-1', 3, 7),
    (12, 15, 'secundario', 17, 2, 5, '2-1-X-1', 2, 8);

-- ---------- SEMANA 5 (dia_id=15) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (15, 5, 'principal', 1, 1, 3, '2-0-X-1', 4, 6),
    (15, 5, 'principal', 2, 1, 3, '2-0-X-1', 3, 7),
    (15, 5, 'principal', 3, 3, 3, '2-0-X-1', 2, 8),
    (15, 6, 'principal', 4, 1, 3, '2-0-X-1', 4, 6),
    (15, 6, 'principal', 5, 1, 3, '2-0-X-1', 3, 7),
    (15, 6, 'principal', 6, 3, 3, '2-0-X-1', 2, 8),
    (15, 13, 'secundario', 7, 1, 4, '2-1-X-1', 4, 6),
    (15, 13, 'secundario', 8, 1, 4, '2-1-X-1', 3, 7),
    (15, 13, 'secundario', 9, 2, 4, '2-1-X-1', 2, 8),
    (15, 14, 'secundario', 10, 1, 4, '2-1-X-1', 4, 6),
    (15, 14, 'secundario', 11, 1, 4, '2-1-X-1', 3, 7),
    (15, 14, 'secundario', 12, 2, 4, '2-1-X-1', 2, 8),
    (15, 15, 'secundario', 13, 1, 4, '2-1-X-1', 4, 6),
    (15, 15, 'secundario', 14, 1, 4, '2-1-X-1', 3, 7),
    (15, 15, 'secundario', 15, 2, 4, '2-1-X-1', 2, 8);

-- ---------- SEMANA 6 (dia_id=18) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (18, 5, 'principal', 1, 1, 3, '2-0-X-1', 4, 6),
    (18, 5, 'principal', 2, 1, 3, '2-0-X-1', 3, 7),
    (18, 5, 'principal', 3, 2, 3, '2-0-X-1', 2, 8),
    (18, 5, 'principal', 4, 1, 2, '2-0-X-1', 2, 8),
    (18, 6, 'principal', 5, 1, 3, '2-0-X-1', 4, 6),
    (18, 6, 'principal', 6, 1, 3, '2-0-X-1', 3, 7),
    (18, 6, 'principal', 7, 2, 3, '2-0-X-1', 2, 8),
    (18, 6, 'principal', 8, 1, 2, '2-0-X-1', 2, 8),
    (18, 13, 'secundario', 9, 1, 3, '2-1-X-1', 4, 6),
    (18, 13, 'secundario', 10, 1, 3, '2-1-X-1', 3, 7),
    (18, 13, 'secundario', 11, 2, 3, '2-1-X-1', 2, 8),
    (18, 14, 'secundario', 12, 1, 3, '2-1-X-1', 4, 6),
    (18, 14, 'secundario', 13, 1, 3, '2-1-X-1', 3, 7),
    (18, 14, 'secundario', 14, 2, 3, '2-1-X-1', 2, 8),
    (18, 15, 'secundario', 15, 1, 3, '2-1-X-1', 4, 6),
    (18, 15, 'secundario', 16, 1, 3, '2-1-X-1', 3, 7),
    (18, 15, 'secundario', 17, 2, 3, '2-1-X-1', 2, 8);

-- ---------- SEMANA 7 (dia_id=21) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (21, 5, 'principal', 1, 1, 2, '2-0-X-1', 4, 6),
    (21, 5, 'principal', 2, 1, 2, '2-0-X-1', 3, 7),
    (21, 5, 'principal', 3, 3, 2, '2-0-X-1', 2, 8),
    (21, 6, 'principal', 4, 1, 2, '1-0-X-1', 4, 6),
    (21, 6, 'principal', 5, 1, 2, '1-0-X-1', 3, 7),
    (21, 6, 'principal', 6, 3, 2, '1-0-X-1', 2, 8),
    (21, 13, 'secundario', 7, 1, 2, '2-1-X-1', 4, 6),
    (21, 13, 'secundario', 8, 1, 2, '2-1-X-1', 3, 7),
    (21, 13, 'secundario', 9, 2, 2, '2-1-X-1', 2, 8),
    (21, 14, 'secundario', 10, 1, 2, '2-1-X-1', 4, 6),
    (21, 14, 'secundario', 11, 1, 2, '2-1-X-1', 3, 7),
    (21, 14, 'secundario', 12, 2, 2, '2-1-X-1', 2, 8),
    (21, 15, 'secundario', 13, 1, 2, '2-1-X-1', 4, 6),
    (21, 15, 'secundario', 14, 1, 2, '2-1-X-1', 3, 7),
    (21, 15, 'secundario', 15, 2, 2, '2-1-X-1', 2, 8);

-- ---------- SEMANA 8 (dia_id=24) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (24, 5, 'principal', 1, 1, 1, '2-0-X-1', 4, 6),
    (24, 5, 'principal', 2, 1, 1, '2-0-X-1', 3, 7),
    (24, 5, 'principal', 3, 3, 1, '2-0-X-1', 2, 8),
    (24, 6, 'principal', 4, 1, 1, '1-0-X-1', 4, 6),
    (24, 6, 'principal', 5, 1, 1, '1-0-X-1', 3, 7),
    (24, 6, 'principal', 6, 3, 1, '1-0-X-1', 2, 8),
    (24, 13, 'secundario', 7, 1, 1, '2-1-X-1', 4, 6),
    (24, 13, 'secundario', 8, 1, 1, '2-1-X-1', 3, 7),
    (24, 13, 'secundario', 9, 2, 1, '2-1-X-1', 2, 8),
    (24, 14, 'secundario', 10, 1, 1, '2-1-X-1', 4, 6),
    (24, 14, 'secundario', 11, 1, 1, '2-1-X-1', 3, 7),
    (24, 14, 'secundario', 12, 2, 1, '2-1-X-1', 2, 8),
    (24, 15, 'secundario', 13, 1, 1, '2-1-X-1', 4, 6),
    (24, 15, 'secundario', 14, 1, 1, '2-1-X-1', 3, 7),
    (24, 15, 'secundario', 15, 2, 1, '2-1-X-1', 2, 8);

-- =====================================================
-- SERIES - FUERZA AVANZADO 3 HIPERTROFIA - DÍA 1 - SEMANAS 2-8
-- =====================================================

-- ---------- SEMANA 2 (dia_id=27) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (27, 1, 'principal', 1, 1, 12, '2-0-X-1', 3, 7),
    (27, 1, 'principal', 2, 2, 12, '2-0-X-1', 2, 8),
    (27, 1, 'principal', 3, 2, 12, '2-0-X-1', 1, 9),
    (27, 4, 'principal', 4, 1, 12, '2-0-X-1', 3, 7),
    (27, 4, 'principal', 5, 2, 12, '2-0-X-1', 2, 8),
    (27, 4, 'principal', 6, 2, 12, '2-0-X-1', 1, 9),
    (27, 16, 'secundario', 7, 1, 12, '2-1-X-2', 3, 7),
    (27, 16, 'secundario', 8, 2, 12, '2-1-X-2', 2, 8),
    (27, 16, 'secundario', 9, 2, 12, '2-1-X-2', 1, 9),
    (27, 10, 'secundario', 10, 1, 12, '2-1-X-1', 3, 7),
    (27, 10, 'secundario', 11, 2, 12, '2-1-X-1', 2, 8),
    (27, 10, 'secundario', 12, 2, 12, '2-1-X-1', 1, 9),
    (27, 17, 'secundario', 13, 1, 12, '2-1-X-2', 3, 7),
    (27, 17, 'secundario', 14, 2, 12, '2-1-X-2', 2, 8),
    (27, 17, 'secundario', 15, 2, 12, '2-1-X-2', 1, 9),
    (27, 22, 'core', 16, 4, 20, NULL, NULL, NULL),
    (27, 23, 'core', 17, 3, 20, NULL, NULL, NULL);

-- ---------- SEMANA 3 (dia_id=29) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (29, 1, 'principal', 1, 1, 10, '2-0-X-1', 3, 7),
    (29, 1, 'principal', 2, 1, 10, '2-0-X-1', 2, 8),
    (29, 1, 'principal', 3, 3, 10, '2-0-X-1', 1, 9),
    (29, 4, 'principal', 4, 1, 10, '2-0-X-1', 3, 7),
    (29, 4, 'principal', 5, 1, 10, '2-0-X-1', 2, 8),
    (29, 4, 'principal', 6, 3, 10, '2-0-X-1', 1, 9),
    (29, 16, 'secundario', 7, 1, 10, '2-2-X-2', 3, 7),
    (29, 16, 'secundario', 8, 1, 10, '2-2-X-2', 2, 8),
    (29, 16, 'secundario', 9, 3, 10, '2-2-X-2', 1, 9),
    (29, 10, 'secundario', 10, 1, 10, '2-1-X-1', 3, 7),
    (29, 10, 'secundario', 11, 1, 10, '2-1-X-1', 2, 8),
    (29, 10, 'secundario', 12, 3, 10, '2-1-X-1', 1, 9),
    (29, 17, 'secundario', 13, 1, 10, '2-1-X-2', 3, 7),
    (29, 17, 'secundario', 14, 1, 10, '2-1-X-2', 2, 8),
    (29, 17, 'secundario', 15, 3, 10, '2-1-X-2', 1, 9),
    (29, 22, 'core', 16, 4, 25, NULL, NULL, NULL),
    (29, 23, 'core', 17, 3, 20, NULL, NULL, NULL);

-- ---------- SEMANA 4 (dia_id=31) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (31, 1, 'principal', 1, 1, 9, '2-0-X-1', 3, 7),
    (31, 1, 'principal', 2, 1, 9, '2-0-X-1', 2, 8),
    (31, 1, 'principal', 3, 3, 9, '2-0-X-1', 1, 9),
    (31, 4, 'principal', 4, 1, 9, '2-0-X-1', 3, 7),
    (31, 4, 'principal', 5, 1, 9, '2-0-X-1', 2, 8),
    (31, 4, 'principal', 6, 3, 9, '2-0-X-1', 1, 9),
    (31, 16, 'secundario', 7, 1, 9, '2-2-X-2', 3, 7),
    (31, 16, 'secundario', 8, 1, 9, '2-2-X-2', 2, 8),
    (31, 16, 'secundario', 9, 3, 9, '2-2-X-2', 1, 9),
    (31, 10, 'secundario', 10, 1, 9, '2-1-X-1', 3, 7),
    (31, 10, 'secundario', 11, 1, 9, '2-1-X-1', 2, 8),
    (31, 10, 'secundario', 12, 3, 9, '2-1-X-1', 1, 9),
    (31, 17, 'secundario', 13, 1, 9, '2-1-X-2', 3, 7),
    (31, 17, 'secundario', 14, 1, 9, '2-1-X-2', 2, 8),
    (31, 17, 'secundario', 15, 3, 9, '2-1-X-2', 1, 9),
    (31, 22, 'core', 16, 4, 25, NULL, NULL, NULL),
    (31, 23, 'core', 17, 3, 20, NULL, NULL, NULL);

-- ---------- SEMANA 5 (dia_id=33) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (33, 1, 'principal', 1, 1, 8, '2-0-X-1', 3, 7),
    (33, 1, 'principal', 2, 2, 8, '2-0-X-1', 2, 8),
    (33, 1, 'principal', 3, 2, 8, '2-0-X-1', 1, 9),
    (33, 4, 'principal', 4, 1, 8, '2-0-X-1', 3, 7),
    (33, 4, 'principal', 5, 2, 8, '2-0-X-1', 2, 8),
    (33, 4, 'principal', 6, 2, 8, '2-0-X-1', 1, 9),
    (33, 16, 'secundario', 7, 1, 8, '2-1-X-2', 3, 7),
    (33, 16, 'secundario', 8, 2, 8, '2-1-X-2', 2, 8),
    (33, 16, 'secundario', 9, 2, 8, '2-1-X-2', 1, 9),
    (33, 10, 'secundario', 10, 1, 8, '2-1-X-1', 3, 7),
    (33, 10, 'secundario', 11, 2, 8, '2-1-X-1', 2, 8),
    (33, 10, 'secundario', 12, 2, 8, '2-1-X-1', 1, 9),
    (33, 17, 'secundario', 13, 1, 8, '2-1-X-2', 3, 7),
    (33, 17, 'secundario', 14, 2, 8, '2-1-X-2', 2, 8),
    (33, 17, 'secundario', 15, 2, 8, '2-1-X-2', 1, 9),
    (33, 22, 'core', 16, 4, 30, NULL, NULL, NULL),
    (33, 23, 'core', 17, 3, 25, NULL, NULL, NULL);

-- ---------- SEMANA 6 (dia_id=35) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (35, 1, 'principal', 1, 1, 8, '2-0-X-1', 3, 7),
    (35, 1, 'principal', 2, 1, 8, '2-0-X-1', 2, 8),
    (35, 1, 'principal', 3, 3, 8, '2-0-X-1', 1, 9),
    (35, 4, 'principal', 4, 1, 8, '2-0-X-1', 3, 7),
    (35, 4, 'principal', 5, 1, 8, '2-0-X-1', 2, 8),
    (35, 4, 'principal', 6, 3, 8, '2-0-X-1', 1, 9),
    (35, 16, 'secundario', 7, 1, 8, '2-1-X-2', 3, 7),
    (35, 16, 'secundario', 8, 1, 8, '2-1-X-2', 2, 8),
    (35, 16, 'secundario', 9, 3, 8, '2-1-X-2', 1, 9),
    (35, 10, 'secundario', 10, 1, 8, '2-1-X-1', 3, 7),
    (35, 10, 'secundario', 11, 1, 8, '2-1-X-1', 2, 8),
    (35, 10, 'secundario', 12, 3, 8, '2-1-X-1', 1, 9),
    (35, 17, 'secundario', 13, 1, 8, '2-1-X-2', 3, 7),
    (35, 17, 'secundario', 14, 1, 8, '2-1-X-2', 2, 8),
    (35, 17, 'secundario', 15, 3, 8, '2-1-X-2', 1, 9),
    (35, 22, 'core', 16, 4, 30, NULL, NULL, NULL),
    (35, 23, 'core', 17, 3, 25, NULL, NULL, NULL);

-- ---------- SEMANA 7 (dia_id=37) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (37, 1, 'principal', 1, 1, 7, '2-0-X-1', 3, 7),
    (37, 1, 'principal', 2, 2, 7, '2-0-X-1', 2, 8),
    (37, 1, 'principal', 3, 2, 7, '2-0-X-1', 1, 9),
    (37, 4, 'principal', 4, 1, 7, '2-0-X-1', 3, 7),
    (37, 4, 'principal', 5, 2, 7, '2-0-X-1', 2, 8),
    (37, 4, 'principal', 6, 2, 7, '2-0-X-1', 1, 9),
    (37, 16, 'secundario', 7, 1, 7, '2-1-X-2', 3, 7),
    (37, 16, 'secundario', 8, 2, 7, '2-1-X-2', 2, 8),
    (37, 16, 'secundario', 9, 2, 7, '2-1-X-2', 1, 9),
    (37, 10, 'secundario', 10, 1, 7, '2-1-X-1', 3, 7),
    (37, 10, 'secundario', 11, 2, 7, '2-1-X-1', 2, 8),
    (37, 10, 'secundario', 12, 2, 7, '2-1-X-1', 1, 9),
    (37, 17, 'secundario', 13, 1, 7, '2-1-X-2', 3, 7),
    (37, 17, 'secundario', 14, 2, 7, '2-1-X-2', 2, 8),
    (37, 17, 'secundario', 15, 2, 7, '2-1-X-2', 1, 9),
    (37, 22, 'core', 16, 4, 35, NULL, NULL, NULL),
    (37, 23, 'core', 17, 3, 30, NULL, NULL, NULL);

-- ---------- SEMANA 8 (dia_id=39) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (39, 1, 'principal', 1, 1, 7, '2-0-X-1', 3, 7),
    (39, 1, 'principal', 2, 1, 7, '2-0-X-1', 2, 8),
    (39, 1, 'principal', 3, 3, 7, '2-0-X-1', 1, 9),
    (39, 4, 'principal', 4, 1, 7, '2-0-X-1', 3, 7),
    (39, 4, 'principal', 5, 1, 7, '2-0-X-1', 2, 8),
    (39, 4, 'principal', 6, 3, 7, '2-0-X-1', 1, 9),
    (39, 16, 'secundario', 7, 1, 7, '2-1-X-2', 3, 7),
    (39, 16, 'secundario', 8, 1, 7, '2-1-X-2', 2, 8),
    (39, 16, 'secundario', 9, 3, 7, '2-1-X-2', 1, 9),
    (39, 10, 'secundario', 10, 1, 7, '2-1-X-1', 3, 7),
    (39, 10, 'secundario', 11, 1, 7, '2-1-X-1', 2, 8),
    (39, 10, 'secundario', 12, 3, 7, '2-1-X-1', 1, 9),
    (39, 17, 'secundario', 13, 1, 7, '2-1-X-2', 3, 7),
    (39, 17, 'secundario', 14, 1, 7, '2-1-X-2', 2, 8),
    (39, 17, 'secundario', 15, 3, 7, '2-1-X-2', 1, 9),
    (39, 22, 'core', 16, 4, 35, NULL, NULL, NULL),
    (39, 23, 'core', 17, 3, 30, NULL, NULL, NULL);

-- =====================================================
-- SERIES - FUERZA AVANZADO 3 HIPERTROFIA - DÍA 2 - SEMANAS 1-8
-- =====================================================

-- ---------- SEMANA 1 (dia_id=26) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (26, 2, 'principal', 1, 1, 14, '2-1-X-1', 3, 7),
    (26, 2, 'principal', 2, 2, 14, '2-1-X-1', 2, 8),
    (26, 2, 'principal', 3, 1, 14, '2-1-X-1', 1, 9),
    (26, 21, 'principal', 4, 1, 14, '2-1-X-1', 3, 7),
    (26, 21, 'principal', 5, 2, 14, '2-1-X-1', 2, 8),
    (26, 21, 'principal', 6, 1, 14, '2-1-X-1', 1, 9),
    (26, 19, 'secundario', 7, 1, 14, '2-1-X-1', 3, 7),
    (26, 19, 'secundario', 8, 2, 14, '2-1-X-1', 2, 8),
    (26, 19, 'secundario', 9, 1, 14, '2-1-X-1', 1, 9),
    (26, 18, 'secundario', 10, 1, 14, '2-1-X-1', 3, 7),
    (26, 18, 'secundario', 11, 2, 14, '2-1-X-1', 2, 8),
    (26, 18, 'secundario', 12, 1, 14, '2-1-X-1', 1, 9),
    (26, 20, 'secundario', 13, 1, 20, '3-1-X-2', 4, 6),
    (26, 20, 'secundario', 14, 2, 20, '3-1-X-2', 3, 7),
    (26, 20, 'secundario', 15, 1, 20, '3-1-X-2', 2, 8),
    (26, 24, 'core', 16, 4, 20, NULL, NULL, NULL),
    (26, 25, 'core', 17, 4, 20, NULL, NULL, NULL);

-- ---------- SEMANA 2 (dia_id=28) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (28, 2, 'principal', 1, 1, 12, '2-1-X-1', 3, 7),
    (28, 2, 'principal', 2, 2, 12, '2-1-X-1', 2, 8),
    (28, 2, 'principal', 3, 2, 12, '2-1-X-1', 1, 9),
    (28, 21, 'principal', 4, 1, 12, '2-1-X-1', 3, 7),
    (28, 21, 'principal', 5, 2, 12, '2-1-X-1', 2, 8),
    (28, 21, 'principal', 6, 2, 12, '2-1-X-1', 1, 9),
    (28, 19, 'secundario', 7, 1, 12, '2-1-X-1', 3, 7),
    (28, 19, 'secundario', 8, 2, 12, '2-1-X-1', 2, 8),
    (28, 19, 'secundario', 9, 2, 12, '2-1-X-1', 1, 9),
    (28, 18, 'secundario', 10, 1, 12, '2-1-X-1', 3, 7),
    (28, 18, 'secundario', 11, 2, 12, '2-1-X-1', 2, 8),
    (28, 18, 'secundario', 12, 2, 12, '2-1-X-1', 1, 9),
    (28, 20, 'secundario', 13, 1, 20, '3-1-X-2', 4, 6),
    (28, 20, 'secundario', 14, 2, 20, '3-1-X-2', 3, 7),
    (28, 20, 'secundario', 15, 2, 20, '3-1-X-2', 2, 8),
    (28, 24, 'core', 16, 4, 20, NULL, NULL, NULL),
    (28, 25, 'core', 17, 4, 20, NULL, NULL, NULL);

-- ---------- SEMANA 3 (dia_id=30) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (30, 2, 'principal', 1, 1, 10, '2-1-X-1', 3, 7),
    (30, 2, 'principal', 2, 1, 10, '2-1-X-1', 2, 8),
    (30, 2, 'principal', 3, 3, 10, '2-1-X-1', 1, 9),
    (30, 21, 'principal', 4, 1, 10, '2-1-X-1', 3, 7),
    (30, 21, 'principal', 5, 1, 10, '2-1-X-1', 2, 8),
    (30, 21, 'principal', 6, 3, 10, '2-1-X-1', 1, 9),
    (30, 19, 'secundario', 7, 1, 10, '2-1-X-1', 3, 7),
    (30, 19, 'secundario', 8, 1, 10, '2-1-X-1', 2, 8),
    (30, 19, 'secundario', 9, 3, 10, '2-1-X-1', 1, 9),
    (30, 18, 'secundario', 10, 1, 10, '2-1-X-1', 3, 7),
    (30, 18, 'secundario', 11, 1, 10, '2-1-X-1', 2, 8),
    (30, 18, 'secundario', 12, 3, 10, '2-1-X-1', 1, 9),
    (30, 20, 'secundario', 13, 1, 20, '3-1-X-2', 4, 6),
    (30, 20, 'secundario', 14, 1, 20, '3-1-X-2', 3, 7),
    (30, 20, 'secundario', 15, 3, 20, '3-1-X-2', 2, 8),
    (30, 24, 'core', 16, 4, 20, NULL, NULL, NULL),
    (30, 25, 'core', 17, 4, 20, NULL, NULL, NULL);

-- ---------- SEMANA 4 (dia_id=32) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (32, 2, 'principal', 1, 1, 9, '2-1-X-1', 3, 7),
    (32, 2, 'principal', 2, 1, 9, '2-1-X-1', 2, 8),
    (32, 2, 'principal', 3, 3, 9, '2-1-X-1', 1, 9),
    (32, 21, 'principal', 4, 1, 9, '2-1-X-1', 3, 7),
    (32, 21, 'principal', 5, 1, 9, '2-1-X-1', 2, 8),
    (32, 21, 'principal', 6, 3, 9, '2-1-X-1', 1, 9),
    (32, 19, 'secundario', 7, 1, 9, '2-1-X-1', 3, 7),
    (32, 19, 'secundario', 8, 1, 9, '2-1-X-1', 2, 8),
    (32, 19, 'secundario', 9, 3, 9, '2-1-X-1', 1, 9),
    (32, 18, 'secundario', 10, 1, 9, '2-1-X-1', 3, 7),
    (32, 18, 'secundario', 11, 1, 9, '2-1-X-1', 2, 8),
    (32, 18, 'secundario', 12, 3, 9, '2-1-X-1', 1, 9),
    (32, 20, 'secundario', 13, 1, 18, '3-1-X-2', 4, 6),
    (32, 20, 'secundario', 14, 1, 18, '3-1-X-2', 3, 7),
    (32, 20, 'secundario', 15, 3, 18, '3-1-X-2', 2, 8),
    (32, 24, 'core', 16, 4, 20, NULL, NULL, NULL),
    (32, 25, 'core', 17, 4, 20, NULL, NULL, NULL);

-- ---------- SEMANA 5 (dia_id=34) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (34, 2, 'principal', 1, 1, 8, '2-0-X-1', 3, 7),
    (34, 2, 'principal', 2, 2, 8, '2-0-X-1', 2, 8),
    (34, 2, 'principal', 3, 2, 8, '2-0-X-1', 1, 9),
    (34, 21, 'principal', 4, 1, 8, '2-1-X-1', 3, 7),
    (34, 21, 'principal', 5, 2, 8, '2-1-X-1', 2, 8),
    (34, 21, 'principal', 6, 2, 8, '2-1-X-1', 1, 9),
    (34, 19, 'secundario', 7, 1, 8, '2-0-X-1', 3, 7),
    (34, 19, 'secundario', 8, 2, 8, '2-0-X-1', 2, 8),
    (34, 19, 'secundario', 9, 2, 8, '2-0-X-1', 1, 9),
    (34, 18, 'secundario', 10, 1, 8, '2-1-X-1', 3, 7),
    (34, 18, 'secundario', 11, 2, 8, '2-1-X-1', 2, 8),
    (34, 18, 'secundario', 12, 2, 8, '2-1-X-1', 1, 9),
    (34, 20, 'secundario', 13, 1, 16, '3-1-X-2', 4, 6),
    (34, 20, 'secundario', 14, 2, 16, '3-1-X-2', 3, 7),
    (34, 20, 'secundario', 15, 2, 16, '3-1-X-2', 2, 8),
    (34, 24, 'core', 16, 4, 20, NULL, NULL, NULL),
    (34, 25, 'core', 17, 4, 20, NULL, NULL, NULL);

-- ---------- SEMANA 6 (dia_id=36) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (36, 2, 'principal', 1, 1, 8, '2-0-X-1', 3, 7),
    (36, 2, 'principal', 2, 1, 8, '2-0-X-1', 2, 8),
    (36, 2, 'principal', 3, 3, 8, '2-0-X-1', 1, 9),
    (36, 21, 'principal', 4, 1, 8, '2-1-X-1', 3, 7),
    (36, 21, 'principal', 5, 1, 8, '2-1-X-1', 2, 8),
    (36, 21, 'principal', 6, 3, 8, '2-1-X-1', 1, 9),
    (36, 19, 'secundario', 7, 1, 8, '2-0-X-1', 3, 7),
    (36, 19, 'secundario', 8, 1, 8, '2-0-X-1', 2, 8),
    (36, 19, 'secundario', 9, 3, 8, '2-0-X-1', 1, 9),
    (36, 18, 'secundario', 10, 1, 8, '2-1-X-1', 3, 7),
    (36, 18, 'secundario', 11, 1, 8, '2-1-X-1', 2, 8),
    (36, 18, 'secundario', 12, 3, 8, '2-1-X-1', 1, 9),
    (36, 20, 'secundario', 13, 1, 16, '3-1-X-2', 4, 6),
    (36, 20, 'secundario', 14, 1, 16, '3-1-X-2', 3, 7),
    (36, 20, 'secundario', 15, 3, 16, '3-1-X-2', 2, 8),
    (36, 24, 'core', 16, 4, 20, NULL, NULL, NULL),
    (36, 25, 'core', 17, 4, 20, NULL, NULL, NULL);

-- ---------- SEMANA 7 (dia_id=38) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (38, 2, 'principal', 1, 1, 7, '2-0-X-1', 3, 7),
    (38, 2, 'principal', 2, 2, 7, '2-0-X-1', 2, 8),
    (38, 2, 'principal', 3, 2, 7, '2-0-X-1', 1, 9),
    (38, 21, 'principal', 4, 1, 7, '2-1-X-1', 3, 7),
    (38, 21, 'principal', 5, 2, 7, '2-1-X-1', 2, 8),
    (38, 21, 'principal', 6, 2, 7, '2-1-X-1', 1, 9),
    (38, 19, 'secundario', 7, 1, 7, '2-0-X-1', 3, 7),
    (38, 19, 'secundario', 8, 2, 7, '2-0-X-1', 2, 8),
    (38, 19, 'secundario', 9, 2, 7, '2-0-X-1', 1, 9),
    (38, 18, 'secundario', 10, 1, 7, '2-1-X-1', 3, 7),
    (38, 18, 'secundario', 11, 2, 7, '2-1-X-1', 2, 8),
    (38, 18, 'secundario', 12, 2, 7, '2-1-X-1', 1, 9),
    (38, 20, 'secundario', 13, 1, 14, '3-1-X-2', 4, 6),
    (38, 20, 'secundario', 14, 2, 14, '3-1-X-2', 3, 7),
    (38, 20, 'secundario', 15, 2, 14, '3-1-X-2', 2, 8),
    (38, 24, 'core', 16, 4, 20, NULL, NULL, NULL),
    (38, 25, 'core', 17, 4, 20, NULL, NULL, NULL);

-- ---------- SEMANA 8 (dia_id=40) ----------
INSERT INTO series (dia_id, ejercicio_id, tipo_ejercicio, orden, sets, reps, tempo, rir, rpe) VALUES
    (40, 2, 'principal', 1, 1, 7, '2-0-X-1', 3, 7),
    (40, 2, 'principal', 2, 1, 7, '2-0-X-1', 2, 8),
    (40, 2, 'principal', 3, 3, 7, '2-0-X-1', 1, 9),
    (40, 21, 'principal', 4, 1, 7, '2-1-X-1', 3, 7),
    (40, 21, 'principal', 5, 1, 7, '2-1-X-1', 2, 8),
    (40, 21, 'principal', 6, 3, 7, '2-1-X-1', 1, 9),
    (40, 19, 'secundario', 7, 1, 7, '2-0-X-1', 3, 7),
    (40, 19, 'secundario', 8, 1, 7, '2-0-X-1', 2, 8),
    (40, 19, 'secundario', 9, 3, 7, '2-0-X-1', 1, 9),
    (40, 18, 'secundario', 10, 1, 7, '2-1-X-1', 3, 7),
    (40, 18, 'secundario', 11, 1, 7, '2-1-X-1', 2, 8),
    (40, 18, 'secundario', 12, 3, 7, '2-1-X-1', 1, 9),
    (40, 20, 'secundario', 13, 1, 14, '3-1-X-2', 4, 6),
    (40, 20, 'secundario', 14, 1, 14, '3-1-X-2', 3, 7),
    (40, 20, 'secundario', 15, 3, 14, '3-1-X-2', 2, 8),
    (40, 24, 'core', 16, 4, 20, NULL, NULL, NULL),
    (40, 25, 'core', 17, 4, 20, NULL, NULL, NULL);

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

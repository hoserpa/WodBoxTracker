-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 1 - SEMANA 4
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 24;

-- ============================================
-- CALENTAMIENTO (3 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(24, 1, 3, '20"', 'calentamiento', 1),
(24, 2, 3, '5', 'calentamiento', 2),
(24, 7, 3, '10', 'calentamiento', 3),
(24, 15, 3, '20"', 'calentamiento', 4),
(24, 13, 3, '10', 'calentamiento', 5);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=2-0-X-1
-- ============================================

-- A: BACK SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(24, 37, 1, '9', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 10),
(24, 37, 1, '9', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 11),
(24, 37, 3, '9', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 12);

-- B: PRESS DE BANCA
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(24, 39, 1, '9', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 20),
(24, 39, 1, '9', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 21),
(24, 39, 3, '9', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-2-X-2, B=2-1-X-1, C=2-1-X-2
-- ============================================

-- A: BANDED TRICEPS EXTENSION
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(24, 52, 1, '9', 'RIR3 RPE7 - Tempo 2-2-X-2', 'secundario', 30),
(24, 52, 1, '9', 'RIR2 RPE8 - Tempo 2-2-X-2', 'secundario', 31),
(24, 52, 3, '9', 'RIR1 RPE9 - Tempo 2-2-X-2', 'secundario', 32);

-- B: BULGARIAN SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(24, 47, 1, '9', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 40),
(24, 47, 1, '9', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 41),
(24, 47, 3, '9', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 42);

-- C: BAND GLUTE KICKBACK
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(24, 53, 1, '9', 'RIR3 RPE7 - Tempo 2-1-X-2', 'secundario', 50),
(24, 53, 1, '9', 'RIR2 RPE8 - Tempo 2-1-X-2', 'secundario', 51),
(24, 53, 3, '9', 'RIR1 RPE9 - Tempo 2-1-X-2', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(24, 60, 4, '25"', 'core', 60),
(24, 61, 3, '20"', 'core', 61);

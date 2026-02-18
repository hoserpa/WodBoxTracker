-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 1 - SEMANA 8
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 33;

-- ============================================
-- CALENTAMIENTO (3 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(33, 1, 3, '20"', 'calentamiento', 1),
(33, 2, 3, '5', 'calentamiento', 2),
(33, 7, 3, '10', 'calentamiento', 3),
(33, 15, 3, '20"', 'calentamiento', 4),
(33, 13, 3, '10', 'calentamiento', 5);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=2-0-X-1
-- ============================================

-- A: BACK SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(33, 37, 1, '7', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 10),
(33, 37, 1, '7', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 11),
(33, 37, 3, '7', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 12);

-- B: PRESS DE BANCA
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(33, 39, 1, '7', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 20),
(33, 39, 1, '7', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 21),
(33, 39, 3, '7', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-2, B=2-0-X-1, C=2-1-X-2
-- ============================================

-- A: BANDED TRICEPS EXTENSION
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(33, 52, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-2', 'secundario', 30),
(33, 52, 1, '7', 'RIR2 RPE8 - Tempo 2-1-X-2', 'secundario', 31),
(33, 52, 3, '7', 'RIR1 RPE9 - Tempo 2-1-X-2', 'secundario', 32);

-- B: BULGARIAN SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(33, 47, 1, '7', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 40),
(33, 47, 1, '7', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 41),
(33, 47, 3, '7', 'RIR1 RPE9 - Tempo 2-0-X-1', 'secundario', 42);

-- C: BAND GLUTE KICKBACK
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(33, 53, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-2', 'secundario', 50),
(33, 53, 1, '7', 'RIR2 RPE8 - Tempo 2-1-X-2', 'secundario', 51),
(33, 53, 3, '7', 'RIR1 RPE9 - Tempo 2-1-X-2', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(33, 60, 4, '35"', 'core', 60),
(33, 61, 3, '30"', 'core', 61);

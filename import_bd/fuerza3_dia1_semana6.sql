-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 1 - SEMANA 6
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 15;

-- ============================================
-- CALENTAMIENTO (3 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(15, 1, 3, '20"', 'calentamiento', 1),
(15, 2, 3, '5', 'calentamiento', 2),
(15, 7, 3, '10', 'calentamiento', 3),
(15, 15, 3, '20"', 'calentamiento', 4),
(15, 13, 3, '10', 'calentamiento', 5);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=2-0-X-1
-- ============================================

-- A: BACK SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(15, 37, 1, '8', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 10),
(15, 37, 1, '8', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 11),
(15, 37, 3, '8', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 12);

-- B: PRESS DE BANCA
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(15, 39, 1, '8', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 20),
(15, 39, 1, '8', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 21),
(15, 39, 3, '8', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-2, B=2-0-X-1, C=2-1-X-2
-- ============================================

-- A: BANDED TRICEPS EXTENSION
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(15, 52, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-2', 'secundario', 30),
(15, 52, 1, '8', 'RIR2 RPE8 - Tempo 2-1-X-2', 'secundario', 31),
(15, 52, 3, '8', 'RIR1 RPE9 - Tempo 2-1-X-2', 'secundario', 32);

-- B: BULGARIAN SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(15, 47, 1, '8', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 40),
(15, 47, 1, '8', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 41),
(15, 47, 3, '8', 'RIR1 RPE9 - Tempo 2-0-X-1', 'secundario', 42);

-- C: BAND GLUTE KICKBACK
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(15, 53, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-2', 'secundario', 50),
(15, 53, 1, '8', 'RIR2 RPE8 - Tempo 2-1-X-2', 'secundario', 51),
(15, 53, 3, '8', 'RIR1 RPE9 - Tempo 2-1-X-2', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(15, 60, 4, '30"', 'core', 60),
(15, 61, 3, '25"', 'core', 61);

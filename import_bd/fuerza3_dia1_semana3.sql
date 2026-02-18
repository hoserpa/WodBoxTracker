-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 1 - SEMANA 3
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 14;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(14, 28, 2, '20"', 'calentamiento', 1),
(14, 29, 2, '20"', 'calentamiento', 2),
(14, 30, 2, '5+5', 'calentamiento', 3),
(14, 31, 2, '10+10', 'calentamiento', 4),
(14, 23, 2, '10', 'calentamiento', 5),
(14, 15, 2, '20"', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=2-0-X-1
-- ============================================

-- A: BACK SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(14, 37, 1, '10', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 10),
(14, 37, 1, '10', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 11),
(14, 37, 3, '10', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 12);

-- B: PRESS DE BANCA
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(14, 39, 1, '10', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 20),
(14, 39, 1, '10', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 21),
(14, 39, 3, '10', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-2-X-2, B=2-1-X-1, C=2-1-X-2
-- ============================================

-- A: BANDED TRICEPS EXTENSION
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(14, 52, 1, '10', 'RIR3 RPE7 - Tempo 2-2-X-2', 'secundario', 30),
(14, 52, 1, '10', 'RIR2 RPE8 - Tempo 2-2-X-2', 'secundario', 31),
(14, 52, 3, '10', 'RIR1 RPE9 - Tempo 2-2-X-2', 'secundario', 32);

-- B: BULGARIAN SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(14, 47, 1, '10', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 40),
(14, 47, 1, '10', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 41),
(14, 47, 3, '10', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 42);

-- C: BAND GLUTE KICKBACK
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(14, 53, 1, '10', 'RIR3 RPE7 - Tempo 2-1-X-2', 'secundario', 50),
(14, 53, 1, '10', 'RIR2 RPE8 - Tempo 2-1-X-2', 'secundario', 51),
(14, 53, 3, '10', 'RIR1 RPE9 - Tempo 2-1-X-2', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(14, 60, 4, '25"', 'core', 60),
(14, 61, 3, '20"', 'core', 61);

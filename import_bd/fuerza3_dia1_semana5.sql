-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 1 - SEMANA 5
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 16;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(16, 28, 2, '20"', 'calentamiento', 1),
(16, 29, 2, '20"', 'calentamiento', 2),
(16, 30, 2, '5+5', 'calentamiento', 3),
(16, 31, 2, '10+10', 'calentamiento', 4),
(16, 23, 2, '10', 'calentamiento', 5),
(16, 15, 2, '20"', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=2-0-X-1
-- ============================================

-- A: BACK SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(16, 37, 1, '8', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 10),
(16, 37, 2, '8', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 11),
(16, 37, 2, '8', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 12);

-- B: PRESS DE BANCA
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(16, 39, 1, '8', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 20),
(16, 39, 2, '8', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 21),
(16, 39, 2, '8', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-2, B=2-0-X-1, C=2-1-X-2
-- ============================================

-- A: BANDED TRICEPS EXTENSION
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(16, 52, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-2', 'secundario', 30),
(16, 52, 2, '8', 'RIR2 RPE8 - Tempo 2-1-X-2', 'secundario', 31),
(16, 52, 2, '8', 'RIR1 RPE9 - Tempo 2-1-X-2', 'secundario', 32);

-- B: BULGARIAN SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(16, 47, 1, '8', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 40),
(16, 47, 2, '8', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 41),
(16, 47, 2, '8', 'RIR1 RPE9 - Tempo 2-0-X-1', 'secundario', 42);

-- C: BAND GLUTE KICKBACK
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(16, 53, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-2', 'secundario', 50),
(16, 53, 2, '8', 'RIR2 RPE8 - Tempo 2-1-X-2', 'secundario', 51),
(16, 53, 2, '8', 'RIR1 RPE9 - Tempo 2-1-X-2', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(16, 60, 4, '30"', 'core', 60),
(16, 61, 3, '25"', 'core', 61);

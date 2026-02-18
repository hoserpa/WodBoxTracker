-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 1 - SEMANA 2
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 18;

-- ============================================
-- CALENTAMIENTO (3 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(18, 1, 3, '20"', 'calentamiento', 1),
(18, 2, 3, '5', 'calentamiento', 2),
(18, 7, 3, '10', 'calentamiento', 3),
(18, 15, 3, '20"', 'calentamiento', 4),
(18, 13, 3, '10', 'calentamiento', 5);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=2-0-X-1
-- ============================================

-- A: BACK SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(18, 37, 1, '12', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 10),
(18, 37, 2, '12', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 11),
(18, 37, 2, '12', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 12);

-- B: PRESS DE BANCA
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(18, 39, 1, '12', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 20),
(18, 39, 2, '12', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 21),
(18, 39, 2, '12', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-2, B=2-1-X-1, C=2-1-X-2
-- ============================================

-- A: BANDED TRICEPS EXTENSION
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(18, 52, 1, '12', 'RIR3 RPE7 - Tempo 2-1-X-2', 'secundario', 30),
(18, 52, 2, '12', 'RIR2 RPE8 - Tempo 2-1-X-2', 'secundario', 31),
(18, 52, 2, '12', 'RIR1 RPE9 - Tempo 2-1-X-2', 'secundario', 32);

-- B: BULGARIAN SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(18, 47, 1, '12', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 40),
(18, 47, 2, '12', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 41),
(18, 47, 2, '12', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 42);

-- C: BAND GLUTE KICKBACK
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(18, 53, 1, '12', 'RIR3 RPE7 - Tempo 2-1-X-2', 'secundario', 50),
(18, 53, 2, '12', 'RIR2 RPE8 - Tempo 2-1-X-2', 'secundario', 51),
(18, 53, 2, '12', 'RIR1 RPE9 - Tempo 2-1-X-2', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(18, 60, 4, '20"', 'core', 60),
(18, 61, 3, '20"', 'core', 61);

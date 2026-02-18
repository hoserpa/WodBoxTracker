-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 1 - SEMANA 1
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 48;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(48, 28, 2, '20"', 'calentamiento', 1),
(48, 29, 2, '20"', 'calentamiento', 2),
(48, 30, 2, '5+5', 'calentamiento', 3),
(48, 31, 2, '10+10', 'calentamiento', 4),
(48, 23, 2, '10', 'calentamiento', 5),
(48, 15, 2, '20"', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=2-0-X-1
-- ============================================

-- A: BACK SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(48, 37, 1, '14', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 10),
(48, 37, 2, '14', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 11),
(48, 37, 1, '14', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 12);

-- B: PRESS DE BANCA
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(48, 39, 1, '14', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 20),
(48, 39, 2, '14', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 21),
(48, 39, 1, '14', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-2, B=2-1-X-1, C=2-1-X-2
-- ============================================

-- A: BANDED TRICEPS EXTENSION
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(48, 52, 1, '14', 'RIR3 RPE7 - Tempo 2-1-X-2', 'secundario', 30),
(48, 52, 2, '14', 'RIR2 RPE8 - Tempo 2-1-X-2', 'secundario', 31),
(48, 52, 1, '14', 'RIR1 RPE9 - Tempo 2-1-X-2', 'secundario', 32);

-- B: BULGARIAN SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(48, 47, 1, '14', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 40),
(48, 47, 2, '14', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 41),
(48, 47, 1, '14', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 42);

-- C: BAND GLUTE KICKBACK
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(48, 53, 1, '14', 'RIR3 RPE7 - Tempo 2-1-X-2', 'secundario', 50),
(48, 53, 2, '14', 'RIR2 RPE8 - Tempo 2-1-X-2', 'secundario', 51),
(48, 53, 1, '14', 'RIR1 RPE9 - Tempo 2-1-X-2', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(48, 60, 4, '20"', 'core', 60),
(48, 61, 3, '20"', 'core', 61);

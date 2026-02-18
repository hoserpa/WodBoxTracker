-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 2 - SEMANA 3
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 22;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(22, 2, 2, '5', 'calentamiento', 1),
(22, 3, 2, '10', 'calentamiento', 2),
(22, 4, 2, '30"', 'calentamiento', 3),
(22, 5, 2, '10', 'calentamiento', 4),
(22, 6, 2, '5', 'calentamiento', 5),
(22, 68, 2, '10 (5+5)', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: PULL UP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(22, 38, 1, '10', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 10),
(22, 38, 1, '10', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 11),
(22, 38, 3, '10', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 12);

-- B: SEATED ALTERNATE DB SHOULDER PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(22, 43, 1, '10', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 20),
(22, 43, 1, '10', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 21),
(22, 43, 3, '10', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1, C=3-1-X-2
-- ============================================

-- A: HIP THRUST
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(22, 54, 1, '10', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 30),
(22, 54, 1, '10', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 31),
(22, 54, 3, '10', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 32);

-- B: KB SPLIT SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(22, 55, 1, '10', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 40),
(22, 55, 1, '10', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 41),
(22, 55, 3, '10', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 42);

-- C: FEXO-EXTENSION DE GEMELOS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(22, 56, 1, '20', 'RIR4 RPE6 - Tempo 3-1-X-2', 'secundario', 50),
(22, 56, 1, '20', 'RIR3 RPE7 - Tempo 3-1-X-2', 'secundario', 51),
(22, 56, 3, '20', 'RIR2 RPE8 - Tempo 3-1-X-2', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(22, 62, 4, '20"', 'core', 60),
(22, 63, 4, '20"', 'core', 61);

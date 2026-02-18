-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 2 - SEMANA 5
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 8;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(8, 2, 2, '5', 'calentamiento', 1),
(8, 3, 2, '10', 'calentamiento', 2),
(8, 4, 2, '30"', 'calentamiento', 3),
(8, 5, 2, '10', 'calentamiento', 4),
(8, 6, 2, '5', 'calentamiento', 5),
(8, 68, 2, '10 (5+5)', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=2-1-X-1
-- ============================================

-- A: PULL UP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(8, 38, 1, '8', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 10),
(8, 38, 2, '8', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 11),
(8, 38, 2, '8', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 12);

-- B: SEATED ALTERNATE DB SHOULDER PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(8, 43, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 20),
(8, 43, 2, '8', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 21),
(8, 43, 2, '8', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-0-X-1, B=2-1-X-1, C=2-1-X-2
-- ============================================

-- A: HIP THRUST
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(8, 54, 1, '8', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 30),
(8, 54, 2, '8', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 31),
(8, 54, 2, '8', 'RIR1 RPE9 - Tempo 2-0-X-1', 'secundario', 32);

-- B: KB SPLIT SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(8, 55, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 40),
(8, 55, 2, '8', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 41),
(8, 55, 2, '8', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 42);

-- C: FEXO-EXTENSION DE GEMELOS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(8, 56, 1, '16', 'RIR4 RPE6 - Tempo 2-1-X-2', 'secundario', 50),
(8, 56, 2, '16', 'RIR3 RPE7 - Tempo 2-1-X-2', 'secundario', 51),
(8, 56, 2, '16', 'RIR2 RPE8 - Tempo 2-1-X-2', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(8, 62, 4, '20"', 'core', 60),
(8, 63, 4, '20"', 'core', 61);

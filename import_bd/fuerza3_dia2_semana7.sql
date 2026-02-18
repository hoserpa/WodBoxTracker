-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 2 - SEMANA 7
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 32;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(32, 2, 2, '5', 'calentamiento', 1),
(32, 3, 2, '10', 'calentamiento', 2),
(32, 4, 2, '30"', 'calentamiento', 3),
(32, 5, 2, '10', 'calentamiento', 4),
(32, 6, 2, '5', 'calentamiento', 5),
(32, 68, 2, '10', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=2-1-X-1
-- ============================================

-- A: PULL UP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(32, 38, 1, '7', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 10),
(32, 38, 2, '7', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 11),
(32, 38, 2, '7', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 12);

-- B: SEATED ALTERNATE DB SHOULDER PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(32, 43, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 20),
(32, 43, 2, '7', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 21),
(32, 43, 2, '7', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-0-X-1, B=2-1-X-1, C=2-1-X-2
-- ============================================

-- A: HIP THRUST
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(32, 54, 1, '7', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 30),
(32, 54, 2, '7', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 31),
(32, 54, 2, '7', 'RIR1 RPE9 - Tempo 2-0-X-1', 'secundario', 32);

-- B: KB SPLIT SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(32, 55, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 40),
(32, 55, 2, '7', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 41),
(32, 55, 2, '7', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 42);

-- C: FEXO-EXTENSION DE GEMELOS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(32, 56, 1, '14', 'RIR4 RPE6 - Tempo 2-1-X-2', 'secundario', 50),
(32, 56, 2, '14', 'RIR3 RPE7 - Tempo 2-1-X-2', 'secundario', 51),
(32, 56, 2, '14', 'RIR2 RPE8 - Tempo 2-1-X-2', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(32, 62, 4, '20"', 'core', 60),
(32, 63, 4, '20"', 'core', 61);

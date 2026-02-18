-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 2 - SEMANA 1
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 35;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(35, 2, 2, '5', 'calentamiento', 1),
(35, 3, 2, '10', 'calentamiento', 2),
(35, 4, 2, '30"', 'calentamiento', 3),
(35, 5, 2, '10', 'calentamiento', 4),
(35, 6, 2, '5', 'calentamiento', 5),
(35, 68, 2, '10 (5+5)', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: PULL UP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(35, 38, 1, '14', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 10),
(35, 38, 2, '14', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 11),
(35, 38, 1, '14', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 12);

-- B: SEATED ALTERNATE DB SHOULDER PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(35, 43, 1, '14', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 20),
(35, 43, 2, '14', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 21),
(35, 43, 1, '14', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1, C=3-1-X-2
-- ============================================

-- A: HIP THRUST
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(35, 54, 1, '14', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 30),
(35, 54, 2, '14', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 31),
(35, 54, 1, '14', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 32);

-- B: KB SPLIT SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(35, 55, 1, '14', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 40),
(35, 55, 2, '14', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 41),
(35, 55, 1, '14', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 42);

-- C: FEXO-EXTENSION DE GEMELOS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(35, 56, 1, '20', 'RIR4 RPE6 - Tempo 3-1-X-2', 'secundario', 50),
(35, 56, 2, '20', 'RIR3 RPE7 - Tempo 3-1-X-2', 'secundario', 51),
(35, 56, 1, '20', 'RIR2 RPE8 - Tempo 3-1-X-2', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(35, 62, 4, '20"', 'core', 60),
(35, 63, 4, '20"', 'core', 61);

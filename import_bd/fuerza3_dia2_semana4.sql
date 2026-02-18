-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 2 - SEMANA 4
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 12;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(12, 26, 2, '30', 'calentamiento', 1),
(12, 1, 2, '20"', 'calentamiento', 2),
(12, 15, 2, '20"', 'calentamiento', 3),
(12, 3, 2, '10', 'calentamiento', 4),
(12, 4, 2, '30"', 'calentamiento', 5),
(12, 5, 2, '10', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: PULL UP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(12, 38, 1, '9', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 10),
(12, 38, 1, '9', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 11),
(12, 38, 3, '9', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 12);

-- B: SEATED ALTERNATE DB SHOULDER PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(12, 43, 1, '9', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 20),
(12, 43, 1, '9', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 21),
(12, 43, 3, '9', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1, C=3-1-X-2
-- ============================================

-- A: HIP THRUST
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(12, 54, 1, '9', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 30),
(12, 54, 1, '9', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 31),
(12, 54, 3, '9', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 32);

-- B: KB SPLIT SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(12, 55, 1, '9', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 40),
(12, 55, 1, '9', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 41),
(12, 55, 3, '9', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 42);

-- C: FEXO-EXTENSION DE GEMELOS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(12, 56, 1, '18', 'RIR4 RPE6 - Tempo 3-1-X-2', 'secundario', 50),
(12, 56, 1, '18', 'RIR3 RPE7 - Tempo 3-1-X-2', 'secundario', 51),
(12, 56, 3, '18', 'RIR2 RPE8 - Tempo 3-1-X-2', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(12, 62, 4, '20"', 'core', 60),
(12, 63, 4, '20"', 'core', 61);

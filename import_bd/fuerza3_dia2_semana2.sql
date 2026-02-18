-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 2 - SEMANA 2
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 4;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(4, 26, 2, '30', 'calentamiento', 1),
(4, 1, 2, '20"', 'calentamiento', 2),
(4, 15, 2, '20"', 'calentamiento', 3),
(4, 3, 2, '10', 'calentamiento', 4),
(4, 4, 2, '30"', 'calentamiento', 5),
(4, 5, 2, '10', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: PULL UP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(4, 38, 1, '12', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 10),
(4, 38, 2, '12', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 11),
(4, 38, 2, '12', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 12);

-- B: SEATED ALTERNATE DB SHOULDER PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(4, 43, 1, '12', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 20),
(4, 43, 2, '12', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 21),
(4, 43, 2, '12', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1, C=3-1-X-2
-- ============================================

-- A: HIP THRUST
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(4, 54, 1, '12', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 30),
(4, 54, 2, '12', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 31),
(4, 54, 2, '12', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 32);

-- B: KB SPLIT SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(4, 55, 1, '12', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 40),
(4, 55, 2, '12', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 41),
(4, 55, 2, '12', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 42);

-- C: FEXO-EXTENSION DE GEMELOS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(4, 56, 1, '20', 'RIR4 RPE6 - Tempo 3-1-X-2', 'secundario', 50),
(4, 56, 2, '20', 'RIR3 RPE7 - Tempo 3-1-X-2', 'secundario', 51),
(4, 56, 2, '20', 'RIR2 RPE8 - Tempo 3-1-X-2', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(4, 62, 4, '20"', 'core', 60),
(4, 63, 4, '20"', 'core', 61);

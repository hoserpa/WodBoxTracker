-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 2 - SEMANA 6
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 7;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(7, 26, 2, '30', 'calentamiento', 1),
(7, 1, 2, '20"', 'calentamiento', 2),
(7, 15, 2, '20"', 'calentamiento', 3),
(7, 3, 2, '10', 'calentamiento', 4),
(7, 4, 2, '30"', 'calentamiento', 5),
(7, 5, 2, '10', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=2-1-X-1
-- ============================================

-- A: PULL UP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(7, 38, 1, '8', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 10),
(7, 38, 1, '8', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 11),
(7, 38, 3, '8', 'RIR1 RPE9 - Tempo 2-0-X-1', 'principal', 12);

-- B: SEATED ALTERNATE DB SHOULDER PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(7, 43, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 20),
(7, 43, 1, '8', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 21),
(7, 43, 3, '8', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-0-X-1, B=2-1-X-1, C=2-1-X-2
-- ============================================

-- A: HIP THRUST
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(7, 54, 1, '8', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 30),
(7, 54, 1, '8', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 31),
(7, 54, 3, '8', 'RIR1 RPE9 - Tempo 2-0-X-1', 'secundario', 32);

-- B: KB SPLIT SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(7, 55, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 40),
(7, 55, 1, '8', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 41),
(7, 55, 3, '8', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 42);

-- C: FEXO-EXTENSION DE GEMELOS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(7, 56, 1, '16', 'RIR4 RPE6 - Tempo 2-1-X-2', 'secundario', 50),
(7, 56, 1, '16', 'RIR3 RPE7 - Tempo 2-1-X-2', 'secundario', 51),
(7, 56, 3, '16', 'RIR2 RPE8 - Tempo 2-1-X-2', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(7, 62, 4, '20"', 'core', 60),
(7, 63, 4, '20"', 'core', 61);

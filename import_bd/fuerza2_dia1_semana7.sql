-- FUERZA AVANZADO 2 - DÍA 1 - SEMANA 7
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 31;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(31, 1, 2, '20"', 'calentamiento', 1),
(31, 2, 2, '5', 'calentamiento', 2),
(31, 3, 2, '10', 'calentamiento', 3),
(31, 4, 2, '30"', 'calentamiento', 4),
(31, 5, 2, '10', 'calentamiento', 5),
(31, 6, 2, '5', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=1-0-X-1, B=2-1-X-1
-- ============================================

-- A: BACK SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(31, 37, 1, '2', 'RIR4 RPE6 - Tempo 1-0-X-1', 'principal', 10),
(31, 37, 1, '2', 'RIR3 RPE7 - Tempo 1-0-X-1', 'principal', 11),
(31, 37, 3, '2', 'RIR2 RPE8 - Tempo 1-0-X-1', 'principal', 12);

-- B: PULL UP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(31, 38, 1, '2', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 20),
(31, 38, 1, '2', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 21),
(31, 38, 3, '2', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: SEATED DB SHOULDER PRESS ALTERNO
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(31, 44, 1, '2', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(31, 44, 1, '2', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(31, 44, 2, '2', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: TRICEP KICKBACK EXTENSION
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(31, 45, 1, '2', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(31, 45, 1, '2', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(31, 45, 2, '2', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: COPENHAGUEN HIP ABDUCTION HOLD
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(31, 46, 2, '30"', 'secundario', 50);

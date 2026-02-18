-- FUERZA AVANZADO 2 - DÍA 1 - SEMANA 5
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 19;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(19, 1, 2, '20"', 'calentamiento', 1),
(19, 2, 2, '5', 'calentamiento', 2),
(19, 7, 2, '10', 'calentamiento', 3),
(19, 15, 2, '20"', 'calentamiento', 4),
(19, 13, 2, '10', 'calentamiento', 5),
(19, 3, 2, '10', 'calentamiento', 6),
(19, 14, 2, '10', 'calentamiento', 7);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=2-1-X-1
-- ============================================

-- A: BACK SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(19, 37, 1, '3', 'RIR4 RPE6 - Tempo 2-0-X-1', 'principal', 10),
(19, 37, 1, '3', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 11),
(19, 37, 3, '3', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 12);

-- B: PULL UP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(19, 38, 1, '3', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 20),
(19, 38, 1, '3', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 21),
(19, 38, 3, '3', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: SEATED DB SHOULDER PRESS ALTERNO
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(19, 44, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(19, 44, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(19, 44, 2, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: TRICEP KICKBACK EXTENSION
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(19, 45, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(19, 45, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(19, 45, 2, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: COPENHAGUEN HIP ABDUCTION HOLD
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(19, 46, 2, '30"', 'secundario', 50);

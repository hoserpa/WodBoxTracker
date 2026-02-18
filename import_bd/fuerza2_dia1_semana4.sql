-- FUERZA AVANZADO 2 - DÍA 1 - SEMANA 4
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 2;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(2, 1, 2, '20"', 'calentamiento', 1),
(2, 2, 2, '5', 'calentamiento', 2),
(2, 3, 2, '10', 'calentamiento', 3),
(2, 4, 2, '30"', 'calentamiento', 4),
(2, 5, 2, '10', 'calentamiento', 5),
(2, 6, 2, '5', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: BACK SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(2, 37, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 10),
(2, 37, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 11),
(2, 37, 2, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 12),
(2, 37, 1, '3', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 13);

-- B: PULL UP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(2, 38, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 20),
(2, 38, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 21),
(2, 38, 2, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 22),
(2, 38, 1, '3', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 23);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: SEATED DB SHOULDER PRESS ALTERNO
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(2, 44, 1, '5', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(2, 44, 1, '5', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(2, 44, 2, '5', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: TRICEP KICKBACK EXTENSION
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(2, 45, 1, '5', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(2, 45, 1, '5', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(2, 45, 2, '5', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: COPENHAGUEN HIP ABDUCTION HOLD
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(2, 46, 2, '20"', 'secundario', 50);

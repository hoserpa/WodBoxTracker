-- FUERZA AVANZADO 2 - DÍA 1 - SEMANA 1
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 6;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(6, 1, 2, '20"', 'calentamiento', 1),
(6, 2, 2, '5', 'calentamiento', 2),
(6, 3, 2, '10', 'calentamiento', 3),
(6, 4, 2, '30"', 'calentamiento', 4),
(6, 5, 2, '10', 'calentamiento', 5),
(6, 6, 2, '5', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=3-1-X-1, B=2-1-X-1
-- ============================================

-- A: BACK SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(6, 37, 1, '5', 'RIR4 RPE6 - Tempo 3-1-X-1', 'principal', 10),
(6, 37, 1, '5', 'RIR3 RPE7 - Tempo 3-1-X-1', 'principal', 11),
(6, 37, 3, '5', 'RIR2 RPE8 - Tempo 3-1-X-1', 'principal', 12);

-- B: PULL UP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(6, 38, 1, '5', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 20),
(6, 38, 1, '5', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 21),
(6, 38, 3, '5', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: SEATED DB SHOULDER PRESS ALTERNO
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(6, 44, 1, '8', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(6, 44, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(6, 44, 2, '8', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: TRICEP KICKBACK EXTENSION
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(6, 45, 1, '8', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(6, 45, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(6, 45, 2, '8', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: COPENHAGUEN HIP ABDUCTION HOLD
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(6, 46, 2, '20"', 'secundario', 50);

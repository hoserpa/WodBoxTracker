-- FUERZA AVANZADO 2 - DÍA 1 - SEMANA 8
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 25;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(25, 1, 2, '20"', 'calentamiento', 1),
(25, 2, 2, '5', 'calentamiento', 2),
(25, 7, 2, '10', 'calentamiento', 3),
(25, 15, 2, '20"', 'calentamiento', 4),
(25, 13, 2, '10', 'calentamiento', 5),
(25, 3, 2, '10', 'calentamiento', 6),
(25, 14, 2, '10', 'calentamiento', 7);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=1-0-X-1, B=2-1-X-1
-- ============================================

-- A: BACK SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(25, 37, 1, '1', 'RIR4 RPE6 - Tempo 1-0-X-1', 'principal', 10),
(25, 37, 1, '1', 'RIR3 RPE7 - Tempo 1-0-X-1', 'principal', 11),
(25, 37, 3, '1', 'RIR2 RPE8 - Tempo 1-0-X-1', 'principal', 12);

-- B: PULL UP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(25, 38, 1, '1', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 20),
(25, 38, 1, '1', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 21),
(25, 38, 3, '1', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: SEATED DB SHOULDER PRESS ALTERNO
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(25, 44, 1, '1', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(25, 44, 1, '1', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(25, 44, 2, '1', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: TRICEP KICKBACK EXTENSION
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(25, 45, 1, '1', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(25, 45, 1, '1', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(25, 45, 2, '1', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: COPENHAGUEN HIP ABDUCTION HOLD
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(25, 46, 2, '30"', 'secundario', 50);

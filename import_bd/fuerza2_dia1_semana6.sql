-- FUERZA AVANZADO 2 - DÍA 1 - SEMANA 6
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 42;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(42, 2, 2, '10', 'calentamiento', 1),
(42, 7, 2, '10', 'calentamiento', 2),
(42, 8, 2, '10', 'calentamiento', 3),
(42, 9, 2, '15"', 'calentamiento', 4),
(42, 10, 2, '10', 'calentamiento', 5),
(42, 11, 2, '10', 'calentamiento', 6),
(42, 12, 2, '10', 'calentamiento', 7);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=2-1-X-1
-- ============================================

-- A: BACK SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(42, 37, 1, '3', 'RIR4 RPE6 - Tempo 2-0-X-1', 'principal', 10),
(42, 37, 1, '3', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 11),
(42, 37, 2, '3', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 12),
(42, 37, 1, '2', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 13);

-- B: PULL UP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(42, 38, 1, '3', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 20),
(42, 38, 1, '3', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 21),
(42, 38, 2, '3', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 22),
(42, 38, 1, '2', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 23);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: SEATED DB SHOULDER PRESS ALTERNO
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(42, 44, 1, '3', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(42, 44, 1, '3', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(42, 44, 2, '3', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: TRICEP KICKBACK EXTENSION
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(42, 45, 1, '3', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(42, 45, 1, '3', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(42, 45, 2, '3', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: COPENHAGUEN HIP ABDUCTION HOLD
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(42, 46, 2, '30"', 'secundario', 50);

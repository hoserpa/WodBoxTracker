-- FUERZA AVANZADO 2 - DÍA 1 - SEMANA 3
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 44;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(44, 7, 2, '10', 'calentamiento', 1),
(44, 8, 2, '10', 'calentamiento', 2),
(44, 9, 2, '15"', 'calentamiento', 3),
(44, 10, 2, '10', 'calentamiento', 4),
(44, 11, 2, '10', 'calentamiento', 5),
(44, 2, 2, '10', 'calentamiento', 6),
(44, 12, 2, '10', 'calentamiento', 7);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: BACK SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(44, 37, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 10),
(44, 37, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 11),
(44, 37, 3, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 12);

-- B: PULL UP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(44, 38, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 20),
(44, 38, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 21),
(44, 38, 3, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: SEATED DB SHOULDER PRESS ALTERNO
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(44, 44, 1, '6', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(44, 44, 1, '6', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(44, 44, 2, '6', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: TRICEP KICKBACK EXTENSION
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(44, 45, 1, '6', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(44, 45, 1, '6', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(44, 45, 2, '6', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: COPENHAGUEN HIP ABDUCTION HOLD
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(44, 46, 2, '20"', 'secundario', 50);

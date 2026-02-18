-- FUERZA AVANZADO 2 - DÍA 1 - SEMANA 2
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 46;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(46, 1, 2, '20"', 'calentamiento', 1),
(46, 2, 2, '5', 'calentamiento', 2),
(46, 7, 2, '10', 'calentamiento', 3),
(46, 15, 2, '20"', 'calentamiento', 4),
(46, 13, 2, '10', 'calentamiento', 5),
(46, 3, 2, '10', 'calentamiento', 6),
(46, 14, 2, '10', 'calentamiento', 7);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=3-1-X-1, B=2-1-X-1
-- ============================================

-- A: BACK SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(46, 37, 1, '5', 'RIR4 RPE6 - Tempo 3-1-X-1', 'principal', 10),
(46, 37, 1, '5', 'RIR3 RPE7 - Tempo 3-1-X-1', 'principal', 11),
(46, 37, 2, '5', 'RIR2 RPE8 - Tempo 3-1-X-1', 'principal', 12),
(46, 37, 1, '4', 'RIR2 RPE8 - Tempo 3-1-X-1', 'principal', 13);

-- B: PULL UP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(46, 38, 1, '5', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 20),
(46, 38, 1, '5', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 21),
(46, 38, 2, '5', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 22),
(46, 38, 1, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 23);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: SEATED DB SHOULDER PRESS ALTERNO
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(46, 44, 1, '7', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(46, 44, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(46, 44, 2, '7', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: TRICEP KICKBACK EXTENSION
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(46, 45, 1, '7', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(46, 45, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(46, 45, 2, '7', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: COPENHAGUEN HIP ABDUCTION HOLD
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(46, 46, 2, '20"', 'secundario', 50);

-- FUERZA AVANZADO 2 - DÍA 3 - SEMANA 2
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 13;

-- ============================================
-- CALENTAMIENTO (3 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(13, 25, 3, '3', 'calentamiento', 1),
(13, 27, 2, '20"', 'calentamiento', 2),
(13, 11, 2, '10', 'calentamiento', 3),
(13, 2, 2, '10', 'calentamiento', 4),
(13, 12, 2, '10', 'calentamiento', 5),
(13, 13, 2, '10', 'calentamiento', 6),
(13, 67, 2, '10', 'calentamiento', 7);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: SHOULDER PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(13, 41, 1, '5', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 10),
(13, 41, 1, '5', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 11),
(13, 41, 2, '5', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 12),
(13, 41, 1, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 13);

-- B: FRONT SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(13, 42, 1, '5', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 20),
(13, 42, 1, '5', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 21),
(13, 42, 2, '5', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 22),
(13, 42, 1, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 23);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-0-X-1, C=2-0-X-1
-- ============================================

-- A: ALTERNATING DUMBBELL FLOOR PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(13, 49, 1, '7', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(13, 49, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(13, 49, 2, '7', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: KB ONE ARM ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(13, 50, 1, '7', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 40),
(13, 50, 1, '7', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 41),
(13, 50, 2, '7', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 42);

-- C: KB RDL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(13, 51, 1, '7', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 50),
(13, 51, 1, '7', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 51),
(13, 51, 2, '7', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 52);

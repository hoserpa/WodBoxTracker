-- FUERZA AVANZADO 2 - DÍA 3 - SEMANA 5
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 28;

-- ============================================
-- CALENTAMIENTO (3 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(28, 25, 3, '3', 'calentamiento', 1),
(28, 27, 2, '20"', 'calentamiento', 2),
(28, 11, 2, '10', 'calentamiento', 3),
(28, 2, 2, '10', 'calentamiento', 4),
(28, 12, 2, '10', 'calentamiento', 5),
(28, 67, 2, '10', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1, B=2-0-X-1
-- ============================================

-- A: SHOULDER PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(28, 41, 1, '3', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 10),
(28, 41, 1, '3', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 11),
(28, 41, 3, '3', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 12);

-- B: FRONT SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(28, 42, 1, '3', 'RIR4 RPE6 - Tempo 2-0-X-1', 'principal', 20),
(28, 42, 1, '3', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 21),
(28, 42, 3, '3', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-0-X-1, C=2-0-X-1
-- ============================================

-- A: ALTERNATING DUMBBELL FLOOR PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(28, 49, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(28, 49, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(28, 49, 2, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: KB ONE ARM ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(28, 50, 1, '4', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 40),
(28, 50, 1, '4', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 41),
(28, 50, 2, '4', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 42);

-- C: KB RDL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(28, 51, 1, '4', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 50),
(28, 51, 1, '4', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 51),
(28, 51, 2, '4', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 52);

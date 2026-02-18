-- FUERZA AVANZADO 2 - DÍA 3 - SEMANA 8
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 38;

-- ============================================
-- CALENTAMIENTO (3 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(38, 25, 3, '3', 'calentamiento', 1),
(38, 27, 3, '20"', 'calentamiento', 2),
(38, 11, 3, '10', 'calentamiento', 3),
(38, 2, 3, '10', 'calentamiento', 4),
(38, 12, 3, '10', 'calentamiento', 5),
(38, 67, 3, '10', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=1-0-X-1
-- ============================================

-- A: SHOULDER PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(38, 41, 1, '1', 'RIR4 RPE6 - Tempo 2-0-X-1', 'principal', 10),
(38, 41, 1, '1', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 11),
(38, 41, 3, '1', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 12);

-- B: FRONT SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(38, 42, 1, '1', 'RIR4 RPE6 - Tempo 1-0-X-1', 'principal', 20),
(38, 42, 1, '1', 'RIR3 RPE7 - Tempo 1-0-X-1', 'principal', 21),
(38, 42, 3, '1', 'RIR2 RPE8 - Tempo 1-0-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-0-X-1, C=2-0-X-1
-- ============================================

-- A: ALTERNATING DUMBBELL FLOOR PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(38, 49, 1, '1', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(38, 49, 1, '1', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(38, 49, 2, '1', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: KB ONE ARM ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(38, 50, 1, '1', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 40),
(38, 50, 1, '1', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 41),
(38, 50, 2, '1', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 42);

-- C: KB RDL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(38, 51, 1, '1', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 50),
(38, 51, 1, '1', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 51),
(38, 51, 2, '1', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 52);

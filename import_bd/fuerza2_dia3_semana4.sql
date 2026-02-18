-- FUERZA AVANZADO 2 - DÍA 3 - SEMANA 4
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 39;

-- ============================================
-- CALENTAMIENTO (3 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(39, 16, 3, '20"', 'calentamiento', 1),
(39, 20, 3, '20"', 'calentamiento', 2),
(39, 17, 3, '10', 'calentamiento', 3),
(39, 18, 3, '10', 'calentamiento', 4),
(39, 19, 3, '10', 'calentamiento', 5),
(39, 9, 3, '15"', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: SHOULDER PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(39, 41, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 10),
(39, 41, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 11),
(39, 41, 2, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 12),
(39, 41, 1, '3', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 13);

-- B: FRONT SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(39, 42, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 20),
(39, 42, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 21),
(39, 42, 2, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 22),
(39, 42, 1, '3', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 23);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-0-X-1, C=2-0-X-1
-- ============================================

-- A: ALTERNATING DUMBBELL FLOOR PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(39, 49, 1, '5', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(39, 49, 1, '5', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(39, 49, 2, '5', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: KB ONE ARM ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(39, 50, 1, '5', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 40),
(39, 50, 1, '5', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 41),
(39, 50, 2, '5', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 42);

-- C: KB RDL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(39, 51, 1, '5', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 50),
(39, 51, 1, '5', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 51),
(39, 51, 2, '5', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 52);

-- FUERZA AVANZADO 2 - DÍA 3 - SEMANA 6
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 3;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(3, 26, 2, '30', 'calentamiento', 1),
(3, 1, 2, '20"', 'calentamiento', 2),
(3, 15, 2, '20"', 'calentamiento', 3),
(3, 3, 2, '10', 'calentamiento', 4),
(3, 4, 2, '30"', 'calentamiento', 5),
(3, 5, 2, '10', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=2-0-X-1
-- ============================================

-- A: SHOULDER PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(3, 41, 1, '3', 'RIR4 RPE6 - Tempo 2-0-X-1', 'principal', 10),
(3, 41, 1, '3', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 11),
(3, 41, 2, '3', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 12),
(3, 41, 1, '2', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 13);

-- B: FRONT SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(3, 42, 1, '3', 'RIR4 RPE6 - Tempo 2-0-X-1', 'principal', 20),
(3, 42, 1, '3', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 21),
(3, 42, 2, '3', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 22),
(3, 42, 1, '2', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 23);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-0-X-1, C=2-0-X-1
-- ============================================

-- A: ALTERNATING DUMBBELL FLOOR PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(3, 49, 1, '3', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(3, 49, 1, '3', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(3, 49, 2, '3', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: KB ONE ARM ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(3, 50, 1, '3', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 40),
(3, 50, 1, '3', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 41),
(3, 50, 2, '3', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 42);

-- C: KB RDL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(3, 51, 1, '3', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 50),
(3, 51, 1, '3', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 51),
(3, 51, 2, '3', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 52);

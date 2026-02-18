-- FUERZA AVANZADO 2 - DÍA 3 - SEMANA 3
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 10;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(10, 26, 2, '30', 'calentamiento', 1),
(10, 1, 2, '20"', 'calentamiento', 2),
(10, 15, 2, '20"', 'calentamiento', 3),
(10, 3, 2, '10', 'calentamiento', 4),
(10, 4, 2, '30"', 'calentamiento', 5),
(10, 5, 2, '10', 'calentamiento', 6),
(10, 67, 2, '10', 'calentamiento', 7);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: SHOULDER PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(10, 41, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 10),
(10, 41, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 11),
(10, 41, 3, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 12);

-- B: FRONT SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(10, 42, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 20),
(10, 42, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 21),
(10, 42, 3, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-0-X-1, C=2-0-X-1
-- ============================================

-- A: ALTERNATING DUMBBELL FLOOR PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(10, 49, 1, '6', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(10, 49, 1, '6', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(10, 49, 2, '6', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: KB ONE ARM ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(10, 50, 1, '6', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 40),
(10, 50, 1, '6', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 41),
(10, 50, 2, '6', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 42);

-- C: KB RDL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(10, 51, 1, '6', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 50),
(10, 51, 1, '6', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 51),
(10, 51, 2, '6', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 52);

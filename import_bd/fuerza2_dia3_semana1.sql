-- FUERZA AVANZADO 2 - DÍA 3 - SEMANA 1
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 43;

-- ============================================
-- CALENTAMIENTO (3 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(43, 16, 3, '20"', 'calentamiento', 1),
(43, 20, 3, '20"', 'calentamiento', 2),
(43, 17, 3, '10', 'calentamiento', 3),
(43, 18, 3, '10', 'calentamiento', 4),
(43, 19, 3, '10', 'calentamiento', 5),
(43, 9, 3, '15"', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=3-1-X-1, B=3-1-X-1
-- ============================================

-- A: SHOULDER PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(43, 41, 1, '5', 'RIR4 RPE6 - Tempo 3-1-X-1', 'principal', 10),
(43, 41, 1, '5', 'RIR3 RPE7 - Tempo 3-1-X-1', 'principal', 11),
(43, 41, 3, '5', 'RIR2 RPE8 - Tempo 3-1-X-1', 'principal', 12);

-- B: FRONT SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(43, 42, 1, '5', 'RIR4 RPE6 - Tempo 3-1-X-1', 'principal', 20),
(43, 42, 1, '5', 'RIR3 RPE7 - Tempo 3-1-X-1', 'principal', 21),
(43, 42, 3, '5', 'RIR2 RPE8 - Tempo 3-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-0-X-1, C=2-0-X-1
-- ============================================

-- A: ALTERNATING DUMBBELL FLOOR PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(43, 49, 1, '8', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(43, 49, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(43, 49, 2, '8', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: KB ONE ARM ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(43, 50, 1, '8', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 40),
(43, 50, 1, '8', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 41),
(43, 50, 2, '8', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 42);

-- C: KB RDL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(43, 51, 1, '8', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 50),
(43, 51, 1, '8', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 51),
(43, 51, 2, '8', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 52);

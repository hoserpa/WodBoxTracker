-- FUERZA AVANZADO 2 - DÍA 3 - SEMANA 7
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 20;

-- ============================================
-- CALENTAMIENTO (3 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(20, 16, 3, '20"', 'calentamiento', 1),
(20, 20, 3, '20"', 'calentamiento', 2),
(20, 17, 3, '10', 'calentamiento', 3),
(20, 18, 3, '10', 'calentamiento', 4),
(20, 19, 3, '10', 'calentamiento', 5),
(20, 9, 3, '15"', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=1-0-X-1
-- ============================================

-- A: SHOULDER PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(20, 41, 1, '2', 'RIR4 RPE6 - Tempo 2-0-X-1', 'principal', 10),
(20, 41, 1, '2', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 11),
(20, 41, 3, '2', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 12);

-- B: FRONT SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(20, 42, 1, '2', 'RIR4 RPE6 - Tempo 1-0-X-1', 'principal', 20),
(20, 42, 1, '2', 'RIR3 RPE7 - Tempo 1-0-X-1', 'principal', 21),
(20, 42, 3, '2', 'RIR2 RPE8 - Tempo 1-0-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-0-X-1, C=2-0-X-1
-- ============================================

-- A: ALTERNATING DUMBBELL FLOOR PRESS
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(20, 49, 1, '2', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(20, 49, 1, '2', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(20, 49, 2, '2', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: KB ONE ARM ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(20, 50, 1, '2', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 40),
(20, 50, 1, '2', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 41),
(20, 50, 2, '2', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 42);

-- C: KB RDL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(20, 51, 1, '2', 'RIR4 RPE6 - Tempo 2-0-X-1', 'secundario', 50),
(20, 51, 1, '2', 'RIR3 RPE7 - Tempo 2-0-X-1', 'secundario', 51),
(20, 51, 2, '2', 'RIR2 RPE8 - Tempo 2-0-X-1', 'secundario', 52);

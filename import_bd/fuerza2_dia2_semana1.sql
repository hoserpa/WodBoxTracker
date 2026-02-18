-- FUERZA AVANZADO 2 - DÍA 2 - SEMANA 1
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 17;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(17, 16, 2, '20"', 'calentamiento', 1),
(17, 2, 2, '5', 'calentamiento', 2),
(17, 17, 2, '10', 'calentamiento', 3),
(17, 18, 2, '10', 'calentamiento', 4),
(17, 19, 2, '10', 'calentamiento', 5);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=3-1-X-1, B=3-1-X-1
-- ============================================

-- A: DL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(17, 40, 1, '5', 'RIR4 RPE6 - Tempo 3-1-X-1', 'principal', 10),
(17, 40, 1, '5', 'RIR3 RPE7 - Tempo 3-1-X-1', 'principal', 11),
(17, 40, 3, '5', 'RIR2 RPE8 - Tempo 3-1-X-1', 'principal', 12);

-- B: PRESS DE BANCA
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(17, 39, 1, '5', 'RIR4 RPE6 - Tempo 3-1-X-1', 'principal', 20),
(17, 39, 1, '5', 'RIR3 RPE7 - Tempo 3-1-X-1', 'principal', 21),
(17, 39, 3, '5', 'RIR2 RPE8 - Tempo 3-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1, C=2-1-X-1
-- ============================================

-- A: BULGARIAN SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(17, 47, 1, '8', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(17, 47, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(17, 47, 2, '8', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: BAR ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(17, 19, 1, '8', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(17, 19, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(17, 19, 2, '8', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: CURL DE BICEP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(17, 48, 1, '8', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 50),
(17, 48, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 51),
(17, 48, 2, '8', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 52);

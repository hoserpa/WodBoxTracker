-- FUERZA AVANZADO 2 - DÍA 2 - SEMANA 4
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 21;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(21, 16, 2, '20"', 'calentamiento', 1),
(21, 2, 2, '5', 'calentamiento', 2),
(21, 17, 2, '10', 'calentamiento', 3),
(21, 18, 2, '10', 'calentamiento', 4),
(21, 19, 2, '10', 'calentamiento', 5);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: DL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(21, 40, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 10),
(21, 40, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 11),
(21, 40, 2, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 12),
(21, 40, 1, '3', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 13);

-- B: PRESS DE BANCA
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(21, 39, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 20),
(21, 39, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 21),
(21, 39, 2, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 22),
(21, 39, 1, '3', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 23);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1, C=2-1-X-1
-- ============================================

-- A: BULGARIAN SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(21, 47, 1, '5', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(21, 47, 1, '5', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(21, 47, 2, '5', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: BAR ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(21, 19, 1, '5', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(21, 19, 1, '5', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(21, 19, 2, '5', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: CURL DE BICEP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(21, 48, 1, '5', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 50),
(21, 48, 1, '5', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 51),
(21, 48, 2, '5', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 52);

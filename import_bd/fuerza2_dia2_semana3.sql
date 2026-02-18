-- FUERZA AVANZADO 2 - DÍA 2 - SEMANA 3
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 37;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(37, 21, 2, '20"', 'calentamiento', 1),
(37, 22, 2, '20"', 'calentamiento', 2),
(37, 23, 2, '10', 'calentamiento', 3),
(37, 19, 2, '10', 'calentamiento', 4),
(37, 24, 2, '10', 'calentamiento', 5);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1, B=2-1-X-1
-- ============================================

-- A: DL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(37, 40, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 10),
(37, 40, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 11),
(37, 40, 3, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 12);

-- B: PRESS DE BANCA
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(37, 39, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'principal', 20),
(37, 39, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 21),
(37, 39, 3, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1, C=2-1-X-1
-- ============================================

-- A: BULGARIAN SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(37, 47, 1, '6', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(37, 47, 1, '6', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(37, 47, 2, '6', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: BAR ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(37, 19, 1, '6', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(37, 19, 1, '6', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(37, 19, 2, '6', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: CURL DE BICEP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(37, 48, 1, '6', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 50),
(37, 48, 1, '6', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 51),
(37, 48, 2, '6', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 52);

-- FUERZA AVANZADO 2 - DÍA 2 - SEMANA 5
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 5;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(5, 16, 2, '20"', 'calentamiento', 1),
(5, 20, 2, '20"', 'calentamiento', 2),
(5, 17, 2, '10', 'calentamiento', 3),
(5, 18, 2, '10', 'calentamiento', 4),
(5, 19, 2, '10', 'calentamiento', 5),
(5, 9, 2, '15"', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=2-0-X-1
-- ============================================

-- A: DL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(5, 40, 1, '3', 'RIR4 RPE6 - Tempo 2-0-X-1', 'principal', 10),
(5, 40, 1, '3', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 11),
(5, 40, 3, '3', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 12);

-- B: PRESS DE BANCA
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(5, 39, 1, '3', 'RIR4 RPE6 - Tempo 2-0-X-1', 'principal', 20),
(5, 39, 1, '3', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 21),
(5, 39, 3, '3', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1, C=2-1-X-1
-- ============================================

-- A: BULGARIAN SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(5, 47, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(5, 47, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(5, 47, 2, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: BAR ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(5, 19, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(5, 19, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(5, 19, 2, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: CURL DE BICEP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(5, 48, 1, '4', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 50),
(5, 48, 1, '4', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 51),
(5, 48, 2, '4', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 52);

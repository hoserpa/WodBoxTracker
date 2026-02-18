-- FUERZA AVANZADO 2 - DÍA 2 - SEMANA 6
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 30;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(30, 25, 2, '3', 'calentamiento', 1),
(30, 21, 2, '20"', 'calentamiento', 2),
(30, 22, 2, '20"', 'calentamiento', 3),
(30, 23, 2, '10', 'calentamiento', 4),
(30, 19, 2, '10', 'calentamiento', 5),
(30, 24, 2, '10', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-0-X-1, B=2-0-X-1
-- ============================================

-- A: DL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(30, 40, 1, '3', 'RIR4 RPE6 - Tempo 2-0-X-1', 'principal', 10),
(30, 40, 1, '3', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 11),
(30, 40, 2, '3', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 12),
(30, 40, 1, '2', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 13);

-- B: PRESS DE BANCA
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(30, 39, 1, '3', 'RIR4 RPE6 - Tempo 2-0-X-1', 'principal', 20),
(30, 39, 1, '3', 'RIR3 RPE7 - Tempo 2-0-X-1', 'principal', 21),
(30, 39, 2, '3', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 22),
(30, 39, 1, '2', 'RIR2 RPE8 - Tempo 2-0-X-1', 'principal', 23);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1, C=2-1-X-1
-- ============================================

-- A: BULGARIAN SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(30, 47, 1, '3', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(30, 47, 1, '3', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(30, 47, 2, '3', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: BAR ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(30, 19, 1, '3', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(30, 19, 1, '3', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(30, 19, 2, '3', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: CURL DE BICEP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(30, 48, 1, '3', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 50),
(30, 48, 1, '3', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 51),
(30, 48, 2, '3', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 52);

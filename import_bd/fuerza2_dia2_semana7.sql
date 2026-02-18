-- FUERZA AVANZADO 2 - DÍA 2 - SEMANA 7
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 41;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(41, 16, 2, '20"', 'calentamiento', 1),
(41, 2, 2, '5', 'calentamiento', 2),
(41, 17, 2, '10', 'calentamiento', 3),
(41, 18, 2, '10', 'calentamiento', 4),
(41, 19, 2, '10', 'calentamiento', 5);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=1-0-X-1, B=1-0-X-1
-- ============================================

-- A: DL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(41, 40, 1, '2', 'RIR4 RPE6 - Tempo 1-0-X-1', 'principal', 10),
(41, 40, 1, '2', 'RIR3 RPE7 - Tempo 1-0-X-1', 'principal', 11),
(41, 40, 3, '2', 'RIR2 RPE8 - Tempo 1-0-X-1', 'principal', 12);

-- B: PRESS DE BANCA
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(41, 39, 1, '2', 'RIR4 RPE6 - Tempo 1-0-X-1', 'principal', 20),
(41, 39, 1, '2', 'RIR3 RPE7 - Tempo 1-0-X-1', 'principal', 21),
(41, 39, 3, '2', 'RIR2 RPE8 - Tempo 1-0-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1, C=2-1-X-1
-- ============================================

-- A: BULGARIAN SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(41, 47, 1, '2', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(41, 47, 1, '2', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(41, 47, 2, '2', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: BAR ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(41, 19, 1, '2', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(41, 19, 1, '2', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(41, 19, 2, '2', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: CURL DE BICEP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(41, 48, 1, '2', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 50),
(41, 48, 1, '2', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 51),
(41, 48, 2, '2', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 52);

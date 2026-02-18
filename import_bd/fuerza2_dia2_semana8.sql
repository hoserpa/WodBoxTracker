-- FUERZA AVANZADO 2 - DÍA 2 - SEMANA 8
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 9;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(9, 16, 2, '20"', 'calentamiento', 1),
(9, 20, 2, '20"', 'calentamiento', 2),
(9, 17, 2, '10', 'calentamiento', 3),
(9, 18, 2, '10', 'calentamiento', 4),
(9, 19, 2, '10', 'calentamiento', 5),
(9, 9, 2, '15"', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=1-0-X-1, B=1-0-X-1
-- ============================================

-- A: DL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(9, 40, 1, '1', 'RIR4 RPE6 - Tempo 1-0-X-1', 'principal', 10),
(9, 40, 1, '1', 'RIR3 RPE7 - Tempo 1-0-X-1', 'principal', 11),
(9, 40, 3, '1', 'RIR2 RPE8 - Tempo 1-0-X-1', 'principal', 12);

-- B: PRESS DE BANCA
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(9, 39, 1, '1', 'RIR4 RPE6 - Tempo 1-0-X-1', 'principal', 20),
(9, 39, 1, '1', 'RIR3 RPE7 - Tempo 1-0-X-1', 'principal', 21),
(9, 39, 3, '1', 'RIR2 RPE8 - Tempo 1-0-X-1', 'principal', 22);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1, C=2-1-X-1
-- ============================================

-- A: BULGARIAN SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(9, 47, 1, '1', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(9, 47, 1, '1', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(9, 47, 2, '1', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: BAR ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(9, 19, 1, '1', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(9, 19, 1, '1', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(9, 19, 2, '1', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: CURL DE BICEP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(9, 48, 1, '1', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 50),
(9, 48, 1, '1', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 51),
(9, 48, 2, '1', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 52);

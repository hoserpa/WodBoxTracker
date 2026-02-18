-- FUERZA AVANZADO 2 - DÍA 2 - SEMANA 2
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 36;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(36, 16, 2, '20"', 'calentamiento', 1),
(36, 20, 2, '20"', 'calentamiento', 2),
(36, 17, 2, '10', 'calentamiento', 3),
(36, 18, 2, '10', 'calentamiento', 4),
(36, 19, 2, '10', 'calentamiento', 5),
(36, 9, 2, '15"', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=3-1-X-1, B=3-1-X-1
-- ============================================

-- A: DL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(36, 40, 1, '5', 'RIR4 RPE6 - Tempo 3-1-X-1', 'principal', 10),
(36, 40, 1, '5', 'RIR3 RPE7 - Tempo 3-1-X-1', 'principal', 11),
(36, 40, 2, '5', 'RIR2 RPE8 - Tempo 3-1-X-1', 'principal', 12),
(36, 40, 1, '4', 'RIR2 RPE8 - Tempo 3-1-X-1', 'principal', 13);

-- B: PRESS DE BANCA
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(36, 39, 1, '5', 'RIR4 RPE6 - Tempo 3-1-X-1', 'principal', 20),
(36, 39, 1, '5', 'RIR3 RPE7 - Tempo 3-1-X-1', 'principal', 21),
(36, 39, 2, '5', 'RIR2 RPE8 - Tempo 3-1-X-1', 'principal', 22),
(36, 39, 1, '4', 'RIR2 RPE8 - Tempo 3-1-X-1', 'principal', 23);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=2-1-X-1, C=2-1-X-1
-- ============================================

-- A: BULGARIAN SQUAT
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(36, 47, 1, '7', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 30),
(36, 47, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 31),
(36, 47, 2, '7', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 32);

-- B: BAR ROW
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(36, 19, 1, '7', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 40),
(36, 19, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 41),
(36, 19, 2, '7', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 42);

-- C: CURL DE BICEP
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(36, 48, 1, '7', 'RIR4 RPE6 - Tempo 2-1-X-1', 'secundario', 50),
(36, 48, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 51),
(36, 48, 2, '7', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 52);

-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 3 - SEMANA 8
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 23;

-- ============================================
-- CALENTAMIENTO (3 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(23, 33, 3, '10', 'calentamiento', 1),
(23, 18, 3, '10', 'calentamiento', 2),
(23, 34, 3, '10', 'calentamiento', 3),
(23, 35, 3, '10', 'calentamiento', 4),
(23, 36, 3, '10', 'calentamiento', 5);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1
-- ============================================

-- A: DL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(23, 40, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 10),
(23, 40, 1, '7', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 11),
(23, 40, 3, '7', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 12);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=1-1-X-0, C=2-1-X-1
-- ============================================

-- A: CURL DE BICEP MARTILLO
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(23, 57, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 30),
(23, 57, 1, '7', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 31),
(23, 57, 3, '7', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 32);

-- B: DB LATERAL RISE
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(23, 58, 1, '7', 'RIR3 RPE7 - Tempo 1-1-X-0', 'secundario', 40),
(23, 58, 1, '7', 'RIR2 RPE8 - Tempo 1-1-X-0', 'secundario', 41),
(23, 58, 3, '7', 'RIR1 RPE9 - Tempo 1-1-X-0', 'secundario', 42);

-- C: DB FRONT SHOULDER
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(23, 59, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 50),
(23, 59, 1, '7', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 51),
(23, 59, 3, '7', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(23, 64, 4, '20', 'core', 60),
(23, 66, 4, '10', 'core', 61);

-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 3 - SEMANA 7
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 1;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(1, 28, 2, '20"', 'calentamiento', 1),
(1, 29, 2, '20"', 'calentamiento', 2),
(1, 32, 2, '20"', 'calentamiento', 3),
(1, 2, 2, '10', 'calentamiento', 4),
(1, 51, 2, '10', 'calentamiento', 5),
(1, 19, 2, '10', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1
-- ============================================

-- A: DL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(1, 40, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 10),
(1, 40, 2, '7', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 11),
(1, 40, 2, '7', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 12);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=1-1-X-0, C=2-1-X-1
-- ============================================

-- A: CURL DE BICEP MARTILLO
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(1, 57, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 30),
(1, 57, 2, '7', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 31),
(1, 57, 2, '7', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 32);

-- B: DB LATERAL RISE
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(1, 58, 1, '7', 'RIR3 RPE7 - Tempo 1-1-X-0', 'secundario', 40),
(1, 58, 2, '7', 'RIR2 RPE8 - Tempo 1-1-X-0', 'secundario', 41),
(1, 58, 2, '7', 'RIR1 RPE9 - Tempo 1-1-X-0', 'secundario', 42);

-- C: DB FRONT SHOULDER
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(1, 59, 1, '7', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 50),
(1, 59, 2, '7', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 51),
(1, 59, 2, '7', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(1, 64, 4, '20', 'core', 60),
(1, 66, 4, '10', 'core', 61);

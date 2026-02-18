-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 3 - SEMANA 4
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 34;

-- ============================================
-- CALENTAMIENTO (3 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(34, 33, 3, '10', 'calentamiento', 1),
(34, 18, 3, '10', 'calentamiento', 2),
(34, 34, 3, '10', 'calentamiento', 3),
(34, 35, 3, '10', 'calentamiento', 4),
(34, 36, 3, '10+10', 'calentamiento', 5);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1
-- ============================================

-- A: DL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(34, 40, 1, '9', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 10),
(34, 40, 1, '9', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 11),
(34, 40, 3, '9', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 12);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=1-1-X-0, C=2-1-X-1
-- ============================================

-- A: CURL DE BICEP MARTILLO
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(34, 57, 1, '9', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 30),
(34, 57, 1, '9', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 31),
(34, 57, 3, '9', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 32);

-- B: DB LATERAL RISE
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(34, 58, 1, '9', 'RIR3 RPE7 - Tempo 1-1-X-0', 'secundario', 40),
(34, 58, 1, '9', 'RIR2 RPE8 - Tempo 1-1-X-0', 'secundario', 41),
(34, 58, 3, '9', 'RIR1 RPE9 - Tempo 1-1-X-0', 'secundario', 42);

-- C: DB FRONT SHOULDER
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(34, 59, 1, '9', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 50),
(34, 59, 1, '9', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 51),
(34, 59, 3, '9', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(34, 64, 4, '20', 'Pausa 1" - Tempo 4-1-X-0', 'core', 60),
(34, 65, 4, '10', 'Tempo 3-0-X-2 - RPE8', 'core', 61);

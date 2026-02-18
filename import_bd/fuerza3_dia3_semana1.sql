-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 3 - SEMANA 1
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 11;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(11, 28, 2, '20"', 'calentamiento', 1),
(11, 29, 2, '20"', 'calentamiento', 2),
(11, 32, 2, '20"', 'calentamiento', 3),
(11, 2, 2, '10', 'calentamiento', 4),
(11, 51, 2, '10', 'calentamiento', 5),
(11, 19, 2, '10', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1
-- ============================================

-- A: DL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(11, 40, 1, '14', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 10),
(11, 40, 2, '14', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 11),
(11, 40, 1, '14', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 12);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=1-1-X-0, C=2-1-X-1
-- ============================================

-- A: CURL DE BICEP MARTILLO
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(11, 57, 1, '14', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 30),
(11, 57, 2, '14', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 31),
(11, 57, 1, '14', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 32);

-- B: DB LATERAL RISE
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(11, 58, 1, '14', 'RIR3 RPE7 - Tempo 1-1-X-0', 'secundario', 40),
(11, 58, 2, '14', 'RIR2 RPE8 - Tempo 1-1-X-0', 'secundario', 41),
(11, 58, 1, '14', 'RIR1 RPE9 - Tempo 1-1-X-0', 'secundario', 42);

-- C: DB FRONT SHOULDER
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(11, 59, 1, '14', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 50),
(11, 59, 2, '14', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 51),
(11, 59, 1, '14', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(11, 64, 4, '20', 'Pausa 1" - Tempo 4-1-X-0', 'core', 60),
(11, 65, 4, '10', 'Tempo 3-0-X-2 - RPE6', 'core', 61);

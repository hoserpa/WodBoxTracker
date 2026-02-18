-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 3 - SEMANA 6
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 27;

-- ============================================
-- CALENTAMIENTO (3 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(27, 33, 3, '10', 'calentamiento', 1),
(27, 18, 3, '10', 'calentamiento', 2),
(27, 34, 3, '10', 'calentamiento', 3),
(27, 35, 3, '10', 'calentamiento', 4),
(27, 36, 3, '10+10', 'calentamiento', 5);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1
-- ============================================

-- A: DL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(27, 40, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 10),
(27, 40, 1, '8', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 11),
(27, 40, 3, '8', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 12);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=1-1-X-0, C=2-1-X-1
-- ============================================

-- A: CURL DE BICEP MARTILLO
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(27, 57, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 30),
(27, 57, 1, '8', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 31),
(27, 57, 3, '8', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 32);

-- B: DB LATERAL RISE
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(27, 58, 1, '8', 'RIR3 RPE7 - Tempo 1-1-X-0', 'secundario', 40),
(27, 58, 1, '8', 'RIR2 RPE8 - Tempo 1-1-X-0', 'secundario', 41),
(27, 58, 3, '8', 'RIR1 RPE9 - Tempo 1-1-X-0', 'secundario', 42);

-- C: DB FRONT SHOULDER
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(27, 59, 1, '8', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 50),
(27, 59, 1, '8', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 51),
(27, 59, 3, '8', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(27, 64, 4, '20', 'Pausa 1" - Tempo 4-1-X-0', 'core', 60),
(27, 66, 4, '10', 'Tempo 3-0-X-2 - RPE7', 'core', 61);

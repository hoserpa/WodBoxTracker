-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 3 - SEMANA 2
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 29;

-- ============================================
-- CALENTAMIENTO (3 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(29, 33, 3, '10', 'calentamiento', 1),
(29, 18, 3, '10', 'calentamiento', 2),
(29, 34, 3, '10', 'calentamiento', 3),
(29, 35, 3, '10', 'calentamiento', 4),
(29, 36, 3, '10+10', 'calentamiento', 5);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1
-- ============================================

-- A: DL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(29, 40, 1, '12', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 10),
(29, 40, 2, '12', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 11),
(29, 40, 2, '12', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 12);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=1-1-X-0, C=2-1-X-1
-- ============================================

-- A: CURL DE BICEP MARTILLO
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(29, 57, 1, '12', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 30),
(29, 57, 2, '12', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 31),
(29, 57, 2, '12', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 32);

-- B: DB LATERAL RISE
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(29, 58, 1, '12', 'RIR3 RPE7 - Tempo 1-1-X-0', 'secundario', 40),
(29, 58, 2, '12', 'RIR2 RPE8 - Tempo 1-1-X-0', 'secundario', 41),
(29, 58, 2, '12', 'RIR1 RPE9 - Tempo 1-1-X-0', 'secundario', 42);

-- C: DB FRONT SHOULDER
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(29, 59, 1, '12', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 50),
(29, 59, 2, '12', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 51),
(29, 59, 2, '12', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(29, 64, 4, '20', 'Pausa 1" - Tempo 4-1-X-0', 'core', 60),
(29, 65, 4, '10', 'Tempo 3-0-X-2 - RPE7', 'core', 61);

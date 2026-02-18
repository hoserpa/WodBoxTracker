-- FUERZA AVANZADO 3 HIPERTROFIA - DÍA 3 - SEMANA 3
-- Limpiar series existentes para este día
DELETE FROM series WHERE dia_id = 45;

-- ============================================
-- CALENTAMIENTO (2 RONDAS)
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, tipo_ejercicio, orden) VALUES
(45, 28, 2, '20"', 'calentamiento', 1),
(45, 29, 2, '20"', 'calentamiento', 2),
(45, 32, 2, '20"', 'calentamiento', 3),
(45, 2, 2, '10', 'calentamiento', 4),
(45, 51, 2, '10', 'calentamiento', 5),
(45, 19, 2, '10', 'calentamiento', 6);

-- ============================================
-- EJERCICIOS PRINCIPALES
-- TEMPO: A=2-1-X-1
-- ============================================

-- A: DL
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(45, 40, 1, '10', 'RIR3 RPE7 - Tempo 2-1-X-1', 'principal', 10),
(45, 40, 1, '10', 'RIR2 RPE8 - Tempo 2-1-X-1', 'principal', 11),
(45, 40, 3, '10', 'RIR1 RPE9 - Tempo 2-1-X-1', 'principal', 12);

-- ============================================
-- EJERCICIOS SECUNDARIOS
-- TEMPO: A=2-1-X-1, B=1-1-X-0, C=2-1-X-1
-- ============================================

-- A: CURL DE BICEP MARTILLO
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(45, 57, 1, '10', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 30),
(45, 57, 1, '10', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 31),
(45, 57, 3, '10', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 32);

-- B: DB LATERAL RISE
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(45, 58, 1, '10', 'RIR3 RPE7 - Tempo 1-1-X-0', 'secundario', 40),
(45, 58, 1, '10', 'RIR2 RPE8 - Tempo 1-1-X-0', 'secundario', 41),
(45, 58, 3, '10', 'RIR1 RPE9 - Tempo 1-1-X-0', 'secundario', 42);

-- C: DB FRONT SHOULDER
INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(45, 59, 1, '10', 'RIR3 RPE7 - Tempo 2-1-X-1', 'secundario', 50),
(45, 59, 1, '10', 'RIR2 RPE8 - Tempo 2-1-X-1', 'secundario', 51),
(45, 59, 3, '10', 'RIR1 RPE9 - Tempo 2-1-X-1', 'secundario', 52);

-- ============================================
-- CORE
-- ============================================

INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
(45, 64, 4, '20', 'Pausa 1" - Tempo 4-1-X-0', 'core', 60),
(45, 65, 4, '10', 'Tempo 3-0-X-2 - RPE8', 'core', 61);

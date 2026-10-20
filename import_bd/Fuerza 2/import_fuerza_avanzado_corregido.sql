-- =====================================================================
-- REQUISITO: ejecutar antes 01_tipo_pliometria.sql (y esperar a que termine).
-- Importacion: FUERZA AVANZADO (Box Bulls Factory) - 8 semanas x 3 dias
-- =====================================================================

CREATE OR REPLACE FUNCTION pg_temp.get_ej(p_nombre TEXT, p_tipo TEXT, p_user UUID)
RETURNS INTEGER LANGUAGE plpgsql AS $f$
DECLARE v_id INTEGER;
BEGIN
  SELECT id INTO v_id FROM ejercicios
   WHERE LOWER(nombre) = LOWER(p_nombre) AND (user_id IS NULL OR user_id = p_user)
   ORDER BY user_id NULLS FIRST LIMIT 1;
  IF v_id IS NULL THEN
    INSERT INTO ejercicios (nombre, tipo_id, user_id)
    VALUES (p_nombre, (SELECT id FROM tipos_ejercicio WHERE nombre = p_tipo), p_user)
    RETURNING id INTO v_id;
  END IF;
  RETURN v_id;
END $f$;

DO $import$
DECLARE
  v_user    UUID := 'afd7ff93-ab16-4f5f-9b33-425a4078814c';  -- <<< CAMBIAR
  v_rutina  INTEGER;
  v_semana  INTEGER;
  v_dia     INTEGER;
BEGIN
  INSERT INTO rutinas (nombre, descripcion, user_id)
  VALUES ('FUERZA AVANZADO - BOX BULLS FACTORY',
          'Rutina de fuerza avanzada - 8 semanas, 3 dias por semana, SIN ejercicios core. Importada desde PDF',
          v_user)
  RETURNING id INTO v_rutina;

  -- ================= SEMANA 1 =================
  INSERT INTO semanas (rutina_id, numero) VALUES (v_rutina, 1) RETURNING id INTO v_semana;

  -- Semana 1 / Día 1
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 1, 'Día 1') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('SPIDERMAN', 'calentamiento', v_user), 2, '5+5', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KB HIP OPENER', 'calentamiento', v_user), 2, '10+10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('SCAPULAR PUSH UP', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('SHOULDER BOX STRETCH', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 6),
    (v_dia, pg_temp.get_ej('DEPTH DROP-STICK', 'pliometria', v_user), 3, '3+3', NULL, 'pliometria', 7),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 3, '4', NULL, 'pliometria', 8),
    (v_dia, pg_temp.get_ej('BACK SQUAT', 'principal', v_user), 5, '5', 'Tempo 2-1-X-1 | RPE6 x2, RPE7 x2, RPE8 x1 | + BOX JUMP | + CONTRASTE 5', 'principal', 9),
    (v_dia, pg_temp.get_ej('BOX JUMP', 'pliometria', v_user), 1, '5', 'Contraste', 'pliometria', 10),
    (v_dia, pg_temp.get_ej('PRESS DE BANCA', 'principal', v_user), 5, '5', 'Tempo 2-1-X-1 | RPE6 x2, RPE7 x2, RPE8 x1 | + BAND ASSISTED PUSH UP | + CONTRASTE 5', 'principal', 11),
    (v_dia, pg_temp.get_ej('BAND ASSISTED PUSH UP', 'calentamiento', v_user), 1, '5', 'Contraste', 'calentamiento', 12),
    (v_dia, pg_temp.get_ej('BULGARIAN SQUAT', 'secundario', v_user), 3, '8', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 13),
    (v_dia, pg_temp.get_ej('PARALELE DIP', 'secundario', v_user), 3, '8', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 14);

  -- Semana 1 / Día 2
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 2, 'Día 2') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('CAT CAMEL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('KB RDL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('BAR ROW', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 6),
    (v_dia, pg_temp.get_ej('DEPTH DROP-STICK', 'pliometria', v_user), 3, '3+3', NULL, 'pliometria', 7),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 3, '4', NULL, 'pliometria', 8),
    (v_dia, pg_temp.get_ej('DL', 'principal', v_user), 5, '5', 'Tempo 2-1-X-1 | RPE6 x2, RPE7 x2, RPE8 x1 | + KB SWING + BROAD JUMP | + CONTRASTE 5 + CONTRASTE 3', 'principal', 9),
    (v_dia, pg_temp.get_ej('KB SWING RUSO', 'calentamiento', v_user), 1, '5', 'Contraste', 'calentamiento', 10),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 1, '3', 'Contraste', 'pliometria', 11),
    (v_dia, pg_temp.get_ej('PULL UP', 'principal', v_user), 4, '8', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 12),
    (v_dia, pg_temp.get_ej('BAR ROW', 'secundario', v_user), 3, '8', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 13),
    (v_dia, pg_temp.get_ej('ONE LEG ISQUIO SLIDER ECCENTRIC', 'secundario', v_user), 3, '5', 'Tempo 3-0-X-1 | X2', 'secundario', 14);

  -- Semana 1 / Día 3
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 3, 'Día 3') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('PIRIFORMIS STRETCH FOR HIPS & BUTT', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KNEELING HIP FLEXOR STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('AIR SQUAT', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('FRONT RACK MOBILITY', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 6),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 7),
    (v_dia, pg_temp.get_ej('DEPTH DROP-STICK', 'pliometria', v_user), 3, '3+3', NULL, 'pliometria', 8),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 3, '4', NULL, 'pliometria', 9),
    (v_dia, pg_temp.get_ej('FRONT SQUAT', 'principal', v_user), 5, '5', 'Tempo 2-1-X-1 | RPE6 x2, RPE7 x2, RPE8 x1 | + W.BALL | + CONTRASTE 5', 'principal', 10),
    (v_dia, pg_temp.get_ej('W.BALL', 'pliometria', v_user), 1, '5', 'Contraste', 'pliometria', 11),
    (v_dia, pg_temp.get_ej('DB SHOULDER PRESS', 'principal', v_user), 4, '8', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 12),
    (v_dia, pg_temp.get_ej('DL SUMO', 'secundario', v_user), 3, '8', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 13),
    (v_dia, pg_temp.get_ej('DB LATERAL RISE', 'secundario', v_user), 3, '8', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 14);

  -- ================= SEMANA 2 =================
  INSERT INTO semanas (rutina_id, numero) VALUES (v_rutina, 2) RETURNING id INTO v_semana;
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 1, 'Día 1') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('SPIDERMAN', 'calentamiento', v_user), 2, '5+5', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KB HIP OPENER', 'calentamiento', v_user), 2, '10+10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('SCAPULAR PUSH UP', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('SHOULDER BOX STRETCH', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 6),
    (v_dia, pg_temp.get_ej('DEPTH DROP-STICK', 'pliometria', v_user), 3, '3+3', NULL, 'pliometria', 7),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 3, '4', NULL, 'pliometria', 8),
    (v_dia, pg_temp.get_ej('BACK SQUAT', 'principal', v_user), 5, '5', 'Tempo 2-1-X-1 | RPE6 x1, RPE7 x2, RPE8 x2 | + BOX JUMP | + CONTRASTE 5', 'principal', 9),
    (v_dia, pg_temp.get_ej('BOX JUMP', 'pliometria', v_user), 1, '5', 'Contraste', 'pliometria', 10),
    (v_dia, pg_temp.get_ej('PRESS DE BANCA', 'principal', v_user), 5, '5', 'Tempo 2-1-X-1 | RPE6 x1, RPE7 x2, RPE8 x2 | + BAND ASSISTED PUSH UP | + CONTRASTE 5', 'principal', 11),
    (v_dia, pg_temp.get_ej('BAND ASSISTED PUSH UP', 'calentamiento', v_user), 1, '5', 'Contraste', 'calentamiento', 12),
    (v_dia, pg_temp.get_ej('BULGARIAN SQUAT', 'secundario', v_user), 3, '7', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 13),
    (v_dia, pg_temp.get_ej('PARALELE DIP', 'secundario', v_user), 3, '7', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 14);
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 2, 'Día 2') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('CAT CAMEL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('KB RDL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('BAR ROW', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 6),
    (v_dia, pg_temp.get_ej('DEPTH DROP-STICK', 'pliometria', v_user), 3, '3+3', NULL, 'pliometria', 7),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 3, '4', NULL, 'pliometria', 8),
    (v_dia, pg_temp.get_ej('DL', 'principal', v_user), 5, '5', 'Tempo 2-1-X-1 | RPE6 x1, RPE7 x2, RPE8 x2 | + KB SWING + BROAD JUMP | + CONTRASTE 5 + CONTRASTE 3', 'principal', 9),
    (v_dia, pg_temp.get_ej('KB SWING RUSO', 'calentamiento', v_user), 1, '5', 'Contraste', 'calentamiento', 10),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 1, '3', 'Contraste', 'pliometria', 11),
    (v_dia, pg_temp.get_ej('PULL UP', 'principal', v_user), 4, '7', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 12),
    (v_dia, pg_temp.get_ej('BAR ROW', 'secundario', v_user), 3, '7', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 13),
    (v_dia, pg_temp.get_ej('ONE LEG ISQUIO SLIDER ECCENTRIC', 'secundario', v_user), 3, '5', 'Tempo 3-0-X-1 | X2', 'secundario', 14);
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 3, 'Día 3') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('PIRIFORMIS STRETCH FOR HIPS & BUTT', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KNEELING HIP FLEXOR STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('AIR SQUAT', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('FRONT RACK MOBILITY', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 6),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 7),
    (v_dia, pg_temp.get_ej('DEPTH DROP-STICK', 'pliometria', v_user), 3, '3+3', NULL, 'pliometria', 8),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 3, '4', NULL, 'pliometria', 9),
    (v_dia, pg_temp.get_ej('FRONT SQUAT', 'principal', v_user), 5, '5', 'Tempo 2-1-X-1 | RPE6 x1, RPE7 x2, RPE8 x2 | + W.BALL | + CONTRASTE 5', 'principal', 10),
    (v_dia, pg_temp.get_ej('W.BALL', 'pliometria', v_user), 1, '5', 'Contraste', 'pliometria', 11),
    (v_dia, pg_temp.get_ej('DB SHOULDER PRESS', 'principal', v_user), 4, '7', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 12),
    (v_dia, pg_temp.get_ej('DL SUMO', 'secundario', v_user), 3, '7', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 13),
    (v_dia, pg_temp.get_ej('DB LATERAL RISE', 'secundario', v_user), 3, '7', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 14);

  -- ================= SEMANA 3 =================
  INSERT INTO semanas (rutina_id, numero) VALUES (v_rutina, 3) RETURNING id INTO v_semana;
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 1, 'Día 1') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('SPIDERMAN', 'calentamiento', v_user), 2, '5+5', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KB HIP OPENER', 'calentamiento', v_user), 2, '10+10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('SCAPULAR PUSH UP', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('SHOULDER BOX STRETCH', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 6),
    (v_dia, pg_temp.get_ej('DROP JUMP', 'pliometria', v_user), 3, '5', NULL, 'pliometria', 7),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 3, '4', NULL, 'pliometria', 8),
    (v_dia, pg_temp.get_ej('BACK SQUAT', 'principal', v_user), 5, '4', 'Tempo 2-0-X-1 | RPE6 x2, RPE7 x2, RPE8 x1 | + BOX JUMP | + CONTRASTE 5', 'principal', 9),
    (v_dia, pg_temp.get_ej('BOX JUMP', 'pliometria', v_user), 1, '5', 'Contraste', 'pliometria', 10),
    (v_dia, pg_temp.get_ej('PRESS DE BANCA', 'principal', v_user), 5, '4', 'Tempo 2-0-X-1 | RPE6 x2, RPE7 x2, RPE8 x1 | + BAND ASSISTED PUSH UP | + CONTRASTE 5', 'principal', 11),
    (v_dia, pg_temp.get_ej('BAND ASSISTED PUSH UP', 'calentamiento', v_user), 1, '5', 'Contraste', 'calentamiento', 12),
    (v_dia, pg_temp.get_ej('BULGARIAN SQUAT', 'secundario', v_user), 3, '6', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 13),
    (v_dia, pg_temp.get_ej('PARALELE DIP', 'secundario', v_user), 3, '6', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 14);
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 2, 'Día 2') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('CAT CAMEL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('KB RDL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('BAR ROW', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 6),
    (v_dia, pg_temp.get_ej('DEPTH DROP-STICK', 'pliometria', v_user), 3, '3+3', NULL, 'pliometria', 7),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 3, '4', NULL, 'pliometria', 8),
    (v_dia, pg_temp.get_ej('DL', 'principal', v_user), 5, '4', 'Tempo 2-0-X-1 | RPE6 x2, RPE7 x2, RPE8 x1 | + KB SWING + BROAD JUMP | + CONTRASTE 5 + CONTRASTE 3', 'principal', 9),
    (v_dia, pg_temp.get_ej('KB SWING RUSO', 'calentamiento', v_user), 1, '5', 'Contraste', 'calentamiento', 10),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 1, '3', 'Contraste', 'pliometria', 11),
    (v_dia, pg_temp.get_ej('PULL UP', 'principal', v_user), 4, '6', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 12),
    (v_dia, pg_temp.get_ej('BAR ROW', 'secundario', v_user), 3, '6', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 13),
    (v_dia, pg_temp.get_ej('ONE LEG ISQUIO SLIDER ECCENTRIC', 'secundario', v_user), 3, '5', 'Tempo 3-0-X-1 | X2', 'secundario', 14);
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 3, 'Día 3') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('PIRIFORMIS STRETCH FOR HIPS & BUTT', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KNEELING HIP FLEXOR STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('AIR SQUAT', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('FRONT RACK MOBILITY', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 6),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 7),
    (v_dia, pg_temp.get_ej('DROP JUMP', 'pliometria', v_user), 3, '5', NULL, 'pliometria', 8),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 3, '4', NULL, 'pliometria', 9),
    (v_dia, pg_temp.get_ej('FRONT SQUAT', 'principal', v_user), 5, '4', 'Tempo 2-0-X-1 | RPE6 x2, RPE7 x2, RPE8 x1 | + W.BALL | + CONTRASTE 5', 'principal', 10),
    (v_dia, pg_temp.get_ej('W.BALL', 'pliometria', v_user), 1, '5', 'Contraste', 'pliometria', 11),
    (v_dia, pg_temp.get_ej('DB SHOULDER PRESS', 'principal', v_user), 4, '6', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 12),
    (v_dia, pg_temp.get_ej('DL SUMO', 'secundario', v_user), 3, '6', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 13),
    (v_dia, pg_temp.get_ej('DB LATERAL RISE', 'secundario', v_user), 3, '6', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 14);

  -- ================= SEMANA 4 =================
  INSERT INTO semanas (rutina_id, numero) VALUES (v_rutina, 4) RETURNING id INTO v_semana;
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 1, 'Día 1') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('SPIDERMAN', 'calentamiento', v_user), 2, '5+5', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KB HIP OPENER', 'calentamiento', v_user), 2, '10+10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('SCAPULAR PUSH UP', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('SHOULDER BOX STRETCH', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 6),
    (v_dia, pg_temp.get_ej('DROP JUMP', 'pliometria', v_user), 3, '5', NULL, 'pliometria', 7),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 3, '4', NULL, 'pliometria', 8),
    (v_dia, pg_temp.get_ej('BACK SQUAT', 'principal', v_user), 5, '4-4-4-3-3', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x2, RPE8 x2 | + BOX JUMP | + CONTRASTE 5', 'principal', 9),
    (v_dia, pg_temp.get_ej('BOX JUMP', 'pliometria', v_user), 1, '5', 'Contraste', 'pliometria', 10),
    (v_dia, pg_temp.get_ej('PRESS DE BANCA', 'principal', v_user), 5, '4-4-4-3-3', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x2, RPE8 x2 | + BAND ASSISTED PUSH UP | + CONTRASTE 5', 'principal', 11),
    (v_dia, pg_temp.get_ej('BAND ASSISTED PUSH UP', 'calentamiento', v_user), 1, '5', 'Contraste', 'calentamiento', 12),
    (v_dia, pg_temp.get_ej('BULGARIAN SQUAT', 'secundario', v_user), 3, '5', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 13),
    (v_dia, pg_temp.get_ej('PARALELE DIP', 'secundario', v_user), 3, '5', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 14);
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 2, 'Día 2') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('CAT CAMEL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('KB RDL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('BAR ROW', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 6),
    (v_dia, pg_temp.get_ej('DROP JUMP', 'pliometria', v_user), 3, '5', NULL, 'pliometria', 7),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 3, '4', NULL, 'pliometria', 8),
    (v_dia, pg_temp.get_ej('DL', 'principal', v_user), 5, '4-4-4-3-3', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x2, RPE8 x2 | + KB SWING + BROAD JUMP | + CONTRASTE 5 + CONTRASTE 3', 'principal', 9),
    (v_dia, pg_temp.get_ej('KB SWING RUSO', 'calentamiento', v_user), 1, '5', 'Contraste', 'calentamiento', 10),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 1, '3', 'Contraste', 'pliometria', 11),
    (v_dia, pg_temp.get_ej('PULL UP', 'principal', v_user), 4, '5', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 12),
    (v_dia, pg_temp.get_ej('BAR ROW', 'secundario', v_user), 3, '5', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 13),
    (v_dia, pg_temp.get_ej('ONE LEG ISQUIO SLIDER ECCENTRIC', 'secundario', v_user), 3, '5', 'Tempo 3-0-X-1 | X2', 'secundario', 14);
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 3, 'Día 3') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('PIRIFORMIS STRETCH FOR HIPS & BUTT', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KNEELING HIP FLEXOR STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('AIR SQUAT', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('FRONT RACK MOBILITY', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 6),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 7),
    (v_dia, pg_temp.get_ej('DROP JUMP', 'pliometria', v_user), 3, '5', NULL, 'pliometria', 8),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 3, '4', NULL, 'pliometria', 9),
    (v_dia, pg_temp.get_ej('FRONT SQUAT', 'principal', v_user), 5, '4-4-4-3-3', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x2, RPE8 x2 | + W.BALL | + CONTRASTE 5', 'principal', 10),
    (v_dia, pg_temp.get_ej('W.BALL', 'pliometria', v_user), 1, '5', 'Contraste', 'pliometria', 11),
    (v_dia, pg_temp.get_ej('DB SHOULDER PRESS', 'principal', v_user), 4, '5', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 12),
    (v_dia, pg_temp.get_ej('DL SUMO', 'secundario', v_user), 3, '5', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 13),
    (v_dia, pg_temp.get_ej('DB LATERAL RISE', 'secundario', v_user), 3, '5', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 14);

  -- ================= SEMANA 5 =================
  INSERT INTO semanas (rutina_id, numero) VALUES (v_rutina, 5) RETURNING id INTO v_semana;
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 1, 'Día 1') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('SPIDERMAN', 'calentamiento', v_user), 2, '5+5', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KB HIP OPENER', 'calentamiento', v_user), 2, '10+10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('SCAPULAR PUSH UP', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('SHOULDER BOX STRETCH', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 6),
    (v_dia, pg_temp.get_ej('BONNY HOP VALLAS', 'pliometria', v_user), 1, '-', 'Series/reps no indicadas', 'pliometria', 7),
    (v_dia, pg_temp.get_ej('BACK SQUAT', 'principal', v_user), 5, '3-3-3-2-2', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x2, RPE8 x2', 'principal', 8),
    (v_dia, pg_temp.get_ej('PRESS DE BANCA', 'principal', v_user), 5, '3-3-3-2-2', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x2, RPE8 x2', 'principal', 9),
    (v_dia, pg_temp.get_ej('BULGARIAN SQUAT', 'secundario', v_user), 3, '4', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 10),
    (v_dia, pg_temp.get_ej('PARALELE DIP', 'secundario', v_user), 3, '4', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 11);
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 2, 'Día 2') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('CAT CAMEL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('KB RDL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('BAR ROW', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 6),
    (v_dia, pg_temp.get_ej('DROP JUMP', 'pliometria', v_user), 3, '5', NULL, 'pliometria', 7),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 3, '4', NULL, 'pliometria', 8),
    (v_dia, pg_temp.get_ej('DL', 'principal', v_user), 5, '3-3-3-2-2', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x2, RPE8 x2 | + KB SWING + BROAD JUMP | + CONTRASTE 5 + CONTRASTE 3', 'principal', 9),
    (v_dia, pg_temp.get_ej('KB SWING RUSO', 'calentamiento', v_user), 1, '5', 'Contraste', 'calentamiento', 10),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 1, '3', 'Contraste', 'pliometria', 11),
    (v_dia, pg_temp.get_ej('PULL UP', 'principal', v_user), 4, '4', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 12),
    (v_dia, pg_temp.get_ej('BAR ROW', 'secundario', v_user), 3, '4', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 13),
    (v_dia, pg_temp.get_ej('ONE LEG ISQUIO SLIDER ECCENTRIC', 'secundario', v_user), 3, '5', 'Tempo 3-0-X-1 | X2', 'secundario', 14);
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 3, 'Día 3') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('PIRIFORMIS STRETCH FOR HIPS & BUTT', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KNEELING HIP FLEXOR STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('AIR SQUAT', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('FRONT RACK MOBILITY', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 6),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 7),
    (v_dia, pg_temp.get_ej('BONNY HOP VALLAS', 'pliometria', v_user), 1, '-', 'Series/reps no indicadas', 'pliometria', 8),
    (v_dia, pg_temp.get_ej('FRONT SQUAT', 'principal', v_user), 5, '3-3-3-2-2', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x2, RPE8 x2', 'principal', 9),
    (v_dia, pg_temp.get_ej('DB SHOULDER PRESS', 'principal', v_user), 4, '4', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 10),
    (v_dia, pg_temp.get_ej('DL SUMO', 'secundario', v_user), 3, '4', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 11),
    (v_dia, pg_temp.get_ej('DB LATERAL RISE', 'secundario', v_user), 3, '4', 'Tempo 3-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 12);

  -- ================= SEMANA 6 =================
  INSERT INTO semanas (rutina_id, numero) VALUES (v_rutina, 6) RETURNING id INTO v_semana;
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 1, 'Día 1') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('SPIDERMAN', 'calentamiento', v_user), 2, '5+5', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KB HIP OPENER', 'calentamiento', v_user), 2, '10+10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('SCAPULAR PUSH UP', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('SHOULDER BOX STRETCH', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 6),
    (v_dia, pg_temp.get_ej('BONNY HOP VALLAS', 'pliometria', v_user), 1, '-', 'Series/reps no indicadas', 'pliometria', 7),
    (v_dia, pg_temp.get_ej('BACK SQUAT', 'principal', v_user), 5, '2', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x1, RPE8 x3', 'principal', 8),
    (v_dia, pg_temp.get_ej('PRESS DE BANCA', 'principal', v_user), 5, '2', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x1, RPE8 x3', 'principal', 9),
    (v_dia, pg_temp.get_ej('BULGARIAN SQUAT', 'secundario', v_user), 3, '3', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 10),
    (v_dia, pg_temp.get_ej('PARALELE DIP', 'secundario', v_user), 3, '3', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 11);
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 2, 'Día 2') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('CAT CAMEL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('KB RDL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('BAR ROW', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 6),
    (v_dia, pg_temp.get_ej('DROP JUMP', 'pliometria', v_user), 3, '5', NULL, 'pliometria', 7),
    (v_dia, pg_temp.get_ej('BROAD JUMP', 'pliometria', v_user), 3, '4', NULL, 'pliometria', 8),
    (v_dia, pg_temp.get_ej('DL', 'principal', v_user), 5, '2', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x1, RPE8 x3', 'principal', 9),
    (v_dia, pg_temp.get_ej('PULL UP', 'principal', v_user), 4, '3', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 10),
    (v_dia, pg_temp.get_ej('BAR ROW', 'secundario', v_user), 3, '3', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 11),
    (v_dia, pg_temp.get_ej('ONE LEG ISQUIO SLIDER ECCENTRIC', 'secundario', v_user), 3, '5', 'Tempo 3-0-X-1 | X2', 'secundario', 12);
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 3, 'Día 3') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('PIRIFORMIS STRETCH FOR HIPS & BUTT', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KNEELING HIP FLEXOR STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('AIR SQUAT', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('FRONT RACK MOBILITY', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 6),
    (v_dia, pg_temp.get_ej('SINGLE UNDERS', 'pliometria', v_user), 1, '50', 'SU 50', 'pliometria', 7),
    (v_dia, pg_temp.get_ej('BONNY HOP VALLAS', 'pliometria', v_user), 1, '-', 'Series/reps no indicadas', 'pliometria', 8),
    (v_dia, pg_temp.get_ej('FRONT SQUAT', 'principal', v_user), 5, '2', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x1, RPE8 x3', 'principal', 9),
    (v_dia, pg_temp.get_ej('DB SHOULDER PRESS', 'principal', v_user), 4, '3', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 10),
    (v_dia, pg_temp.get_ej('DL SUMO', 'secundario', v_user), 3, '3', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 11),
    (v_dia, pg_temp.get_ej('DB LATERAL RISE', 'secundario', v_user), 3, '3', 'Tempo 3-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 12);

  -- ================= SEMANA 7 =================
  INSERT INTO semanas (rutina_id, numero) VALUES (v_rutina, 7) RETURNING id INTO v_semana;
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 1, 'Día 1') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('SPIDERMAN', 'calentamiento', v_user), 2, '5+5', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KB HIP OPENER', 'calentamiento', v_user), 2, '10+10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('SCAPULAR PUSH UP', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('SHOULDER BOX STRETCH', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('BACK SQUAT', 'principal', v_user), 5, '2-2-2-2-1', 'Tempo 2-0-X-1 | RPE6 x2, RPE7 x2, RPE8 x1', 'principal', 6),
    (v_dia, pg_temp.get_ej('PRESS DE BANCA', 'principal', v_user), 5, '2-2-2-2-1', 'Tempo 2-0-X-1 | RPE6 x2, RPE7 x2, RPE8 x1', 'principal', 7),
    (v_dia, pg_temp.get_ej('BULGARIAN SQUAT', 'secundario', v_user), 3, '2', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 8),
    (v_dia, pg_temp.get_ej('PARALELE DIP', 'secundario', v_user), 3, '2', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 9);
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 2, 'Día 2') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('CAT CAMEL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('KB RDL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('BAR ROW', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('DL', 'principal', v_user), 5, '2-2-2-2-1', 'Tempo 2-0-X-1 | RPE6 x2, RPE7 x2, RPE8 x1', 'principal', 6),
    (v_dia, pg_temp.get_ej('PULL UP', 'principal', v_user), 4, '2', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 7),
    (v_dia, pg_temp.get_ej('BAR ROW', 'secundario', v_user), 3, '2', 'RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 8),
    (v_dia, pg_temp.get_ej('ONE LEG ISQUIO SLIDER ECCENTRIC', 'secundario', v_user), 3, '5', 'X2', 'secundario', 9);
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 3, 'Día 3') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('PIRIFORMIS STRETCH FOR HIPS & BUTT', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KNEELING HIP FLEXOR STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('AIR SQUAT', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('FRONT RACK MOBILITY', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 6),
    (v_dia, pg_temp.get_ej('FRONT SQUAT', 'principal', v_user), 5, '2-2-2-2-1', 'Tempo 2-0-X-1 | RPE6 x2, RPE7 x2, RPE8 x1', 'principal', 7),
    (v_dia, pg_temp.get_ej('DB SHOULDER PRESS', 'principal', v_user), 4, '2', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 8),
    (v_dia, pg_temp.get_ej('DL SUMO', 'secundario', v_user), 3, '2', 'RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 9),
    (v_dia, pg_temp.get_ej('DB LATERAL RISE', 'secundario', v_user), 3, '2', 'RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 10);

  -- ================= SEMANA 8 =================
  INSERT INTO semanas (rutina_id, numero) VALUES (v_rutina, 8) RETURNING id INTO v_semana;
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 1, 'Día 1') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('SPIDERMAN', 'calentamiento', v_user), 2, '5+5', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KB HIP OPENER', 'calentamiento', v_user), 2, '10+10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('SCAPULAR PUSH UP', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('SHOULDER BOX STRETCH', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('BACK SQUAT', 'principal', v_user), 5, '1', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x1, RPE8 x3', 'principal', 6),
    (v_dia, pg_temp.get_ej('PRESS DE BANCA', 'principal', v_user), 5, '1', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x1, RPE8 x3', 'principal', 7),
    (v_dia, pg_temp.get_ej('BULGARIAN SQUAT', 'secundario', v_user), 3, '1', 'Tempo 2-1-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 8),
    (v_dia, pg_temp.get_ej('PARALELE DIP', 'secundario', v_user), 3, '1', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 9);
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 2, 'Día 2') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('CAT CAMEL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('KB RDL', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('BAR ROW', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('DL', 'principal', v_user), 5, '1', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x1, RPE8 x3', 'principal', 6),
    (v_dia, pg_temp.get_ej('PULL UP', 'principal', v_user), 4, '1', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 7),
    (v_dia, pg_temp.get_ej('BAR ROW', 'secundario', v_user), 3, '1', 'RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 8),
    (v_dia, pg_temp.get_ej('ONE LEG ISQUIO SLIDER ECCENTRIC', 'secundario', v_user), 3, '5', 'X2', 'secundario', 9);
  INSERT INTO dias (semana_id, numero, nombre) VALUES (v_semana, 3, 'Día 3') RETURNING id INTO v_dia;
  INSERT INTO series (dia_id, ejercicio_id, series, repeticiones, observaciones, tipo_ejercicio, orden) VALUES
    (v_dia, pg_temp.get_ej('WALL LEANING DOUBLE LEG CALF RAISE', 'calentamiento', v_user), 2, '20"', '2 rondas', 'calentamiento', 0),
    (v_dia, pg_temp.get_ej('DORSIFLEXION TOBILLO', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 1),
    (v_dia, pg_temp.get_ej('PIRIFORMIS STRETCH FOR HIPS & BUTT', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 2),
    (v_dia, pg_temp.get_ej('KNEELING HIP FLEXOR STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 3),
    (v_dia, pg_temp.get_ej('BANDED HAMSTRING STRETCH', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 4),
    (v_dia, pg_temp.get_ej('AIR SQUAT', 'calentamiento', v_user), 2, '10', '2 rondas', 'calentamiento', 5),
    (v_dia, pg_temp.get_ej('FRONT RACK MOBILITY', 'calentamiento', v_user), 2, '20"/20"', '2 rondas', 'calentamiento', 6),
    (v_dia, pg_temp.get_ej('FRONT SQUAT', 'principal', v_user), 5, '1', 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x1, RPE8 x3', 'principal', 7),
    (v_dia, pg_temp.get_ej('DB SHOULDER PRESS', 'principal', v_user), 4, '1', 'Tempo 2-0-X-1 | RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x2', 'principal', 8),
    (v_dia, pg_temp.get_ej('DL SUMO', 'secundario', v_user), 3, '1', 'RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 9),
    (v_dia, pg_temp.get_ej('DB LATERAL RISE', 'secundario', v_user), 3, '1', 'RIR4 RPE6 x1, RIR3 RPE7 x1, RIR2 RPE8 x1', 'secundario', 10);

END $import$;

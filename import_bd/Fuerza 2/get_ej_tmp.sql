CREATE OR REPLACE FUNCTION pg_temp.get_ej(p_nombre TEXT, p_tipo TEXT, p_user UUID)
RETURNS INTEGER LANGUAGE plpgsql AS \\$
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
END \\$;

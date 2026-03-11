-- halterofilia_entrenamiento_v2.sql
-- Migración: Añadir tabla de ejercicios dentro de entrenamiento

-- ============================================
-- CREAR TABLA HALTEROFILIA EJERCICIOS
-- ============================================

CREATE TABLE IF NOT EXISTS halterofilia_ejercicios (
  id SERIAL PRIMARY KEY,
  entrenamiento_id INTEGER NOT NULL REFERENCES halterofilia_entrenamientos(id) ON DELETE CASCADE,
  ejercicio_id INTEGER NOT NULL REFERENCES ejercicios(id),
  orden INTEGER NOT NULL DEFAULT 0
);

-- RLS policies
ALTER TABLE halterofilia_ejercicios ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own halterofilia_ejercicios"
  ON halterofilia_ejercicios FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM halterofilia_entrenamientos
      WHERE halterofilia_entrenamientos.id = halterofilia_ejercicios.entrenamiento_id
      AND halterofilia_entrenamientos.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can insert their own halterofilia_ejercicios"
  ON halterofilia_ejercicios FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM halterofilia_entrenamientos
      WHERE halterofilia_entrenamientos.id = halterofilia_ejercicios.entrenamiento_id
      AND halterofilia_entrenamientos.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can update their own halterofilia_ejercicios"
  ON halterofilia_ejercicios FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM halterofilia_entrenamientos
      WHERE halterofilia_entrenamientos.id = halterofilia_ejercicios.entrenamiento_id
      AND halterofilia_entrenamientos.user_id = auth.uid()
    )
  );

CREATE POLICY "Users can delete their own halterofilia_ejercicios"
  ON halterofilia_ejercicios FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM halterofilia_entrenamientos
      WHERE halterofilia_entrenamientos.id = halterofilia_ejercicios.entrenamiento_id
      AND halterofilia_entrenamientos.user_id = auth.uid()
    )
  );

-- ============================================
-- AÑADIR COLUMNA A RONDAS
-- ============================================

ALTER TABLE halterofilia_rondas
ADD COLUMN IF NOT EXISTS ejercicio_entrenamiento_id INTEGER REFERENCES halterofilia_ejercicios(id) ON DELETE CASCADE;

-- ============================================
-- ACTUALIZAR RLS DE RONDAS (corregir la policy)
-- ============================================

DROP POLICY IF EXISTS "Users can view their own halterofilia_rondas" ON halterofilia_rondas;
DROP POLICY IF EXISTS "Users can insert their own halterofilia_rondas" ON halterofilia_rondas;
DROP POLICY IF EXISTS "Users can update their own halterofilia_rondas" ON halterofilia_rondas;
DROP POLICY IF EXISTS "Users can delete their own halterofilia_rondas" ON halterofilia_rondas;

CREATE POLICY "Users can view their own halterofilia_rondas"
  ON halterofilia_rondas FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM halterofilia_ejercicios
      WHERE halterofilia_ejercicios.id = halterofilia_rondas.ejercicio_entrenamiento_id
      AND EXISTS (
        SELECT 1 FROM halterofilia_entrenamientos
        WHERE halterofilia_entrenamientos.id = halterofilia_ejercicios.entrenamiento_id
        AND halterofilia_entrenamientos.user_id = auth.uid()
      )
    )
  );

CREATE POLICY "Users can insert their own halterofilia_rondas"
  ON halterofilia_rondas FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM halterofilia_ejercicios
      WHERE halterofilia_ejercicios.id = halterofilia_rondas.ejercicio_entrenamiento_id
      AND EXISTS (
        SELECT 1 FROM halterofilia_entrenamientos
        WHERE halterofilia_entrenamientos.id = halterofilia_ejercicios.entrenamiento_id
        AND halterofilia_entrenamientos.user_id = auth.uid()
      )
    )
  );

CREATE POLICY "Users can update their own halterofilia_rondas"
  ON halterofilia_rondas FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM halterofilia_ejercicios
      WHERE halterofilia_ejercicios.id = halterofilia_rondas.ejercicio_entrenamiento_id
      AND EXISTS (
        SELECT 1 FROM halterofilia_entrenamientos
        WHERE halterofilia_entrenamientos.id = halterofilia_ejercicios.entrenamiento_id
        AND halterofilia_entrenamientos.user_id = auth.uid()
      )
    )
  );

CREATE POLICY "Users can delete their own halterofilia_rondas"
  ON halterofilia_rondas FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM halterofilia_ejercicios
      WHERE halterofilia_ejercicios.id = halterofilia_rondas.ejercicio_entrenamiento_id
      AND EXISTS (
        SELECT 1 FROM halterofilia_entrenamientos
        WHERE halterofilia_entrenamientos.id = halterofilia_ejercicios.entrenamiento_id
        AND halterofilia_entrenamientos.user_id = auth.uid()
      )
    )
  );

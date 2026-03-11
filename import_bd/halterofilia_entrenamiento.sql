-- halterofilia_entrenamiento.sql
-- Tablas para almacenar entrenamientos de halterofilia

-- ============================================
-- HALTEROFILIA ENTRENAMIENTOS
-- ============================================

CREATE TABLE IF NOT EXISTS halterofilia_entrenamientos (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) DEFAULT auth.uid(),
  fecha TIMESTAMPTZ DEFAULT NOW(),
  notas TEXT
);

-- RLS policies
ALTER TABLE halterofilia_entrenamientos ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own halterofilia_entrenamientos"
  ON halterofilia_entrenamientos FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own halterofilia_entrenamientos"
  ON halterofilia_entrenamientos FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own halterofilia_entrenamientos"
  ON halterofilia_entrenamientos FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own halterofilia_entrenamientos"
  ON halterofilia_entrenamientos FOR DELETE
  USING (auth.uid() = user_id);

-- ============================================
-- HALTEROFILIA EJERCICIOS (ejercicios dentro de un entrenamiento)
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
-- HALTEROFILIA RONDAS
-- ============================================

CREATE TABLE IF NOT EXISTS halterofilia_rondas (
  id SERIAL PRIMARY KEY,
  ejercicio_entrenamiento_id INTEGER NOT NULL REFERENCES halterofilia_ejercicios(id) ON DELETE CASCADE,
  repeticiones INTEGER NOT NULL,
  series INTEGER NOT NULL,
  porcentaje INTEGER NOT NULL,
  peso NUMERIC(6, 2),
  orden INTEGER NOT NULL DEFAULT 0
);

-- RLS policies
ALTER TABLE halterofilia_rondas ENABLE ROW LEVEL SECURITY;

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

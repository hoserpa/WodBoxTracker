-- Quitar columna rm de ejercicios si existe
ALTER TABLE ejercicios DROP COLUMN IF EXISTS rm;

-- Crear tabla user_rm
CREATE TABLE IF NOT EXISTS user_rm (
  id SERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) NOT NULL,
  ejercicio_id INTEGER REFERENCES ejercicios(id) NOT NULL,
  rm NUMERIC NOT NULL,
  fecha TIMESTAMPTZ DEFAULT NOW(),
  notas TEXT,
  UNIQUE(user_id, ejercicio_id)
);

-- RLS
ALTER TABLE user_rm ENABLE ROW LEVEL SECURITY;

-- Políticas RLS
DROP POLICY IF EXISTS "user_rm_all" ON user_rm;
CREATE POLICY "user_rm_all" ON user_rm 
  FOR ALL 
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

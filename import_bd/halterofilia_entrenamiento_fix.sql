-- halterofilia_entrenamiento_fix.sql
-- Corrección de estructura para migración

-- 1. Hacer nullable la columna ejercicio_id (ya no se usa directamente)
ALTER TABLE halterofilia_rondas ALTER COLUMN ejercicio_id DROP NOT NULL;

-- 2. Crear columna ejercicio_entrenamiento_id si no existe
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_name = 'halterofilia_rondas' 
    AND column_name = 'ejercicio_entrenamiento_id'
  ) THEN
    ALTER TABLE halterofilia_rondas ADD COLUMN ejercicio_entrenamiento_id INTEGER REFERENCES halterofilia_ejercicios(id) ON DELETE CASCADE;
  END IF;
END $$;

-- 3. Verificar estructura final
-- La tabla halterofilia_rondas debería tener:
-- - id (PK)
-- - ejercicio_entrenamiento_id (FK a halterofilia_ejercicios)
-- - repeticiones
-- - series
-- - porcentaje
-- - peso
-- - orden
-- - ejercicio_id (nullable, legacy)
-- - entrenamiento_id (nullable, legacy)

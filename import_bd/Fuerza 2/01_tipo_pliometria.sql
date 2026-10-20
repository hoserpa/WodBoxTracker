-- =====================================================================
-- Nuevo tipo de ejercicio: PLIOMETRIA
-- Ejecutar ESTE script primero y por separado (no dentro del mismo
-- bloque/transacción que el import): un valor nuevo de un ENUM no se
-- puede usar hasta que se haya confirmado el ALTER TYPE.
-- =====================================================================

-- 1. Valor en el ENUM usado por series.tipo_ejercicio
ALTER TYPE tipo_ejercicio ADD VALUE IF NOT EXISTS 'pliometria';

-- 2. Fila en el catálogo tipos_ejercicio (ejercicios.tipo_id)
INSERT INTO tipos_ejercicio (nombre)
VALUES ('pliometria')
ON CONFLICT (nombre) DO NOTHING;

-- Verificación
-- SELECT unnest(enum_range(NULL::tipo_ejercicio));
-- SELECT * FROM tipos_ejercicio ORDER BY id;

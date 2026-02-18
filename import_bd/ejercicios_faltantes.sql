-- Ejercicios faltantes de Rutinas.txt
-- Agregar ejercicios que existen en Rutinas.txt pero no en la BD

INSERT INTO ejercicios (nombre, tipo_id) VALUES
('BANDED OHS', 1),
('KB PUSH PRESS', 1)
ON CONFLICT (nombre) DO NOTHING;

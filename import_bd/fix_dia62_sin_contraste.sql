-- Quita el contraste del dia 62 (rutina 3, semana 8, dia 2)
-- Ejecutar en el SQL Editor de Supabase

BEGIN;

UPDATE series
SET observaciones = 'Tempo 2-0-X-1 | RPE6 x1, RPE7 x2, RPE8 x2'
WHERE dia_id = 62
  AND tipo_ejercicio = 'principal'
  AND observaciones LIKE '%+ CONTRASTE%';

DELETE FROM series
WHERE dia_id = 62
  AND observaciones = 'Contraste'
  AND tipo_ejercicio IN ('calentamiento', 'pliometria');

COMMIT;

-- Verificacion: deben quedar solo DL y PULL UP como principales,
-- sin ninguna serie con observacion 'Contraste'
SELECT s.id, e.nombre, s.tipo_ejercicio, s.series, s.repeticiones, s.observaciones, s.orden
FROM series s
JOIN ejercicios e ON e.id = s.ejercicio_id
WHERE s.dia_id = 62
ORDER BY s.orden;

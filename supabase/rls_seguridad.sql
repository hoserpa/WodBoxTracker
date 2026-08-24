-- ============================================================
-- rls_seguridad.sql — Endurecimiento de políticas RLS
-- Ejecutar en Supabase SQL Editor (revisar antes de aplicar)
-- Idempotente: se puede ejecutar varias veces sin error.
--
-- Corrige:
--   1. ejercicios: INSERT/UPDATE/DELETE estaban abiertos a cualquier
--      usuario autenticado (WITH CHECK (true) / USING (true)).
--      Nuevo modelo: cada usuario crea ejercicios PRIVADOS propios
--      (user_id = auth.uid()); el catálogo global (user_id NULL)
--      solo lo gestionan los administradores.
--   2. exercise_details: tabla sin RLS activado (referencia pública,
--      ahora solo lectura para usuarios autenticados).
--
-- El resto de tablas (rutinas, semanas, dias, series, registros,
-- dias_completados, user_rm, halterofilia_*, wod_diario) ya tienen
-- políticas correctas limitadas por auth.uid().
-- ============================================================

-- ------------------------------------------------------------
-- 0. Diagnóstico (opcional): estado actual de policies y RLS
-- ------------------------------------------------------------
-- SELECT tablename, rowsecurity FROM pg_tables WHERE schemaname = 'public';
-- SELECT tablename, policyname, cmd, qual, with_check FROM pg_policies WHERE schemaname = 'public';

-- ------------------------------------------------------------
-- 1. Tabla de administradores + función auxiliar
--    (el admin se inserta automáticamente por email más abajo)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.admins (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.admins ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "admins leen su propia fila" ON public.admins;
CREATE POLICY "admins leen su propia fila" ON public.admins
  FOR SELECT TO authenticated
  USING (user_id = auth.uid());

CREATE OR REPLACE FUNCTION public.es_admin()
RETURNS BOOLEAN
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
STABLE
AS $$
  SELECT EXISTS (SELECT 1 FROM public.admins WHERE user_id = auth.uid());
$$;

REVOKE EXECUTE ON FUNCTION public.es_admin() FROM anon;
GRANT EXECUTE ON FUNCTION public.es_admin() TO authenticated;

-- Inserta como admin al usuario con este email (ajústalo si procede)
INSERT INTO public.admins (user_id)
SELECT id FROM auth.users WHERE email = 'joraalgo@gmail.com'
ON CONFLICT DO NOTHING;

-- Verificación: debe devolver 1 fila
SELECT user_id FROM public.admins;

-- ------------------------------------------------------------
-- 2. ejercicios: modelo de ejercicios privados por usuario
--    - user_id NULL  -> ejercicio global del catálogo (solo admins)
--    - user_id uid   -> ejercicio privado del usuario
--    El DEFAULT auth.uid() hace que los INSERT desde la app salgan
--    privados automáticamente; los imports por SQL Editor (sin
--    sesión, auth.uid() = NULL) siguen creando globales.
-- ------------------------------------------------------------
ALTER TABLE ejercicios
  ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id)
  ON DELETE CASCADE DEFAULT auth.uid();

-- Unicidad: nombre único en el catálogo global y único por usuario.
-- Sustituye a la constraint UNIQUE(nombre) original.
ALTER TABLE ejercicios DROP CONSTRAINT IF EXISTS ejercicios_nombre_key;
CREATE UNIQUE INDEX IF NOT EXISTS ejercicios_nombre_global_unico
  ON ejercicios (LOWER(nombre)) WHERE user_id IS NULL;
CREATE UNIQUE INDEX IF NOT EXISTS ejercicios_nombre_usuario_unico
  ON ejercicios (LOWER(nombre), user_id) WHERE user_id IS NOT NULL;

DROP POLICY IF EXISTS "Anyone can read ejercicios" ON ejercicios;
DROP POLICY IF EXISTS "Users can insert their own ejercicios" ON ejercicios;
DROP POLICY IF EXISTS "Users can update their own ejercicios" ON ejercicios;
DROP POLICY IF EXISTS "Users can delete their own ejercicios" ON ejercicios;
DROP POLICY IF EXISTS "Solo admins insertan ejercicios" ON ejercicios;
DROP POLICY IF EXISTS "Solo admins actualizan ejercicios" ON ejercicios;
DROP POLICY IF EXISTS "Solo admins borran ejercicios" ON ejercicios;
DROP POLICY IF EXISTS "leer catalogo global y propios" ON ejercicios;
DROP POLICY IF EXISTS "crear ejercicios propios" ON ejercicios;
DROP POLICY IF EXISTS "editar propios o admin globales" ON ejercicios;
DROP POLICY IF EXISTS "borrar propios o admin globales" ON ejercicios;

CREATE POLICY "leer catalogo global y propios"
  ON ejercicios FOR SELECT TO authenticated
  USING (user_id IS NULL OR user_id = auth.uid());

CREATE POLICY "crear ejercicios propios"
  ON ejercicios FOR INSERT TO authenticated
  WITH CHECK (
    user_id = auth.uid()
    OR (public.es_admin() AND user_id IS NULL)
  );

CREATE POLICY "editar propios o admin globales"
  ON ejercicios FOR UPDATE TO authenticated
  USING (user_id = auth.uid() OR (public.es_admin() AND user_id IS NULL))
  WITH CHECK (
    user_id = auth.uid()
    OR (public.es_admin() AND user_id IS NULL)
  );

CREATE POLICY "borrar propios o admin globales"
  ON ejercicios FOR DELETE TO authenticated
  USING (user_id = auth.uid() OR (public.es_admin() AND user_id IS NULL));

-- ------------------------------------------------------------
-- 3. exercise_details: activar RLS (solo lectura autenticada)
-- ------------------------------------------------------------
ALTER TABLE exercise_details ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "authenticated leen exercise_details" ON exercise_details;
CREATE POLICY "authenticated leen exercise_details"
  ON exercise_details FOR SELECT TO authenticated
  USING (true);

-- ------------------------------------------------------------
-- 4. Recordatorio manual (fuera de SQL):
--    Dashboard → Authentication → Policies → contraseña mínima 8+,
--    o bien Auth Providers → Password → minimum length = 8.
-- ------------------------------------------------------------

-- import_bd.sql - WODBOX TRACKER
-- Table definitions with Row Level Security (RLS)

-- ============================================
-- ENUM TYPES
-- ============================================

DO $$ BEGIN
  CREATE TYPE tipo_ejercicio AS ENUM ('calentamiento', 'principal', 'secundario', 'core');
EXCEPTION
  WHEN duplicate_object THEN null;
END $$;

-- ============================================
-- TIPOS_EJERCICIO
-- ============================================

CREATE TABLE IF NOT EXISTS tipos_ejercicio (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL UNIQUE
);

-- ============================================
-- EJERCICIOS
-- ============================================

CREATE TABLE IF NOT EXISTS ejercicios (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL UNIQUE,
  tipo_id INTEGER REFERENCES tipos_ejercicio(id)
);

-- ============================================
-- RUTINAS
-- ============================================

CREATE TABLE IF NOT EXISTS rutinas (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  descripcion TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add user_id if not exists (for RLS)
DO $$ BEGIN
  ALTER TABLE rutinas ADD COLUMN user_id UUID REFERENCES auth.users(id) DEFAULT auth.uid();
EXCEPTION
  WHEN duplicate_column THEN null;
END $$;

-- ============================================
-- SEMANAS
-- ============================================

CREATE TABLE IF NOT EXISTS semanas (
  id SERIAL PRIMARY KEY,
  rutina_id INTEGER NOT NULL REFERENCES rutinas(id) ON DELETE CASCADE,
  numero INTEGER NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- DIAS
-- ============================================

CREATE TABLE IF NOT EXISTS dias (
  id SERIAL PRIMARY KEY,
  semana_id INTEGER NOT NULL REFERENCES semanas(id) ON DELETE CASCADE,
  numero INTEGER NOT NULL,
  nombre TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- SERIES
-- ============================================

CREATE TABLE IF NOT EXISTS series (
  id SERIAL PRIMARY KEY,
  dia_id INTEGER NOT NULL REFERENCES dias(id) ON DELETE CASCADE,
  ejercicio_id INTEGER NOT NULL REFERENCES ejercicios(id),
  series INTEGER NOT NULL,
  repeticiones TEXT NOT NULL,
  observaciones TEXT,
  tipo_ejercicio tipo_ejercicio NOT NULL,
  orden INTEGER NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- REGISTROS (Weight tracking - user specific)
-- ============================================

CREATE TABLE IF NOT EXISTS registros (
  id SERIAL PRIMARY KEY,
  serie_id INTEGER NOT NULL REFERENCES series(id) ON DELETE CASCADE,
  user_id UUID REFERENCES auth.users(id) DEFAULT auth.uid(),
  peso NUMERIC(6, 2),
  fecha DATE DEFAULT CURRENT_DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- INSERT DATA (except series and registros)
-- ============================================

-- ============================================
-- TIPOS DE EJERCICIO
-- ============================================

INSERT INTO tipos_ejercicio (nombre) 
SELECT unnest(ARRAY['calentamiento', 'principal', 'secundario', 'core'])
WHERE NOT EXISTS (SELECT 1 FROM tipos_ejercicio LIMIT 1);

-- ============================================
-- EJERCICIOS
-- ============================================

INSERT INTO ejercicios (nombre, tipo_id) 
SELECT * FROM (
  SELECT 'HALF-KNEELING LOADED DORSIFLEXION STRETCH'::TEXT, 1
  UNION ALL SELECT 'CAT CAMEL', 1
  UNION ALL SELECT 'KB HALO', 1
  UNION ALL SELECT 'WALL SQUAT HOLD', 1
  UNION ALL SELECT 'KB PLANK HAND TAPS', 1
  UNION ALL SELECT 'ELEVACION Y DEPRESION ESCAPULAR', 1
  UNION ALL SELECT 'WALL ANGEL', 1
  UNION ALL SELECT 'PVC THORACIC EXTENSION ON THE WALL', 1
  UNION ALL SELECT 'PVC FRONT RACK OPENER', 1
  UNION ALL SELECT 'DEAD BUG', 1
  UNION ALL SELECT 'QUADRUPED HIP ROCKING', 1
  UNION ALL SELECT 'KB TATER', 1
  UNION ALL SELECT 'BANDED SQUAT', 1
  UNION ALL SELECT 'PULLS APART', 1
  UNION ALL SELECT 'SHOULDER BOX STRETCH', 1
  UNION ALL SELECT 'PNF TO IMPROVE ANKLE DORSIFLEXION', 1
  UNION ALL SELECT 'KB GOOD MORNING', 1
  UNION ALL SELECT 'PLATE ROMANIAN DEADLIFT', 1
  UNION ALL SELECT 'BAR ROW', 1
  UNION ALL SELECT 'BOX QUAD T-SPINE ROT', 1
  UNION ALL SELECT 'KNEELING HIP FLEXOR STRETCH', 1
  UNION ALL SELECT 'PIRIFORMIS STRETCH FOR HIPS & BUTT', 1
  UNION ALL SELECT 'SCAPULAR PUSH UP', 1
  UNION ALL SELECT 'RUMANIAN DL', 1
  UNION ALL SELECT 'RUN', 1
  UNION ALL SELECT 'JUMPING JACK', 1
  UNION ALL SELECT '3 POSITION ANKLE DISTRACTION', 1
  UNION ALL SELECT 'WALL LEANING DOUBLE LEG CALF RAISE', 1
  UNION ALL SELECT 'DORSIFLEXION TOBILLO', 1
  UNION ALL SELECT 'SPIDERMAN', 1
  UNION ALL SELECT 'KB HIP OPENER', 1
  UNION ALL SELECT 'BANDED HAMSTRING STRETCH', 1
  UNION ALL SELECT 'KB SWING RUSO', 1
  UNION ALL SELECT 'REVERSE SNOW ANGELS', 1
  UNION ALL SELECT 'BANDED SCAPULA RETRACTION', 1
  UNION ALL SELECT 'MONSTER WALK', 1
  UNION ALL SELECT 'BACK SQUAT', 2
  UNION ALL SELECT 'PULL UP', 2
  UNION ALL SELECT 'PRESS DE BANCA', 2
  UNION ALL SELECT 'DL', 2
  UNION ALL SELECT 'SHOULDER PRESS', 2
  UNION ALL SELECT 'FRONT SQUAT', 2
  UNION ALL SELECT 'SEATED ALTERNATE DB SHOULDER PRESS', 2
  UNION ALL SELECT 'SEATE DB SHOULDER PRESS ALTERNO', 3
  UNION ALL SELECT 'TRICEP KICKBACK EXTENSION', 3
  UNION ALL SELECT 'COPENHAGUEN HIP ABDUCTION HOLD', 3
  UNION ALL SELECT 'BULGARIAN SQUAT', 3
  UNION ALL SELECT 'CURL DE BICEP', 3
  UNION ALL SELECT 'ALTERNATING DUMBBELL FLOOR PRESS', 3
  UNION ALL SELECT 'KB ONE ARM ROW', 3
  UNION ALL SELECT 'KB RDL', 3
  UNION ALL SELECT 'BANDED TRICEPS EXTENSION', 3
  UNION ALL SELECT 'BAND GLUTE KICKBACK', 3
  UNION ALL SELECT 'HIP THRUST', 3
  UNION ALL SELECT 'KB SPLIT SQUAT', 3
  UNION ALL SELECT 'FEXO-EXTENSION DE GEMELOS', 3
  UNION ALL SELECT 'CURL DE BICEP MARTILLO', 3
  UNION ALL SELECT 'DB LATERAL RISE', 3
  UNION ALL SELECT 'DB FRONT SHOULDER', 3
  UNION ALL SELECT 'HOLLOW HOLD', 4
  UNION ALL SELECT 'ARCH HOLD', 4
  UNION ALL SELECT 'LATERAL SIDE PLANK', 4
  UNION ALL SELECT 'AB WHEEL', 4
  UNION ALL SELECT 'SUPERMAN CONTRALATERAL', 4
  UNION ALL SELECT 'PRESS PALLOF', 4
  UNION ALL SELECT 'SPLIT PRESS PALLOF', 4
) AS data(nombre, tipo_id)
WHERE NOT EXISTS (SELECT 1 FROM ejercicios e WHERE e.nombre = data.nombre);

-- ============================================
-- RUTINAS
-- ============================================

INSERT INTO rutinas (nombre, descripcion)
SELECT * FROM (
  SELECT 'FUERZA AVANZADO 2'::TEXT, 'Rutina de fuerza avanzada - 8 semanas, 3 dias por semana, SIN ejercicios core'::TEXT
  UNION ALL 
  SELECT 'FUERZA AVANZADO 3 HIPERTROFIA', 'Rutina de hipertrofia - 8 semanas, 3 dias por semana, CON ejercicios core'
) AS data(nombre, descripcion)
WHERE NOT EXISTS (SELECT 1 FROM rutinas r WHERE r.nombre = data.nombre);

-- Make template routines visible to all users (user_id = null)
UPDATE rutinas SET user_id = NULL WHERE nombre IN ('FUERZA AVANZADO 2', 'FUERZA AVANZADO 3 HIPERTROFIA');

-- ============================================
-- SEMANAS (8 semanas por rutina)
-- ============================================

-- Only insert if not exists
INSERT INTO semanas (rutina_id, numero)
SELECT * FROM (
  SELECT 1, generate_series(1, 8)
  UNION ALL
  SELECT 2, generate_series(1, 8)
) AS data(rutina_id, numero)
WHERE NOT EXISTS (
  SELECT 1 FROM semanas s 
  WHERE s.rutina_id = data.rutina_id AND s.numero = data.numero
);

-- ============================================
-- DIAS (3 dias por semana, 8 semanas = 24 dias por rutina)
-- ============================================

-- Generate dias for all weeks (semana_id 1-16)
INSERT INTO dias (semana_id, numero, nombre)
SELECT s.id, d.numero, 'Día ' || d.numero
FROM semanas s
CROSS JOIN (SELECT generate_series(1, 3) AS numero) d
WHERE NOT EXISTS (
  SELECT 1 FROM dias d2 
  WHERE d2.semana_id = s.id AND d2.numero = d.numero
);

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================

-- Enable RLS on all tables
ALTER TABLE tipos_ejercicio ENABLE ROW LEVEL SECURITY;
ALTER TABLE ejercicios ENABLE ROW LEVEL SECURITY;
ALTER TABLE rutinas ENABLE ROW LEVEL SECURITY;
ALTER TABLE semanas ENABLE ROW LEVEL SECURITY;
ALTER TABLE dias ENABLE ROW LEVEL SECURITY;
ALTER TABLE series ENABLE ROW LEVEL SECURITY;
ALTER TABLE registros ENABLE ROW LEVEL SECURITY;

-- ============================================
-- RLS POLICIES FOR EJERCICIOS (Template data)
-- ============================================

DROP POLICY IF EXISTS "Anyone can read ejercicios" ON ejercicios;
CREATE POLICY "Anyone can read ejercicios" ON ejercicios FOR SELECT USING (true);

DROP POLICY IF EXISTS "Users can insert their own ejercicios" ON ejercicios;
CREATE POLICY "Users can insert their own ejercicios" ON ejercicios FOR INSERT WITH CHECK (true);

DROP POLICY IF EXISTS "Users can update their own ejercicios" ON ejercicios;
CREATE POLICY "Users can update their own ejercicios" ON ejercicios FOR UPDATE USING (true);

DROP POLICY IF EXISTS "Users can delete their own ejercicios" ON ejercicios;
CREATE POLICY "Users can delete their own ejercicios" ON ejercicios FOR DELETE USING (true);

-- ============================================
-- RLS POLICIES FOR RUTINAS
-- ============================================

-- Allow reading own routines or template routines (user_id is null)
DROP POLICY IF EXISTS "Users can read their own rutinas" ON rutinas;
CREATE POLICY "Users can read their own rutinas" ON rutinas
  FOR SELECT USING (auth.uid() = user_id OR user_id IS NULL);

DROP POLICY IF EXISTS "Users can insert their own rutinas" ON rutinas;
CREATE POLICY "Users can insert their own rutinas" ON rutinas
  FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can update their own rutinas" ON rutinas;
CREATE POLICY "Users can update their own rutinas" ON rutinas
  FOR UPDATE USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can delete their own rutinas" ON rutinas;
CREATE POLICY "Users can delete their own rutinas" ON rutinas
  FOR DELETE USING (auth.uid() = user_id);

-- ============================================
-- RLS POLICIES FOR SEMANAS
-- ============================================

-- Allow reading own semanas or from template rutinas (user_id is null)
DROP POLICY IF EXISTS "Users can read their own semanas" ON semanas;
CREATE POLICY "Users can read their own semanas" ON semanas
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM rutinas r 
      WHERE r.id = semanas.rutina_id AND (r.user_id = auth.uid() OR r.user_id IS NULL)
    )
  );

DROP POLICY IF EXISTS "Users can insert their own semanas" ON semanas;
CREATE POLICY "Users can insert their own semanas" ON semanas
  FOR INSERT WITH CHECK (
    EXISTS (SELECT 1 FROM rutinas WHERE rutinas.id = semanas.rutina_id AND rutinas.user_id = auth.uid())
  );

DROP POLICY IF EXISTS "Users can update their own semanas" ON semanas;
CREATE POLICY "Users can update their own semanas" ON semanas
  FOR UPDATE USING (
    EXISTS (SELECT 1 FROM rutinas WHERE rutinas.id = semanas.rutina_id AND rutinas.user_id = auth.uid())
  );

DROP POLICY IF EXISTS "Users can delete their own semanas" ON semanas;
CREATE POLICY "Users can delete their own semanas" ON semanas
  FOR DELETE USING (
    EXISTS (SELECT 1 FROM rutinas WHERE rutinas.id = semanas.rutina_id AND rutinas.user_id = auth.uid())
  );

-- ============================================
-- RLS POLICIES FOR DIAS
-- ============================================

-- Allow reading own dias or from template rutinas (user_id is null)
DROP POLICY IF EXISTS "Users can read their own dias" ON dias;
CREATE POLICY "Users can read their own dias" ON dias
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM semanas s
      JOIN rutinas r ON r.id = s.rutina_id
      WHERE s.id = dias.semana_id AND (r.user_id = auth.uid() OR r.user_id IS NULL)
    )
  );

DROP POLICY IF EXISTS "Users can insert their own dias" ON dias;
CREATE POLICY "Users can insert their own dias" ON dias
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM semanas s
      JOIN rutinas r ON r.id = s.rutina_id
      WHERE s.id = dias.semana_id AND r.user_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "Users can update their own dias" ON dias;
CREATE POLICY "Users can update their own dias" ON dias
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM semanas s
      JOIN rutinas r ON r.id = s.rutina_id
      WHERE s.id = dias.semana_id AND r.user_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "Users can delete their own dias" ON dias;
CREATE POLICY "Users can delete their own dias" ON dias
  FOR DELETE USING (
    EXISTS (
      SELECT 1 FROM semanas s
      JOIN rutinas r ON r.id = s.rutina_id
      WHERE s.id = dias.semana_id AND r.user_id = auth.uid()
    )
  );

-- ============================================
-- RLS POLICIES FOR SERIES
-- ============================================

DROP POLICY IF EXISTS "Users can read their own series" ON series;
CREATE POLICY "Users can read their own series" ON series
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM dias d
      JOIN semanas s ON s.id = d.semana_id
      JOIN rutinas r ON r.id = s.rutina_id
      WHERE d.id = series.dia_id AND (r.user_id = auth.uid() OR r.user_id IS NULL)
    )
  );

DROP POLICY IF EXISTS "Users can insert their own series" ON series;
CREATE POLICY "Users can insert their own series" ON series
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM dias d
      JOIN semanas s ON s.id = d.semana_id
      JOIN rutinas r ON r.id = s.rutina_id
      WHERE d.id = series.dia_id AND r.user_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "Users can update their own series" ON series;
CREATE POLICY "Users can update their own series" ON series
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM dias d
      JOIN semanas s ON s.id = d.semana_id
      JOIN rutinas r ON r.id = s.rutina_id
      WHERE d.id = series.dia_id AND r.user_id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "Users can delete their own series" ON series;
CREATE POLICY "Users can delete their own series" ON series
  FOR DELETE USING (
    EXISTS (
      SELECT 1 FROM dias d
      JOIN semanas s ON s.id = d.semana_id
      JOIN rutinas r ON r.id = s.rutina_id
      WHERE d.id = series.dia_id AND r.user_id = auth.uid()
    )
  );

-- ============================================
-- RLS POLICIES FOR REGISTROS
-- ============================================

DROP POLICY IF EXISTS "Users can read their own registros" ON registros;
CREATE POLICY "Users can read their own registros" ON registros
  FOR SELECT USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can insert their own registros" ON registros;
CREATE POLICY "Users can insert their own registros" ON registros
  FOR INSERT WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can update their own registros" ON registros;
CREATE POLICY "Users can update their own registros" ON registros
  FOR UPDATE USING (auth.uid() = user_id);

DROP POLICY IF EXISTS "Users can delete their own registros" ON registros;
CREATE POLICY "Users can delete their own registros" ON registros
  FOR DELETE USING (auth.uid() = user_id);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================

CREATE INDEX IF NOT EXISTS idx_semanas_rutina ON semanas(rutina_id);
CREATE INDEX IF NOT EXISTS idx_dias_semana ON dias(semana_id);
CREATE INDEX IF NOT EXISTS idx_series_dia ON series(dia_id);
CREATE INDEX IF NOT EXISTS idx_series_ejercicio ON series(ejercicio_id);
CREATE INDEX IF NOT EXISTS idx_registros_serie ON registros(serie_id);
CREATE INDEX IF NOT EXISTS idx_registros_user ON registros(user_id);

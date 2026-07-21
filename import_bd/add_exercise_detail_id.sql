ALTER TABLE ejercicios ADD COLUMN IF NOT EXISTS exercise_detail_id VARCHAR(10) REFERENCES exercise_details(id);

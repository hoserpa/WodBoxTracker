-- ============================================================
-- WOD del día (global para todos los usuarios)
-- Ejecutar en el SQL Editor de Supabase.
--
-- La tabla wod_diario guarda un registro por día; su historial
-- actúa como registro anti-repetición. Cuando todos los WODs
-- han salido, el ciclo se reinicia automáticamente.
--
-- NOTA: si regeneras src/data/wods.json con otro total,
-- actualiza la constante total_wods de la función.
-- ============================================================

create table if not exists public.wod_diario (
  fecha date primary key,
  wod_id bigint not null,
  created_at timestamptz not null default now()
);

alter table public.wod_diario enable row level security;

drop policy if exists "authenticated can read wod_diario" on public.wod_diario;
create policy "authenticated can read wod_diario"
  on public.wod_diario
  for select
  to authenticated
  using (true);

create or replace function public.obtener_wod_del_dia()
returns table (wod_fecha date, wod_elegido bigint)
language plpgsql
security definer
set search_path = public
as $$
declare
  total_wods constant bigint := 5168;
  v_fecha date := current_date;
  v_wod_id bigint;
  v_usados bigint;
begin
  -- 1) Si ya existe la elección de hoy, devolverla (idempotente)
  select d.wod_id
    into v_wod_id
    from public.wod_diario d
   where d.fecha = v_fecha;

  if v_wod_id is not null then
    return query select v_fecha, v_wod_id;
    return;
  end if;

  -- 2) Lock para serializar la primera llamada del día entre usuarios
  perform pg_advisory_xact_lock(918273645);

  select d.wod_id
    into v_wod_id
    from public.wod_diario d
   where d.fecha = v_fecha;

  if v_wod_id is not null then
    return query select v_fecha, v_wod_id;
    return;
  end if;

  -- 3) Reiniciar ciclo si ya han salido todos
  select count(*) into v_usados from public.wod_diario;

  if v_usados >= total_wods then
    delete from public.wod_diario;
  end if;

  -- 4) Elegir aleatorio entre los que aún no han salido
  select g
    into v_wod_id
    from generate_series(1, total_wods) g
   where not exists (
     select 1 from public.wod_diario d where d.wod_id = g
   )
   order by random()
   limit 1;

  -- Salvaguarda: nunca debería llegar aquí tras el reset
  if v_wod_id is null then
    v_wod_id := floor(random() * total_wods)::bigint + 1;
  end if;

  insert into public.wod_diario (fecha, wod_id)
  values (v_fecha, v_wod_id)
  on conflict (fecha) do nothing;

  return query
    select w.fecha as wod_fecha, w.wod_id as wod_elegido
      from public.wod_diario w
     where w.fecha = v_fecha;
end;
$$;

grant execute on function public.obtener_wod_del_dia() to authenticated;

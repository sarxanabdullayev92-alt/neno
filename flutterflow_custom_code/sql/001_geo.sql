-- ============================================================
-- Миграция 001: геолокация мастеров, заказов и клиентов
-- Проект: nado_clean (клиент) + master_profi (мастер)
-- Существующие RLS-политики НЕ ТРОГАЕМ, чтобы не сломать
-- текущее приложение. Только добавляем.
-- ============================================================

begin;

-- ---------- 1. Колонки ----------

alter table public.masters
  add column if not exists latitude            double precision,
  add column if not exists longitude           double precision,
  add column if not exists city                text,
  add column if not exists is_online           boolean not null default false,
  add column if not exists heading             double precision,
  add column if not exists location_updated_at timestamptz;

alter table public.orders
  add column if not exists latitude  double precision,
  add column if not exists longitude double precision,
  add column if not exists city      text,
  add column if not exists address   text;

alter table public.profile
  add column if not exists latitude  double precision,
  add column if not exists longitude double precision,
  add column if not exists city      text;

-- ---------- 2. Индексы ----------

create index if not exists masters_city_online_idx
  on public.masters (city, is_online);
create index if not exists masters_user_profile_idx
  on public.masters (user_profile);
create index if not exists orders_city_status_idx
  on public.orders (city, "orderStatus");
create index if not exists orders_master_idx
  on public.orders ("mastersID");
create index if not exists orders_customer_idx
  on public.orders (customer_profile);

-- ---------- 3. Расстояние (haversine, PostGIS нет) ----------

create or replace function public.distance_km(
  lat1 double precision, lon1 double precision,
  lat2 double precision, lon2 double precision
) returns double precision
language sql immutable parallel safe as $fn$
  select case
    when lat1 is null or lon1 is null or lat2 is null or lon2 is null then null
    else 6371.0 * 2 * asin(least(1.0, sqrt(
      power(sin(radians(lat2 - lat1) / 2), 2)
      + cos(radians(lat1)) * cos(radians(lat2))
      * power(sin(radians(lon2 - lon1) / 2), 2)
    )))
  end;
$fn$;

-- ---------- 4. Мастера рядом (для карты клиента) ----------
-- Отсекает "призраков": мастеров, не обновлявших позицию > p_stale_minutes.
-- Телефон не отдаём: функция отвечает и неавторизованным (см. 004).
-- drop нужен, чтобы скрипт можно было запускать повторно:
-- create or replace не умеет менять набор возвращаемых колонок.

drop function if exists public.nearby_masters(
  double precision, double precision, text, double precision, int, int
);

create or replace function public.nearby_masters(
  p_lat           double precision,
  p_lng           double precision,
  p_city          text default null,
  p_radius_km     double precision default 50,
  p_limit         int default 50,
  p_stale_minutes int default 10
) returns table (
  id                  bigint,
  name                text,
  services            text,
  city                text,
  district            text,
  latitude            double precision,
  longitude           double precision,
  heading             double precision,
  location_updated_at timestamptz,
  distance_km         double precision
)
language sql stable security definer set search_path = public as $fn$
  select m.id, m.name, m.services, m.city, m.district,
         m.latitude, m.longitude, m.heading, m.location_updated_at,
         round(public.distance_km(p_lat, p_lng, m.latitude, m.longitude)::numeric, 2)::double precision
  from public.masters m
  where m.is_online = true
    and m.latitude is not null
    and m.longitude is not null
    and m.location_updated_at > now() - make_interval(mins => p_stale_minutes)
    and (p_city is null or lower(m.city) = lower(p_city))
    and public.distance_km(p_lat, p_lng, m.latitude, m.longitude) <= p_radius_km
  order by public.distance_km(p_lat, p_lng, m.latitude, m.longitude) asc
  limit p_limit;
$fn$;

grant execute on function public.nearby_masters(
  double precision, double precision, text, double precision, int, int
) to authenticated, anon;

-- ---------- 5. Позиция мастера (вызывает master_profi каждые 15 сек) ----------

create or replace function public.update_master_location(
  p_lat       double precision,
  p_lng       double precision,
  p_heading   double precision default null,
  p_is_online boolean default null,
  p_city      text default null
) returns void
language plpgsql security definer set search_path = public as $fn$
declare
  v_updated int;
begin
  if auth.uid() is null then
    raise exception 'not authenticated';
  end if;

  update public.masters m
     set latitude            = p_lat,
         longitude           = p_lng,
         heading             = coalesce(p_heading, m.heading),
         is_online           = coalesce(p_is_online, m.is_online),
         city                = coalesce(p_city, m.city),
         location_updated_at = now(),
         "currentLocation"   = p_lat::text || ',' || p_lng::text
   where m.user_profile = auth.uid();

  get diagnostics v_updated = row_count;
  if v_updated = 0 then
    raise exception 'no master row for current user';
  end if;
end;
$fn$;

grant execute on function public.update_master_location(
  double precision, double precision, double precision, boolean, text
) to authenticated;

-- ---------- 6. Смена вкл/выкл ----------

create or replace function public.set_master_online(p_online boolean)
returns void
language plpgsql security definer set search_path = public as $fn$
begin
  if auth.uid() is null then
    raise exception 'not authenticated';
  end if;
  update public.masters
     set is_online           = p_online,
         location_updated_at = case when p_online then now() else location_updated_at end
   where user_profile = auth.uid();
end;
$fn$;

grant execute on function public.set_master_online(boolean) to authenticated;

-- ---------- 7. Принять заказ (атомарно, без гонки между мастерами) ----------

create or replace function public.accept_order(p_order_id bigint)
returns public.orders
language plpgsql security definer set search_path = public as $fn$
declare
  v_master_id bigint;
  v_row       public.orders;
begin
  select m.id into v_master_id
    from public.masters m
   where m.user_profile = auth.uid()
   limit 1;

  if v_master_id is null then
    raise exception 'current user is not a master';
  end if;

  -- условие "mastersID is null" и делает захват атомарным:
  -- второй мастер получит 0 строк и ошибку "order already taken"
  update public.orders o
     set "mastersID"        = v_master_id,
         assignment_status  = 'accepted',
         "orderStatus"      = case
                                when coalesce(o."orderStatus", '') in ('', 'new')
                                  then 'accepted'
                                else o."orderStatus"
                              end
   where o.id = p_order_id
     and o."mastersID" is null
  returning * into v_row;

  if v_row.id is null then
    raise exception 'order already taken';
  end if;

  return v_row;
end;
$fn$;

grant execute on function public.accept_order(bigint) to authenticated;

-- ---------- 8. Свободные заказы для мастера ----------

create or replace function public.available_orders(
  p_lat       double precision default null,
  p_lng       double precision default null,
  p_radius_km double precision default 50,
  p_limit     int default 50
) returns table (
  id          bigint,
  created_at  timestamptz,
  address     text,
  city        text,
  latitude    double precision,
  longitude   double precision,
  total_cost  real,
  date_of_service timestamptz,
  distance_km double precision
)
language sql stable security definer set search_path = public as $fn$
  select o.id, o.created_at, o.address, o.city, o.latitude, o.longitude,
         o."total_Cost", o.date_of_service,
         round(public.distance_km(p_lat, p_lng, o.latitude, o.longitude)::numeric, 2)::double precision
  from public.orders o
  where o."mastersID" is null
    and coalesce(o.assignment_status, '') not in ('cancelled', 'accepted')
    and (
      p_lat is null or p_lng is null
      or o.latitude is null or o.longitude is null
      or public.distance_km(p_lat, p_lng, o.latitude, o.longitude) <= p_radius_km
    )
  order by o.created_at desc
  limit p_limit;
$fn$;

grant execute on function public.available_orders(
  double precision, double precision, double precision, int
) to authenticated;

-- ---------- 9. Realtime ----------
-- masters -> живое движение маркеров у клиента
-- orders  -> алерт мастеру о новом заказе

alter table public.masters replica identity full;
alter table public.orders  replica identity full;

do $do$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'masters'
  ) then
    alter publication supabase_realtime add table public.masters;
  end if;

  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'orders'
  ) then
    alter publication supabase_realtime add table public.orders;
  end if;
end
$do$;

commit;

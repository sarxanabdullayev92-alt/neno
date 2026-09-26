-- ============================================================
-- Миграция 004: убрать телефон из выдачи карты
--
-- nearby_masters — security definer, поэтому она отвечает даже
-- неавторизованному клиенту. Телефон мастера на карте не нужен:
-- он требуется только после того, как заказ принят.
-- ============================================================

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

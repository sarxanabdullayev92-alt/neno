-- ============================================================
-- Миграция 005: статус заказа при принятии
--
-- Было: orderStatus менялся на 'accepted' только если был пустым.
-- Приложение клиента создаёт заказ со статусом 'new', поэтому после
-- принятия он оставался 'new' и клиент не видел, что мастер едет.
-- Теперь 'new' и пустой статус оба переходят в 'accepted'.
-- ============================================================

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
     set "mastersID"       = v_master_id,
         assignment_status = 'accepted',
         "orderStatus"     = case
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

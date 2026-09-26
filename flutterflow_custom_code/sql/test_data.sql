-- ============================================================
-- ТЕСТОВЫЕ ДАННЫЕ ДЛЯ КАРТЫ (не миграция)
--
-- Демо-мастера без аккаунтов. Телефоны начинаются с +7900 —
-- по ним их можно найти и удалить (блок в конце файла).
--
-- location_updated_at ставится на год вперёд: карта отсекает мастеров,
-- чья позиция старше 10 минут, а демо-мастера позицию сами не обновляют.
-- Так они видны на карте всегда, пока их не удалят.
-- ============================================================

begin;

-- ---------- Москва: оживить существующих демо-мастеров ----------
update public.masters
   set is_online = true,
       location_updated_at = now() + interval '365 days'
 where phonenumber in ('+79001112233', '+79002223344', '+79003334455', '+79005556677')
   and user_profile is null;

-- ---------- Москва: тестовые мастера по районам ----------
-- Создаются, только если их ещё нет — файл можно запускать повторно.
insert into public.masters
  (name, services, city, district, phonenumber, latitude, longitude,
   is_online, location_updated_at)
select v.name, v.services, 'Москва', v.district, v.phone,
       v.lat, v.lng, true, now() + interval '365 days'
from (values
  ('Тест Москва — Тверская',      'Химчистка мебели',   'ЦАО', '+79007770011', 55.7650, 37.6050),
  ('Тест Москва — Арбат',         'Химчистка ковров',   'ЦАО', '+79007770012', 55.7520, 37.5920),
  ('Тест Москва — Таганка',       'Химчистка матрасов', 'ЦАО', '+79007770013', 55.7400, 37.6530),
  ('Тест Москва — Замоскворечье', 'Химчистка штор',     'ЦАО', '+79007770014', 55.7350, 37.6280),
  ('Тест Москва — Сокольники',    'Химчистка мебели',   'ВАО', '+79007770015', 55.7890, 37.6790),
  ('Тест Москва — Хамовники',     'Химчистка ковров',   'ЦАО', '+79007770016', 55.7290, 37.5700)
) as v(name, services, district, phone, lat, lng)
where not exists (
  select 1 from public.masters m where m.phonenumber = v.phone
);

-- ---------- Баку: демо-мастера рядом с местом проверки в Test Mode ----------
-- city = 'Москва', потому что карта клиента фильтрует по App State city.
-- Это только для теста: иначе фильтр по городу их отсечёт.
insert into public.masters
  (name, services, city, district, phonenumber, latitude, longitude,
   is_online, location_updated_at)
select v.name, 'Химчистка мебели', 'Москва', 'Тест Баку', v.phone,
       v.lat, v.lng, true, now() + interval '365 days'
from (values
  ('Тест Баку — Центр',     '+79007770001', 40.4093, 49.8671),
  ('Тест Баку — Ясамал',    '+79007770002', 40.3953, 49.8130),
  ('Тест Баку — Нариманов', '+79007770003', 40.4190, 49.9180),
  ('Тест Баку — Хатаи',     '+79007770004', 40.3860, 49.9480)
) as v(name, phone, lat, lng)
where not exists (
  select 1 from public.masters m where m.phonenumber = v.phone
);

commit;

select name, city, is_online, round(latitude::numeric, 4) lat,
       round(longitude::numeric, 4) lng
  from public.masters
 where phonenumber like '+7900%' and is_online
 order by name;

-- ============================================================
-- УДАЛИТЬ ТЕСТОВЫЕ ДАННЫЕ (выполнить вручную, когда не нужны):
--
--   delete from public.masters where phonenumber like '+7900%' and user_profile is null;
--
-- Тестовый аккаунт мастера test.master@nadoclean.ru (пароль MasterTest2026!)
-- создан 14.09 через admin API, к нему привязаны profile и masters (id 11).
-- Удалить вместе со строками:
--
--   delete from public.masters where user_profile =
--     (select id from auth.users where email = 'test.master@nadoclean.ru');
--   delete from public.profile where email = 'test.master@nadoclean.ru';
--   delete from auth.users where email = 'test.master@nadoclean.ru';
-- ============================================================

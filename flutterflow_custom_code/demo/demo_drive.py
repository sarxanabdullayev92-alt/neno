#!/usr/bin/env python3
"""
Демонстрация карты: тестовый мастер «едет» к клиенту по реальному маршруту.

Лежит на сервере: /opt/geo/demo/demo_drive.py
Нужен только для показа — в приложение не входит.

Что делает:
  1. ставит «Тест Мастера» (masters.id = 11) в стартовую точку в Москве;
  2. создаёт демо-заказ с фиксированным id 900001 (адрес клиента в Москве);
  3. строит маршрут через ваш OSRM и каждые 15 секунд сдвигает мастера
     по этой линии к клиенту — приложения видят движение через Realtime.

Режимы:
  client  — заказ сразу «принят» мастером; мастер начинает ехать.
            Для показа экрана КЛИЕНТА (MapPage, кнопка «Демо»).
            В конце заказ получает статус done — карта клиента возвращается
            к списку мастеров.
  master  — заказ создаётся свободным: у мастера на WorkMain (смена включена)
            сама откроется OrderOffer. Скрипт ждёт, пока нажмут «ПРИНЯТЬ»,
            и только потом везёт мастера. Для показа экрана МАСТЕРА.
  reset   — убрать демо-заказ, мастера снять со смены.

Примеры:
  python3 demo_drive.py client
  python3 demo_drive.py master --minutes 4
  python3 demo_drive.py reset
"""

import argparse
import json
import math
import subprocess
import sys
import time
import urllib.request

MASTER_ID = 11
ORDER_ID = 900001
CLIENT_EMAIL = "abdullayevsarxan92@gmail.com"

# Клиент — Манежная площадь; мастер стартует из Сокольников (~6 км по дорогам)
CLIENT = (55.7560, 37.6150)
START = (55.7890, 37.6790)

OSRM = "https://ugitubelnid.beget.app/route/v1/driving"


def sql(query: str) -> str:
    """Выполнить SQL в контейнере базы и вернуть вывод без форматирования."""
    res = subprocess.run(
        ["docker", "exec", "supabase-db", "psql", "-U", "supabase_admin",
         "-d", "postgres", "-v", "ON_ERROR_STOP=1", "-Atc", query],
        capture_output=True, text=True,
    )
    if res.returncode != 0:
        sys.exit(f"SQL ошибка: {res.stderr.strip()}")
    return res.stdout.strip()


def log(text: str) -> None:
    print(time.strftime("[%H:%M:%S] ") + text, flush=True)


def route_points(a, b):
    """Геометрия маршрута OSRM: список (lat, lng) и длина в метрах."""
    url = (f"{OSRM}/{a[1]},{a[0]};{b[1]},{b[0]}"
           "?overview=full&geometries=geojson")
    with urllib.request.urlopen(url, timeout=15) as r:
        body = json.load(r)
    if body.get("code") != "Ok":
        sys.exit(f"OSRM не построил маршрут: {body.get('code')}")
    route = body["routes"][0]
    pts = [(c[1], c[0]) for c in route["geometry"]["coordinates"]]
    return pts, route["distance"]


def haversine(p, q):
    r = 6371000.0
    dlat = math.radians(q[0] - p[0])
    dlng = math.radians(q[1] - p[1])
    a = (math.sin(dlat / 2) ** 2 + math.cos(math.radians(p[0]))
         * math.cos(math.radians(q[0])) * math.sin(dlng / 2) ** 2)
    return 2 * r * math.asin(min(1.0, math.sqrt(a)))


def point_at(pts, cum, dist):
    """Точка на ломаной на расстоянии dist от начала + направление движения."""
    if dist <= 0:
        return pts[0], 0.0
    for i in range(1, len(pts)):
        if cum[i] >= dist:
            seg = cum[i] - cum[i - 1] or 1.0
            t = (dist - cum[i - 1]) / seg
            p, q = pts[i - 1], pts[i]
            lat = p[0] + (q[0] - p[0]) * t
            lng = p[1] + (q[1] - p[1]) * t
            heading = math.degrees(math.atan2(q[1] - p[1], q[0] - p[0])) % 360
            return (lat, lng), heading
    return pts[-1], 0.0


def place_master(lat, lng, heading=None, online=True):
    h = "null" if heading is None else f"{heading:.1f}"
    sql(f"""update public.masters
               set latitude = {lat:.7f}, longitude = {lng:.7f}, heading = {h},
                   is_online = {str(online).lower()}, city = 'Москва',
                   location_updated_at = now(),
                   "currentLocation" = '{lat:.7f},{lng:.7f}'
             where id = {MASTER_ID}""")


def create_order(accepted: bool):
    sql(f"delete from public.orders where id = {ORDER_ID}")
    master = MASTER_ID if accepted else "null"
    status = "accepted" if accepted else "new"
    assignment = "'accepted'" if accepted else "null"
    sql(f"""insert into public.orders
              (id, customer_profile, city, address, latitude, longitude,
               "orderStatus", assignment_status, "mastersID",
               "total_Cost", date_of_service)
            select {ORDER_ID}, u.id, 'Москва', 'Демо: Манежная площадь, 1',
                   {CLIENT[0]}, {CLIENT[1]}, '{status}', {assignment}, {master},
                   6500, now()
              from auth.users u where u.email = '{CLIENT_EMAIL}'""")


def order_master() -> str:
    return sql(f'select coalesce("mastersID"::text, \'\') '
               f'from public.orders where id = {ORDER_ID}')


def drive(minutes: float, step_seconds: float, finish: bool):
    pts, meters = route_points(START, CLIENT)
    cum = [0.0]
    for i in range(1, len(pts)):
        cum.append(cum[-1] + haversine(pts[i - 1], pts[i]))
    total = cum[-1]

    steps = max(2, int(round(minutes * 60 / step_seconds)))
    log(f"маршрут {meters / 1000:.1f} км, {steps} шагов по {step_seconds:.0f} сек")

    for s in range(steps + 1):
        (lat, lng), heading = point_at(pts, cum, total * s / steps)
        place_master(lat, lng, heading)
        left = (total - total * s / steps) / 1000
        log(f"шаг {s}/{steps}: осталось {left:.1f} км")
        if s < steps:
            time.sleep(step_seconds)

    log("мастер приехал")
    if finish:
        time.sleep(20)
        sql(f"update public.orders set \"orderStatus\" = 'done' where id = {ORDER_ID}")
        place_master(CLIENT[0], CLIENT[1], online=False)
        log("заказ завершён (done), мастер снят со смены")


def main():
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("mode", choices=["client", "master", "reset"])
    ap.add_argument("--minutes", type=float, default=5.0,
                    help="сколько длится поездка (по умолчанию 5)")
    ap.add_argument("--step", type=float, default=15.0,
                    help="интервал обновления позиции, сек (по умолчанию 15)")
    ap.add_argument("--no-finish", action="store_true",
                    help="не завершать заказ по приезду (режим client)")
    ap.add_argument("--wait", type=float, default=10.0,
                    help="сколько минут ждать «ПРИНЯТЬ» в режиме master")
    args = ap.parse_args()

    if args.mode == "reset":
        sql(f"delete from public.orders where id = {ORDER_ID}")
        sql(f"update public.masters set is_online = false where id = {MASTER_ID}")
        log("демо-заказ удалён, мастер снят со смены")
        return

    place_master(*START)
    log(f"мастер id={MASTER_ID} в стартовой точке {START}")

    if args.mode == "client":
        create_order(accepted=True)
        log(f"заказ {ORDER_ID} создан и принят мастером — едем")
        drive(args.minutes, args.step, finish=not args.no_finish)
        return

    # master: свободный заказ → в приложении мастера откроется OrderOffer
    create_order(accepted=False)
    log(f"заказ {ORDER_ID} создан свободным — нажмите «ПРИНЯТЬ ЗАКАЗ» в приложении мастера")
    deadline = time.time() + args.wait * 60
    last_refresh = time.time()
    while time.time() < deadline:
        if order_master() == str(MASTER_ID):
            log("заказ принят — едем")
            drive(args.minutes, args.step, finish=False)
            log("нажмите «ЗАВЕРШИТЬ РАБОТУ» в приложении мастера")
            return
        # пока ждём — раз в минуту освежаем позицию, чтобы мастер не пропал
        # с карт (карта отсекает точки старше 10 минут)
        if time.time() - last_refresh > 60:
            place_master(*START)
            last_refresh = time.time()
        time.sleep(3)
    log("заказ так и не приняли — демо остановлено")


if __name__ == "__main__":
    main()

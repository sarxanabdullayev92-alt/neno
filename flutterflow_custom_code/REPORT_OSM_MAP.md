# OpenStreetMap Integration — Work Report & Setup Guide

**Project:** Nado Clean — client app (`nado_clean`) and master/worker app (`master_profi`)
**Stack:** FlutterFlow (Flutter), self-hosted Supabase, OpenStreetMap, OSRM
**Date:** September 2026

---

## 1. Summary

A live map was added to both apps, based on the client's requirements:

| Requirement | Result |
|---|---|
| Before ordering, the client sees available workers nearby on the map | ✅ Worker markers around the client, filtered by city, within 50 km, up to 50 nearest |
| When an order is created, all workers of that city are alerted | ✅ Real-time "new order" alert opens the order offer screen |
| After a worker accepts, a route line is drawn from worker to client — on both apps | ✅ Road route with distance and ETA ("7.8 km · 18 min") |
| Worker position updates regularly (15 s preferred, "not laggy") | ✅ Every 15 s during an active order, with smooth marker animation between updates |
| Filter by city (the only filter agreed for now) | ✅ |

Everything runs on our own server — no Google Maps, no paid map APIs.

---

## 2. Architecture

```
 MASTER APP                        SUPABASE (self-hosted)                 CLIENT APP
 ──────────                        ──────────────────────                 ──────────
 Shift ON ──► position every      masters (lat, lng, is_online)   ◄── nearby_masters() every 25 s
             60 s / 15 s ───────►        │  Realtime                     (city + 50 km + 50 nearest)
                                         └──────────────────────────►  assigned worker moves live
 new-order alert  ◄── Realtime ── orders (lat, lng, city, status) ◄── order created
 "Accept" ──► accept_order() ────► mastersID, status = accepted ──►  "worker is coming"

                     OUR SERVER (same host)
                     ├─ /tiles/{z}/{x}/{y}.png   OpenStreetMap tile cache (nginx)
                     └─ /route/v1/driving/...    OSRM road routing (distance, ETA, line)
```

**Economy scheme** (keeps server load low as users grow):

| Situation | Update rate |
|---|---|
| Worker on shift, no order | position sent every 60 s |
| Worker driving to a client | position sent every 15 s |
| Client's overview map | worker list refreshed every 25 s |
| Route line | recalculated every 60 s; the marker moves along it in between |

---

## 3. Server: OpenStreetMap infrastructure

Server: self-hosted Supabase host (Beget VPS), domain `ugitubelnid.beget.app`.
RAM was upgraded to 8 GB; a 6 GB swap file was added as protection against memory spikes.

### 3.1. Map tiles — caching proxy

| | |
|---|---|
| Public URL | `https://ugitubelnid.beget.app/tiles/{z}/{x}/{y}.png` |
| Container | `osm-tiles` (nginx) |
| Config | `/opt/geo/nginx/tiles.conf` |
| Cache | up to 4 GB on disk, tiles kept 60 days |

Why a proxy instead of calling openstreetmap.org directly: the public OSM tile server
forbids heavy commercial use and blocks apps. The proxy sends a proper User-Agent and
serves repeated tiles from cache, so each tile is downloaded from OSM only once.

Fix applied: OSM already sends a CORS header, and the proxy added a second one.
Browsers reject duplicated CORS headers, so the map was blank in the web version /
FlutterFlow Test Mode. The upstream headers are now hidden — a single header is returned.

### 3.2. Road routing — OSRM

| | |
|---|---|
| Public URL | `https://ugitubelnid.beget.app/route/v1/driving/{lng},{lat};{lng},{lat}` |
| Container | `osrm` (osrm-backend, MLD algorithm, car profile) |
| Data | `/opt/osrm` — Moscow + Moscow Oblast |
| Rebuild script | `/opt/osrm/build.sh` |

Map data: Central Federal District extract from Geofabrik, cropped to
Moscow + Moscow Oblast (bbox `35.10,54.20 – 40.30,56.96`) so it fits the server memory.
**Routes are built only inside this area.** To add another city, the region must be
re-extracted and rebuilt (10–15 min).

### 3.3. Reverse proxy (Caddy)

Routes `/tiles/*` and `/route/*` were added to the existing Supabase Caddyfile,
**before** the dashboard basic-auth block, so the apps can reach them without a password.
Both containers live in `/opt/geo/docker-compose.yml`, join the Supabase Docker network
and restart automatically.

---

## 4. Database (Supabase)

All changes are idempotent SQL migrations stored in `flutterflow_custom_code/sql/`.
Existing RLS policies were not modified.

### 4.1. New columns

| Table | Columns |
|---|---|
| `masters` | `latitude`, `longitude`, `city`, `is_online`, `heading`, `location_updated_at` |
| `orders` | `latitude`, `longitude`, `city`, `address` |
| `profile` | `latitude`, `longitude`, `city` |

Plus indexes on `masters(city, is_online)`, `masters(user_profile)`,
`orders(city, orderStatus)`, `orders(mastersID)`, `orders(customer_profile)`.

### 4.2. Functions (RPC)

| Function | Purpose |
|---|---|
| `nearby_masters(lat, lng, city, radius_km, limit)` | Online workers near a point: same city, within radius, nearest first. Workers whose position is older than **10 minutes** are hidden (no "ghost" markers). Phone numbers are **not** returned. |
| `update_master_location(lat, lng, heading, is_online, city)` | Worker sends own position. Only the logged-in worker's row can be updated. |
| `set_master_online(online)` | Shift on / off. |
| `accept_order(order_id)` | Accept an order **atomically**: if two workers press "Accept" at the same moment, the second gets `order already taken`. Moves status `new` → `accepted`. |
| `available_orders(lat, lng, radius_km, limit)` | Free orders near a worker (available for future use). |
| `distance_km(lat1, lng1, lat2, lng2)` | Straight-line distance (haversine). |

### 4.3. Real-time

Realtime publication enabled for `masters` (live marker movement) and `orders`
(new-order alerts, acceptance/status updates).

### 4.4. Bugs fixed in the existing schema

- **Missing auto-increment on `id`** in `masters`, `orders`, `options`, `price`, `services` —
  any insert without an explicit id failed, so **orders and workers could not be created at all**.
  Now `generated by default as identity`.
- `accept_order` left the status as `new` → fixed to `accepted`.

### 4.5. Storage

Marker icons are loaded from the public Storage bucket **`notRemoveAssetsForMap`**:
`client.png` (client pin) and `mastericon.jpg` (worker). FlutterFlow did not bundle
Media Assets into the build, so the icons are referenced by URL.
**Do not delete or rename this bucket or its files.**

### 4.6. Migration files

| File | Content |
|---|---|
| `001_geo.sql` | columns, indexes, functions, Realtime |
| `002_identity.sql` | auto-increment ids |
| `004_hide_phone.sql` | phone removed from `nearby_masters` |
| `005_accept_status.sql` | `new` → `accepted` on accept |
| `test_data.sql` | test workers (not a migration; includes cleanup commands) |

---

## 5. Front-end (FlutterFlow custom code)

All code is in `flutterflow_custom_code/` and was added to FlutterFlow manually as
Custom Widget / Actions / Functions. The same files are used in both projects.

### 5.1. Dependencies (both projects)

```
flutter_map: 8.1.1
latlong2: 0.9.1
geolocator: 14.0.2
```

These exact versions are required — newer ones conflict with FlutterFlow's pinned packages
(`flutter_map 8.2+` needs a newer `path_provider`; `geolocator 14.0.3` needs Dart 3.10).

### 5.2. Custom Widget — `OsmMapWidget`

One widget for every map in both apps. Behaviour is controlled by parameters.

**Features**

- OpenStreetMap tiles from our server, OSM attribution
- Worker markers (`mastericon.jpg`), client pin (`client.png`), fallback icons if offline
- Smooth marker movement between position updates
- Auto-loading of nearby workers (city + radius + limit), refresh every 25 s
- Live tracking of one assigned worker via Realtime
- Road route line + distance/ETA badge, recalculated every 60 s
- Camera auto-fit to show worker, client and route
- Address picking mode: fixed pin in the centre, returns the point under it
- Built-in **+ / − / my location** buttons
- Worker's home map automatically shows the active order (client pin, route, km) until the order is done
- Client's overview map shows the client's own position with the client icon
- Point `0,0` is treated as "not set" (FlutterFlow's default for numbers)

**Parameters** (all nullable)

| Parameter | Type | Meaning |
|---|---|---|
| `width`, `height` | Double | size |
| `centerLat`, `centerLng` | Double | map centre / own position |
| `initialZoom` | Double | default 12 |
| `autoLoadMasters` | Boolean | load nearby workers automatically |
| `city` | String | city filter, e.g. `Москва` |
| `radiusKm` | Double | default 50 |
| `maxMasters` | Integer | default 50 |
| `refreshSeconds` | Integer | default 25 |
| `mastersJson` | String | manual worker list (if not auto-loading) |
| `trackMasterId` | Integer | worker to follow live |
| `clientLat`, `clientLng` | Double | client / order address |
| `showRoute` | Boolean | draw route worker → client |
| `pickLocation` | Boolean | address picking mode |
| `meLat`, `meLng` | Double | own position (optional) |
| `masterImagePath` | String | custom worker icon URL (optional) |
| `tileUrlTemplate`, `osrmBaseUrl` | String | override server URLs (optional) |

**Callbacks** (type *Action*)

| Callback | Parameter | Meaning |
|---|---|---|
| `onMasterTap` | `masterId` Integer | worker marker tapped |
| `onRouteInfo` | `route` Double, **Is List** | `route[0]` = km, `route[1]` = minutes |
| `onCenterChanged` | `point` Double, **Is List** | `point[0]` = latitude, `point[1]` = longitude |

> Callbacks use a single list parameter on purpose: FlutterFlow confuses two callback
> parameters of the same type (it passes the first one into both fields).

### 5.3. Custom Actions

| Action | App | Purpose |
|---|---|---|
| `getMyLocation` → `List<double>?` | both | device GPS `[lat, lng]`, asks for permission |
| `setMasterTracking(enabled, intervalSeconds, city, setOnline)` | worker | start/stop sending position; one timer, safe to call repeatedly |
| `acceptOrder(orderId)` → `String?` | worker | `ok` / `taken` / `notmaster` / `error` |
| `subscribeNewOrders(enabled, city, onNewOrder)` | worker | real-time alert for new orders in the city |
| `getRouteInfo(fromLat, fromLng, toLat, toLng)` → `List<double>?` | both | road `[km, minutes]` without a map |
| `subscribeMyOrder(enabled, orderId, onAccepted, onStatusChanged)` | client | notified when a worker accepts / status changes |
| `loadNearbyMasters(...)` → `String?` | client | worker list as JSON (optional) |

### 5.4. Custom Functions

| Function | Example |
|---|---|
| `formatDistance(km)` | `0.85` → `850 м`, `12.44` → `12,4 км` |
| `formatMinutes(min)` | `11.6` → `~12 мин`, `75` → `~1 ч 15 мин` |
| `distanceKm(lat1, lng1, lat2, lng2)` | straight-line km |
| `parseCoord(text, wantLatitude)` | parse legacy `"55.75, 37.61"` strings |

### 5.5. FlutterFlow issues found and solved

| Issue | Solution |
|---|---|
| Widget did not compile inside FlutterFlow: FlutterFlow's own `LatLng` clashed with `latlong2` | `latlong2` imported with prefix `as ll` |
| Two same-type callback parameters mixed up (`lng` received latitude) | single list parameters |
| Media Assets not included in the build | icons served from Supabase Storage |
| Blank map in Test Mode | duplicated CORS header removed on the tile server |
| Worker pages crashed ("Unexpected null value" in ButtonWidget) | button icons made conditional on `iconPresent` / `iconEndPresent` |
| Worker home page not rendering / not tappable | stray `Expanded` removed from the shift card |

---

## 6. FlutterFlow configuration (how it is wired)

### 6.1. Both projects

- **Supabase integration:** URL `https://ugitubelnid.beget.app`, anon key, *Get Schema*.
- **Permissions:** Location enabled. Android manifest must contain
  `ACCESS_FINE_LOCATION` and `ACCESS_COARSE_LOCATION`; iOS needs
  `NSLocationWhenInUseUsageDescription`.
- **Dependencies** from 5.1; custom code from section 5.

### 6.2. Client app (`nado_clean`)

**App State**

| Field | Type | Persisted | Default |
|---|---|---|---|
| `city` | String | ✓ | `Москва` |
| `myLat`, `myLng` | Double | | 0 |
| `orderLat`, `orderLng` | Double | ✓ | 0 |
| `orderAddress` | String | ✓ | |
| `activeOrderId` | Integer | ✓ | 0 |
| `activeMasterId` | Integer | ✓ | 0 |

**MapPage**

- *On Page Load:* `getMyLocation` → if not empty, `myLat` = item 0, `myLng` = item 1.
  Then (separately, not inside the location condition) if `activeOrderId > 0` →
  `subscribeMyOrder(true, activeOrderId, …)`:
  - `onAccepted` → `activeMasterId = masterId`, snackbar "Мастер принял заказ и едет к вам";
  - `onStatusChanged` → if `status == done` → `activeOrderId = 0`, `activeMasterId = 0`.
- **Map 1 — all workers**, visible when `activeMasterId == 0`:
  `autoLoadMasters = true`, `city = App State city`, `centerLat/Lng = myLat/myLng`,
  `radiusKm = 50`, `maxMasters = 50`, `refreshSeconds = 25`.
- **Map 2 — "worker is coming"**, visible when `activeMasterId > 0`:
  `trackMasterId = activeMasterId`, `clientLat/Lng = orderLat/orderLng`, `showRoute = true`,
  `onRouteInfo` → page state `routeKm = route[0]`, `routeMin = route[1]`;
  text: `formatDistance(routeKm)` + `formatMinutes(routeMin)`.

**SearchingForAddress**

- *On Page Load:* `getMyLocation` → `myLat` / `myLng`.
- Map: `pickLocation = true`, `centerLat/Lng = myLat/myLng`, `initialZoom = 16`,
  `onCenterChanged` → `orderLat = point[0]`, `orderLng = point[1]`.

**Order creation** *(outside the map scope — to be implemented by the app team)*

The map expects each order row to contain `latitude`, `longitude` (from `orderLat/orderLng`),
`city` (from App State) and `address`, with `orderStatus = new`; after insert set
App State `activeOrderId` to the new order id.

### 6.3. Worker app (`master_profi`)

**App State**

| Field | Type | Persisted | Default |
|---|---|---|---|
| `city` | String | ✓ | `Москва` |
| `myMasterId` | Integer | ✓ | 0 |
| `myLat`, `myLng` | Double | | 0 |
| `isOnShift` | Boolean | ✓ | false |
| `activeOrderId` | Integer | ✓ | 0 |

**Auth1**

- *Register:* create account → insert `profile` (id = user id) → insert `masters`
  (`user_profile` = user id, `city`, `services` — required) → `myMasterId = new id`.
  Order matters: `profile` first, because `masters.user_profile` references it.
- *Login:* query `masters` where `user_profile = user id` → if not empty,
  `myMasterId = first.id`.

**WorkMain**

- *On Page Load:* `getMyLocation` → `myLat/myLng`. Then, separately, if `isOnShift`:
  `setMasterTracking(true, 60, city, true)`; if `activeOrderId > 0` →
  `setMasterTracking(true, 15, city, true)`; `subscribeNewOrders(true, city,
  onNewOrder → Navigate to OrderOffer(orderId))`.
- *Shift switch:* ON → `isOnShift = true`, `setMasterTracking(true, 60, …)`,
  `subscribeNewOrders(true, …)`; OFF → `isOnShift = false`,
  `setMasterTracking(false, …)`, `subscribeNewOrders(false, …)`.
- Map: `trackMasterId = myMasterId`, `centerLat/Lng = myLat/myLng`, `initialZoom = 14`,
  no `clientLat/Lng`. While an order is active the map finds it and shows client + route itself.

**OrderOffer** (page parameter `orderId`)

- *On Page Load:* `getMyLocation`, query order by id → `getRouteInfo(my position → order)`
  → page state `routeKm`, `routeMin`; texts via `formatDistance` / `formatMinutes`.
- *Accept:* `acceptOrder(orderId)` → if `ok`: `activeOrderId = orderId`,
  `setMasterTracking(true, 15, …)`, navigate to `ActiveOrderDetail(orderId)`;
  otherwise show a snackbar.

**ActiveOrderDetail** (page parameter `orderId`)

- Map: `trackMasterId = myMasterId`, `clientLat/Lng` from the order, `showRoute = true`.
- *Finish work:* update order `orderStatus = done` → `setMasterTracking(true, 60, …)` →
  `activeOrderId = 0` → navigate to WorkMain.

---

## 7. How to verify

### 7.1. Server (from any computer)

```bash
# Map tile — expect HTTP 200, image/png
curl -I https://ugitubelnid.beget.app/tiles/12/2474/1283.png

# Route Kremlin → Sheremetyevo — expect "code":"Ok", ~29 km
curl "https://ugitubelnid.beget.app/route/v1/driving/37.6173,55.7558;37.4146,55.9726?overview=false"
```

### 7.2. Test data

| | |
|---|---|
| Test worker account | `test.master@nadoclean.ru` / `MasterTest2026!` (masters.id 11) |
| Test workers on the map | 10 in Moscow, 4 in Baku — always visible |
| Cleanup | commands at the end of `sql/test_data.sql` |

> With geolocation denied the client map centres on Moscow and shows the Moscow workers.
> Routes can only be built inside Moscow + Moscow Oblast (see 3.2).

### 7.3. Checklist in the apps (FlutterFlow Test Mode or phones)

| # | Who | Action | Expected |
|---|---|---|---|
| 1 | Worker | Log in with the test account, allow location, turn **Shift** on | own marker on the map |
| 2 | Client | Open MapPage | client icon at own position, worker icons around |
| 3 | Client | Tap **+ / − / my location** | zoom changes, map returns to own position |
| 4 | Worker | Receive a new order | OrderOffer opens automatically |
| 5 | Worker | Press **Accept** | ActiveOrderDetail: worker, client pin, route line, km · min |
| 6 | Worker | Go back to home | home map still shows client, route and km |
| 7 | Client | — | map switches to "worker is coming" with the route |
| 8 | Worker | Moves | client sees the marker move every 15 s; the line gets shorter |
| 9 | Worker | **Finish work** | both maps return to normal within ~30 s |
| 10 | Worker | Turn **Shift** off | worker disappears from the client map within ~25 s |

### 7.4. Demo without a real order

A server script simulates a worker driving to a client — useful for showing the feature:

```bash
cd /opt/geo/demo
python3 demo_drive.py master   # creates a free order → worker app shows the offer → press Accept → worker drives
python3 demo_drive.py client   # order accepted automatically → worker drives 7.8 km in ~5 min → order done
python3 demo_drive.py reset    # remove the demo order
```

The worker's home map and ActiveOrderDetail show the full picture (worker, client, route, km)
with no extra configuration.

### 7.5. Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| Map is grey / blank | no internet, or old cached tiles in the browser | open Test Mode in incognito |
| No workers on the client map | no worker on shift in this city within 50 km, or position older than 10 min | turn Shift on; check `city` matches exactly (`Москва`) |
| Worker's own marker missing | account is not a worker (no `masters` row), or no GPS | log in with a worker account; test GPS on a phone |
| "Геолокация недоступна" in Test Mode | browser blocks location inside the Test Mode frame | expected; test location on a real device |
| No route line | order has no coordinates, or points outside Moscow region | fill `orderLat/orderLng`; extend OSRM region |
| Plain blue circle instead of the worker icon | Storage bucket file missing / no network | restore `notRemoveAssetsForMap` files |

---

## 8. Known limitations & recommendations

1. **Background tracking.** Position is sent while the worker app is open (or briefly
   minimised). Android stops timers when the app is closed — continuous tracking with the
   screen off requires a foreground service.
2. **Routing region.** OSRM covers Moscow + Moscow Oblast only. New cities require
   extending the extract.
3. **Security (RLS).** The original FlutterFlow policies allow any logged-in user to read,
   update and delete any order or profile. This was left untouched to avoid breaking the
   app, but **must be tightened before production release**.
4. **Order creation** in the client app (ProductDetails "Order" button, address confirmation)
   is outside the map scope and still needs to be implemented; the map is ready for it (see 6.2).
5. **Test data.** Remove the test workers, demo order and test account before release
   (`sql/test_data.sql`).
6. **City filter.** The client map searches within 50 km of the client. When more cities are
   added, centring the search on the selected city will need a small widget update.

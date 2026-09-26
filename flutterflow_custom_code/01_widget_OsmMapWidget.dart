// ============================================================================
// FlutterFlow → Custom Code → Custom Widgets → + Add
// Имя виджета: OsmMapWidget
// Ставится в ОБА проекта: nado_clean (клиент) и master_profi (мастер)
//
// Зависимости (Custom Code → Dependencies):
//   flutter_map: 8.1.1
//   latlong2: 0.9.1
//   geolocator: 14.0.2   (для кнопки «моё местоположение»)
//
// Кнопки «+», «−» и «моё местоположение» встроены в карту справа —
// отдельные кнопки на странице не нужны.
//
// Параметры виджета (Custom Widget → Parameters), все Nullable:
//   width              double
//   height             double
//   centerLat          double     центр карты
//   centerLng          double
//   initialZoom        double     по умолчанию 12
//   autoLoadMasters    bool       сам грузит мастеров через RPC nearby_masters
//   city               String     фильтр по городу, напр. "Москва"
//   radiusKm           double     радиус поиска, по умолчанию 50
//   maxMasters         int        сколько максимум показать, по умолчанию 50
//   refreshSeconds     int        как часто обновлять список, по умолчанию 25
//   mastersJson        String     если autoLoadMasters = false, передать JSON вручную
//   trackMasterId      int        id назначенного мастера → Realtime каждые 15 сек
//   clientLat          double     маркер клиента / адрес заказа
//   clientLng          double
//   showRoute          bool       строить маршрут от мастера к клиенту
//   tileUrlTemplate    String     по умолчанию тайлы вашего сервера
//   osrmBaseUrl        String     по умолчанию OSRM вашего сервера
//   masterImagePath    String     ссылка или asset; по умолчанию kMasterIconUrl
//   meLat              double     своя позиция (в приложении мастера)
//   meLng              double
//   pickLocation       bool       режим выбора адреса: булавка в центре карты
//
// Callbacks (Custom Widget → Parameters → тип Action):
//   onMasterTap        Action с параметром masterId (int)
//   onRouteInfo        Action с ОДНИМ параметром route (Double, Is List ✓):
//                      route[0] = км по дорогам, route[1] = минут в пути
//   onCenterChanged    Action с ОДНИМ параметром point (Double, Is List ✓):
//                      point[0] = широта, point[1] = долгота;
//                      вызывается, когда пользователь отпустил карту
//
//   Почему списки, а не два Double: FlutterFlow не различает два параметра
//   callback одного типа и в оба поля подставляет первый. С одним
//   параметром-списком значения выбираются по индексу и не путаются.
// ============================================================================

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart' as geo;
// Префикс ll обязателен: FlutterFlow сам подключает свой LatLng
// (через supabase.dart и flutter_flow_util.dart), и без префикса
// имя конфликтует с LatLng из latlong2 — код не компилируется.
import 'package:latlong2/latlong.dart' as ll;
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

/// Адреса ваших сервисов. Меняются в одном месте.
const String kDefaultTileUrl =
    'https://ugitubelnid.beget.app/tiles/{z}/{x}/{y}.png';
const String kDefaultOsrmBase = 'https://ugitubelnid.beget.app';

/// Иконки маркеров лежат в Supabase Storage, а не в assets:
/// FlutterFlow не всегда кладёт загруженные медиафайлы в сборку.
/// Бакет notRemoveAssetsForMap — не удалять.
const String kClientIconUrl =
    'https://ugitubelnid.beget.app/storage/v1/object/public/notRemoveAssetsForMap/client.png';
const String kMasterIconUrl =
    'https://ugitubelnid.beget.app/storage/v1/object/public/notRemoveAssetsForMap/mastericon.jpg';

class OsmMapWidget extends StatefulWidget {
  const OsmMapWidget({
    super.key,
    this.width,
    this.height,
    this.centerLat,
    this.centerLng,
    this.initialZoom,
    this.autoLoadMasters,
    this.city,
    this.radiusKm,
    this.maxMasters,
    this.refreshSeconds,
    this.mastersJson,
    this.trackMasterId,
    this.clientLat,
    this.clientLng,
    this.showRoute,
    this.tileUrlTemplate,
    this.osrmBaseUrl,
    this.masterImagePath,
    this.meLat,
    this.meLng,
    this.pickLocation,
    this.onMasterTap,
    this.onRouteInfo,
    this.onCenterChanged,
  });

  final double? width;
  final double? height;
  final double? centerLat;
  final double? centerLng;
  final double? initialZoom;
  final bool? autoLoadMasters;
  final String? city;
  final double? radiusKm;
  final int? maxMasters;
  final int? refreshSeconds;
  final String? mastersJson;
  final int? trackMasterId;
  final double? clientLat;
  final double? clientLng;
  final bool? showRoute;
  final String? tileUrlTemplate;
  final String? osrmBaseUrl;
  final String? masterImagePath;
  final double? meLat;
  final double? meLng;
  final bool? pickLocation;
  final Future Function(int masterId)? onMasterTap;
  final Future Function(List<double> route)? onRouteInfo;
  final Future Function(List<double> point)? onCenterChanged;

  @override
  State<OsmMapWidget> createState() => _OsmMapWidgetState();
}

// ---------------------------------------------------------------------------
// Маркер мастера с плавным движением.
// Позиция не прыгает: между двумя обновлениями маркер едет по прямой.
// ---------------------------------------------------------------------------
class _MasterPin {
  _MasterPin({
    required this.id,
    required this.name,
    required ll.LatLng position,
    this.distanceKm,
  })  : _from = position,
        _to = position,
        _animStart = DateTime.now();

  final int id;
  String name;
  double? distanceKm;

  ll.LatLng _from;
  ll.LatLng _to;
  DateTime _animStart;

  static const Duration animDuration = Duration(milliseconds: 1400);

  ll.LatLng get target => _to;

  /// true, пока маркер ещё едет — нужно продолжать перерисовку
  bool get isMoving =>
      DateTime.now().difference(_animStart) < animDuration &&
      (_from.latitude != _to.latitude || _from.longitude != _to.longitude);

  void moveTo(ll.LatLng next) {
    if (next.latitude == _to.latitude && next.longitude == _to.longitude) {
      return;
    }
    _from = current;
    _to = next;
    _animStart = DateTime.now();
  }

  ll.LatLng get current {
    final elapsed = DateTime.now().difference(_animStart).inMilliseconds;
    final total = animDuration.inMilliseconds;
    if (elapsed >= total) return _to;
    final t = elapsed / total;
    return ll.LatLng(
      _from.latitude + (_to.latitude - _from.latitude) * t,
      _from.longitude + (_to.longitude - _from.longitude) * t,
    );
  }
}

class _OsmMapWidgetState extends State<OsmMapWidget> {
  final MapController _map = MapController();

  final Map<int, _MasterPin> _pins = {};
  List<ll.LatLng> _route = const [];
  double? _routeKm;
  double? _routeMin;

  Timer? _refreshTimer; // обновление списка мастеров
  Timer? _routeTimer; // пересчёт маршрута
  Timer? _ticker; // кадры анимации движения
  RealtimeChannel? _channel;

  bool _mapReady = false;
  bool _didFitOnce = false;
  String? _error;

  ll.LatLng? _deviceMe; // точка, полученная кнопкой «моё местоположение»
  bool _locating = false;
  String? _toast; // короткое сообщение поверх карты
  Timer? _toastTimer;

  ll.LatLng? _autoClient; // клиент активного заказа, найденный самой картой
  Timer? _activeOrderTimer;

  // ----- параметры со значениями по умолчанию -----
  double get _zoom => widget.initialZoom ?? 12.0;
  double get _radiusKm => widget.radiusKm ?? 50.0;
  int get _maxMasters => widget.maxMasters ?? 50;
  int get _refreshSeconds => widget.refreshSeconds ?? 25;
  bool get _autoLoad => widget.autoLoadMasters ?? false;
  bool get _showRoute => (widget.showRoute ?? false) || _autoClient != null;
  String get _tileUrl => widget.tileUrlTemplate ?? kDefaultTileUrl;
  String get _osrmBase =>
      (widget.osrmBaseUrl ?? kDefaultOsrmBase).replaceAll(RegExp(r'/+$'), '');
  String get _masterImage {
    final path = widget.masterImagePath?.trim();
    return (path == null || path.isEmpty) ? kMasterIconUrl : path;
  }

  /// Точка из пары параметров или null, если она не задана.
  /// 0,0 тоже считаем «не задана»: у числовых переменных App State в
  /// FlutterFlow начальное значение 0.0, и без этой проверки карта ставила бы
  /// булавку и строила маршрут в океан у берегов Африки.
  static ll.LatLng? _point(double? lat, double? lng) {
    if (lat == null || lng == null) return null;
    if (lat.abs() < 0.000001 && lng.abs() < 0.000001) return null;
    if (lat.abs() > 90 || lng.abs() > 180) return null;
    return ll.LatLng(lat, lng);
  }

  static const ll.LatLng _moscow = ll.LatLng(55.7558, 37.6173);

  ll.LatLng get _center =>
      _point(widget.centerLat, widget.centerLng) ?? _clientPoint ?? _moscow;

  /// Точка клиента, по порядку:
  ///  1) передана страницей (clientLat/clientLng);
  ///  2) найдена по активному заказу мастера (карта мастера без clientLat);
  ///  3) на общей карте клиента (autoLoadMasters) — сам клиент: его позиция
  ///     со страницы (centerLat/centerLng) или с кнопки «моё местоположение».
  ll.LatLng? get _clientPoint =>
      _point(widget.clientLat, widget.clientLng) ?? _autoClient ?? _selfClientPoint;

  ll.LatLng? get _selfClientPoint {
    if (!_autoLoad || (widget.pickLocation ?? false)) return null;
    return _point(widget.centerLat, widget.centerLng) ?? _deviceMe;
  }

  /// Карта мастера, которой страница не передала клиента: активный заказ
  /// карта ищет сама. Так на главной мастера видно клиента, линию и км,
  /// пока заказ не завершён, — без настроек во FlutterFlow.
  bool get _autoOrderMode =>
      !_autoLoad &&
      widget.trackMasterId != null &&
      widget.clientLat == null &&
      widget.clientLng == null &&
      !(widget.pickLocation ?? false);

  ll.LatLng? get _mePoint => _point(widget.meLat, widget.meLng);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  @override
  void didUpdateWidget(covariant OsmMapWidget old) {
    super.didUpdateWidget(old);

    if (old.mastersJson != widget.mastersJson && !_autoLoad) {
      _applyMastersJson(widget.mastersJson);
    }
    if (old.trackMasterId != widget.trackMasterId) {
      _resubscribe();
      _syncActiveOrderWatch();
    }
    if (old.showRoute != widget.showRoute) {
      _syncRouteTimer();
      if (!_showRoute && mounted) {
        setState(() {
          _route = const [];
          _routeKm = null;
          _routeMin = null;
        });
      }
    }
    if (old.clientLat != widget.clientLat ||
        old.clientLng != widget.clientLng ||
        old.meLat != widget.meLat ||
        old.meLng != widget.meLng) {
      _refreshRoute();
    }

    // Центр пришёл позже (например, после getMyLocation) — переводим камеру.
    // Мелкие сдвиги игнорируем: в режиме выбора адреса центр возвращается
    // обратно из onCenterChanged, и без порога карта дёргалась бы.
    if (old.centerLat != widget.centerLat ||
        old.centerLng != widget.centerLng) {
      final next = _point(widget.centerLat, widget.centerLng);
      if (next != null && _mapReady) {
        final meters =
            const ll.Distance().as(ll.LengthUnit.Meter, _map.camera.center, next);
        if (meters > 30) _map.move(next, _map.camera.zoom);
      }
      if (_autoLoad) _loadMasters();
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _routeTimer?.cancel();
    _ticker?.cancel();
    _toastTimer?.cancel();
    _activeOrderTimer?.cancel();
    _channel?.unsubscribe();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // Запуск
  // -------------------------------------------------------------------------
  void _bootstrap() {
    if (!_autoLoad) {
      _applyMastersJson(widget.mastersJson);
    } else {
      _loadMasters();
      _refreshTimer = Timer.periodic(
        Duration(seconds: _refreshSeconds),
        (_) => _loadMasters(),
      );
    }

    _resubscribe();
    _syncRouteTimer();
    _syncActiveOrderWatch();
  }

  // -------------------------------------------------------------------------
  // Активный заказ мастера — для карты мастера без clientLat
  // -------------------------------------------------------------------------
  void _syncActiveOrderWatch() {
    _activeOrderTimer?.cancel();
    _activeOrderTimer = null;

    if (!_autoOrderMode) {
      if (_autoClient != null) _setAutoClient(null);
      return;
    }

    _loadActiveOrder();
    // заказ могут принять или завершить в любой момент — проверяем раз в 30 сек
    _activeOrderTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _loadActiveOrder(),
    );
  }

  Future<void> _loadActiveOrder() async {
    final masterId = widget.trackMasterId;
    if (masterId == null || !_autoOrderMode) return;

    try {
      final rows = await Supabase.instance.client
          .from('orders')
          .select('id, latitude, longitude, orderStatus')
          .eq('mastersID', masterId)
          .neq('orderStatus', 'done')
          .order('created_at', ascending: false)
          .limit(1);
      if (!mounted || widget.trackMasterId != masterId) return;

      ll.LatLng? next;
      if (rows.isNotEmpty) {
        final r = rows.first;
        next = _point(_asDouble(r['latitude']), _asDouble(r['longitude']));
      }
      _setAutoClient(next);
    } catch (_) {
      // сеть моргнула — оставляем как было, проверим через 30 сек
    }
  }

  void _setAutoClient(ll.LatLng? next) {
    final same = next?.latitude == _autoClient?.latitude &&
        next?.longitude == _autoClient?.longitude;
    if (same) return;

    setState(() {
      _autoClient = next;
      if (next == null) {
        _route = const [];
        _routeKm = null;
        _routeMin = null;
      }
    });

    // появился заказ — показать мастера и клиента вместе
    _didFitOnce = false;
    _syncRouteTimer();
    _fitOnce();
  }

  /// Экономная схема: маршрут пересчитываем раз в минуту,
  /// между пересчётами маркер едет по уже построенной линии.
  void _syncRouteTimer() {
    _routeTimer?.cancel();
    _routeTimer = null;
    if (!_showRoute) return;

    _refreshRoute();
    _routeTimer = Timer.periodic(
      const Duration(seconds: 60),
      (_) => _refreshRoute(),
    );
  }

  // -------------------------------------------------------------------------
  // Список мастеров: RPC nearby_masters (дёшево, кэшируемо)
  // -------------------------------------------------------------------------
  Future<void> _loadMasters() async {
    try {
      final res = await Supabase.instance.client.rpc(
        'nearby_masters',
        params: {
          'p_lat': _center.latitude,
          'p_lng': _center.longitude,
          'p_city': widget.city,
          'p_radius_km': _radiusKm,
          'p_limit': _maxMasters,
        },
      );
      if (!mounted) return;
      _mergeMasters((res as List).cast<dynamic>());
      if (_error != null) setState(() => _error = null);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = 'Не удалось загрузить мастеров');
    }
  }

  void _applyMastersJson(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      setState(() => _pins.clear());
      return;
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) _mergeMasters(decoded);
    } catch (_) {
      // битый JSON просто игнорируем, карта остаётся с прежними маркерами
    }
  }

  /// Обновляет маркеры на месте, чтобы существующие поехали, а не перепрыгнули.
  void _mergeMasters(List<dynamic> rows) {
    final seen = <int>{};

    for (final row in rows) {
      if (row is! Map) continue;
      final id = _asInt(row['id']);
      final lat = _asDouble(row['latitude']);
      final lng = _asDouble(row['longitude']);
      if (id == null || lat == null || lng == null) continue;

      seen.add(id);
      final point = ll.LatLng(lat, lng);
      final name = (row['name'] ?? '').toString();
      final dist = _asDouble(row['distance_km']);

      final existing = _pins[id];
      if (existing == null) {
        _pins[id] = _MasterPin(
          id: id,
          name: name,
          position: point,
          distanceKm: dist,
        );
      } else {
        existing
          ..name = name.isEmpty ? existing.name : name
          ..distanceKm = dist ?? existing.distanceKm
          ..moveTo(point);
      }
    }

    // убираем тех, кто ушёл с смены — но не трогаем отслеживаемого мастера
    _pins.removeWhere(
      (id, _) => !seen.contains(id) && id != widget.trackMasterId,
    );

    if (mounted) setState(() {});
    _ensureTicker();
    _fitOnce();
  }

  // -------------------------------------------------------------------------
  // Realtime — только на назначенного мастера, а не на всех подряд
  // -------------------------------------------------------------------------
  void _resubscribe() {
    _channel?.unsubscribe();
    _channel = null;

    final id = widget.trackMasterId;
    if (id == null) return;

    // Realtime присылает только изменения. Чтобы маркер не ждал до 15 секунд
    // первого обновления, текущую позицию берём сразу.
    _loadTrackedMaster(id);

    // Если подписка не создалась (нет связи с Supabase) — карта не падает:
    // позиция всё равно обновится через _loadTrackedMaster и активный заказ.
    try {
      _channel = Supabase.instance.client
          .channel('master_track_$id')
          .onPostgresChanges(
            event: PostgresChangeEvent.update,
            schema: 'public',
            table: 'masters',
            filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'id',
              value: id,
            ),
            callback: (payload) {
              final rec = payload.newRecord;
              final lat = _asDouble(rec['latitude']);
              final lng = _asDouble(rec['longitude']);
              if (lat == null || lng == null || !mounted) return;

              _placeTrackedMaster(id, (rec['name'] ?? '').toString(), lat, lng);
            },
          )
          .subscribe();
    } catch (_) {
      _channel = null;
    }
  }

  Future<void> _loadTrackedMaster(int id) async {
    try {
      final row = await Supabase.instance.client
          .from('masters')
          .select('id, name, latitude, longitude')
          .eq('id', id)
          .maybeSingle();
      if (row == null || !mounted || widget.trackMasterId != id) return;

      final lat = _asDouble(row['latitude']);
      final lng = _asDouble(row['longitude']);
      if (lat == null || lng == null) return;

      // позиция из Realtime могла прийти раньше — её не затираем
      if (_pins.containsKey(id)) return;
      _placeTrackedMaster(id, (row['name'] ?? '').toString(), lat, lng);
    } catch (_) {
      // не критично: маркер появится с первым обновлением из Realtime
    }
  }

  void _placeTrackedMaster(int id, String name, double lat, double lng) {
    final point = ll.LatLng(lat, lng);
    final pin = _pins[id];
    final isFirst = pin == null;

    if (isFirst) {
      _pins[id] = _MasterPin(id: id, name: name, position: point);
    } else {
      pin.moveTo(point);
    }

    setState(() {});
    _ensureTicker();

    if (isFirst) {
      _fitOnce();
      // маршрут не мог построиться, пока не было точки мастера
      if (_route.isEmpty) _refreshRoute();
    }
  }

  // -------------------------------------------------------------------------
  // Кадры анимации — тикаем только пока кто-то реально едет
  // -------------------------------------------------------------------------
  void _ensureTicker() {
    if (_ticker != null) return;
    _ticker = Timer.periodic(const Duration(milliseconds: 50), (t) {
      if (!mounted) {
        t.cancel();
        _ticker = null;
        return;
      }
      final moving = _pins.values.any((p) => p.isMoving);
      if (!moving) {
        t.cancel();
        _ticker = null;
        return;
      }
      setState(() {});
    });
  }

  // -------------------------------------------------------------------------
  // Маршрут через OSRM
  // -------------------------------------------------------------------------
  Future<void> _refreshRoute() async {
    if (!_showRoute) return;

    final to = _clientPoint;
    final from = _mePoint ??
        (widget.trackMasterId != null
            ? _pins[widget.trackMasterId]?.target
            : null);

    if (from == null || to == null) return;

    try {
      final uri = Uri.parse(
        '$_osrmBase/route/v1/driving/'
        '${from.longitude},${from.latitude};${to.longitude},${to.latitude}'
        '?overview=full&geometries=geojson',
      );
      final resp = await http.get(uri).timeout(const Duration(seconds: 12));
      if (resp.statusCode != 200) return;

      final body = jsonDecode(resp.body) as Map<String, dynamic>;
      if (body['code'] != 'Ok') return;

      final routes = body['routes'] as List;
      if (routes.isEmpty) return;

      final route = routes.first as Map<String, dynamic>;
      final coords =
          (route['geometry']['coordinates'] as List).cast<dynamic>();

      final points = <ll.LatLng>[
        for (final c in coords)
          ll.LatLng(_asDouble(c[1]) ?? 0, _asDouble(c[0]) ?? 0),
      ];

      final km = (_asDouble(route['distance']) ?? 0) / 1000.0;
      final min = (_asDouble(route['duration']) ?? 0) / 60.0;

      if (!mounted) return;
      setState(() {
        _route = points;
        _routeKm = km;
        _routeMin = min;
      });
      _fitOnce();
      widget.onRouteInfo?.call([km, min]);
    } catch (_) {
      // сеть моргнула — оставляем предыдущий маршрут
    }
  }

  // -------------------------------------------------------------------------
  // Один раз подогнать камеру так, чтобы всё поместилось
  // -------------------------------------------------------------------------
  void _fitOnce() {
    // в режиме выбора адреса камерой управляет пользователь
    if (widget.pickLocation ?? false) return;
    if (_didFitOnce || !_mapReady || !mounted) return;

    final pts = <ll.LatLng>[
      ..._pins.values.map((p) => p.target),
      if (_clientPoint != null) _clientPoint!,
      if (_mePoint != null) _mePoint!,
      ..._route,
    ];
    if (pts.length < 2) return;

    _didFitOnce = true;
    try {
      _map.fitCamera(
        CameraFit.bounds(
          bounds: LatLngBounds.fromPoints(pts),
          padding: const EdgeInsets.all(56),
          maxZoom: 16,
        ),
      );
    } catch (_) {}
  }

  // -------------------------------------------------------------------------
  static double? _asDouble(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString());
  }

  static int? _asInt(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString());
  }

  // -------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          FlutterMap(
            mapController: _map,
            options: MapOptions(
              initialCenter: _center,
              initialZoom: _zoom,
              minZoom: 3,
              maxZoom: 18,
              onMapReady: () {
                _mapReady = true;
                _fitOnce();
                // в режиме выбора сразу отдаём стартовую точку,
                // чтобы адрес был заполнен, даже если карту не трогали
                if (widget.pickLocation ?? false) _emitCenter();
              },
              onMapEvent: (event) {
                if (!(widget.pickLocation ?? false)) return;
                if (event is MapEventMoveEnd ||
                    event is MapEventFlingAnimationEnd ||
                    event is MapEventDoubleTapZoomEnd) {
                  _emitCenter();
                }
              },
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: _tileUrl,
                userAgentPackageName: 'ru.nadoclean.app',
                maxNativeZoom: 19,
                tileProvider: NetworkTileProvider(),
              ),
              if (_route.length > 1)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _route,
                      strokeWidth: 5,
                      color: const Color(0xFF2E7BF6),
                      borderStrokeWidth: 2,
                      borderColor: Colors.white,
                    ),
                  ],
                ),
              MarkerLayer(markers: _buildMarkers()),
            ],
          ),

          // требование лицензии OpenStreetMap
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white70,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              child: const Text(
                '© OpenStreetMap',
                style: TextStyle(fontSize: 9, color: Colors.black87),
              ),
            ),
          ),

          // булавка выбора адреса (иконка клиента): остриё ровно в центре карты
          if (widget.pickLocation ?? false)
            const IgnorePointer(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  // картинка 48 px, остриё у нижнего края —
                  // поднимаем её на половину высоты, чтобы остриё легло в центр
                  padding: EdgeInsets.only(bottom: 46),
                  child: _ClientPin(size: 48),
                ),
              ),
            ),

          _controls(),

          if (_routeKm != null) _routeBadge(),
          if (_error != null) _errorBadge(),
          if (_toast != null) _toastBadge(),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Кнопки «+», «−», «моё местоположение»
  // -------------------------------------------------------------------------
  Widget _controls() => Positioned.fill(
        // Align не перехватывает касания мимо кнопок — карта двигается как обычно
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _MapButton(icon: Icons.add, onTap: () => _zoomBy(1)),
                const SizedBox(height: 8),
                _MapButton(icon: Icons.remove, onTap: () => _zoomBy(-1)),
                const SizedBox(height: 8),
                _MapButton(
                  icon: Icons.my_location,
                  busy: _locating,
                  onTap: _goToMyLocation,
                ),
              ],
            ),
          ),
        ),
      );

  void _zoomBy(double delta) {
    if (!_mapReady) return;
    final cam = _map.camera;
    final next = (cam.zoom + delta).clamp(3.0, 18.0).toDouble();
    _map.move(cam.center, next);
  }

  Future<void> _goToMyLocation() async {
    if (_locating || !_mapReady) return;
    setState(() => _locating = true);

    try {
      final device = await _readDeviceLocation();
      if (!mounted) return;

      // нет доступа к GPS — едем хотя бы к точке, которую знает страница
      final target =
          device ?? _mePoint ?? _point(widget.centerLat, widget.centerLng);

      if (device != null) _deviceMe = device;

      if (target != null) {
        final zoom = _map.camera.zoom < 15 ? 15.0 : _map.camera.zoom;
        _map.move(target, zoom);
        // программный сдвиг не присылает MoveEnd — в режиме выбора адреса
        // точку под булавкой отдаём сами
        if (widget.pickLocation ?? false) _emitCenter();
      }

      if (device == null) _showToast('Геолокация недоступна');
    } finally {
      if (mounted) setState(() => _locating = false);
    }
  }

  Future<ll.LatLng?> _readDeviceLocation() async {
    try {
      if (!await geo.Geolocator.isLocationServiceEnabled()) return null;

      var permission = await geo.Geolocator.checkPermission();
      if (permission == geo.LocationPermission.denied) {
        permission = await geo.Geolocator.requestPermission();
      }
      if (permission == geo.LocationPermission.denied ||
          permission == geo.LocationPermission.deniedForever) {
        return null;
      }

      final pos = await geo.Geolocator.getCurrentPosition(
        locationSettings: const geo.LocationSettings(
          accuracy: geo.LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
      return _point(pos.latitude, pos.longitude);
    } catch (_) {
      // таймаут или GPS не ответил — пробуем последнюю известную точку
      // (в браузере этот метод не поддерживается и тоже бросает ошибку)
      try {
        final last = await geo.Geolocator.getLastKnownPosition();
        if (last != null) return _point(last.latitude, last.longitude);
      } catch (_) {}
      return null;
    }
  }

  void _showToast(String text) {
    _toastTimer?.cancel();
    setState(() => _toast = text);
    _toastTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _toast = null);
    });
  }

  void _emitCenter() {
    if (!_mapReady) return;
    final c = _map.camera.center;
    widget.onCenterChanged?.call([c.latitude, c.longitude]);
  }

  List<Marker> _buildMarkers() {
    final markers = <Marker>[];

    // маркер клиента / адреса заказа
    final client = _clientPoint;
    if (client != null) {
      markers.add(
        Marker(
          point: client,
          width: 48,
          height: 48,
          // маркер стоит над точкой: остриё булавки — в координате клиента
          alignment: Alignment.topCenter,
          child: const _ClientPin(size: 48),
        ),
      );
    }

    // своя позиция: из параметров страницы или с кнопки «моё местоположение»
    // На общей карте клиента его точка уже нарисована иконкой клиента —
    // синюю точку поверх не ставим.
    final me = _mePoint ?? (_selfClientPoint == null ? _deviceMe : null);
    if (me != null) {
      markers.add(
        Marker(
          point: me,
          width: 26,
          height: 26,
          child: const _MeDot(),
        ),
      );
    }

    // мастера
    for (final pin in _pins.values) {
      markers.add(
        Marker(
          point: pin.current,
          width: 54,
          height: 54,
          child: GestureDetector(
            onTap: () => widget.onMasterTap?.call(pin.id),
            child: _MasterIcon(
              imagePath: _masterImage,
              highlighted: pin.id == widget.trackMasterId,
            ),
          ),
        ),
      );
    }

    return markers;
  }

  Widget _routeBadge() {
    final km = _routeKm!;
    final min = _routeMin ?? 0;
    final kmText =
        km < 1 ? '${(km * 1000).round()} м' : '${km.toStringAsFixed(1)} км';

    return Positioned(
      left: 12,
      top: 12,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Color(0x33000000), blurRadius: 6, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.near_me, size: 15, color: Color(0xFF2E7BF6)),
            const SizedBox(width: 6),
            Text(
              '$kmText · ${min.round()} мин',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _errorBadge() => Positioned(
        left: 12,
        bottom: 12,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xB3000000),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            _error!,
            style: const TextStyle(fontSize: 11, color: Colors.white),
          ),
        ),
      );

  Widget _toastBadge() => Positioned(
        left: 0,
        right: 0,
        bottom: 36,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xCC000000),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              _toast!,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ),
      );
}

// ---------------------------------------------------------------------------
// Круглая кнопка управления картой
// ---------------------------------------------------------------------------
class _MapButton extends StatelessWidget {
  const _MapButton({
    required this.icon,
    required this.onTap,
    this.busy = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool busy;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white,
        shape: const CircleBorder(),
        elevation: 3,
        shadowColor: const Color(0x55000000),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: busy ? null : onTap,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: busy
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Color(0xFF2E7BF6),
                      ),
                    )
                  : Icon(icon, size: 22, color: const Color(0xFF333333)),
            ),
          ),
        ),
      );
}

/// Картинка по ссылке или из assets. Если не загрузилась (нет сети, файл
/// удалён) — показывается запасная иконка, карта не ломается.
Widget _markerImage(
  String src, {
  required double size,
  required BoxFit fit,
  required Widget fallback,
}) {
  final isNetwork = src.startsWith('http://') || src.startsWith('https://');
  Widget onError(BuildContext _, Object __, StackTrace? ___) => fallback;

  return isNetwork
      ? Image.network(
          src,
          width: size,
          height: size,
          fit: fit,
          gaplessPlayback: true,
          errorBuilder: onError,
        )
      : Image.asset(
          src,
          width: size,
          height: size,
          fit: fit,
          errorBuilder: onError,
        );
}

// ---------------------------------------------------------------------------
// Иконка клиента — client.png (прозрачная булавка, остриё внизу)
// ---------------------------------------------------------------------------
class _ClientPin extends StatelessWidget {
  const _ClientPin({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) => _markerImage(
        kClientIconUrl,
        size: size,
        fit: BoxFit.contain,
        fallback: _PinIcon(
          color: const Color(0xFFE53935),
          icon: Icons.location_on,
          size: size,
        ),
      );
}

// ---------------------------------------------------------------------------
// Иконка мастера — mastericon.jpg в круге (у картинки чёрный квадратный фон)
// ---------------------------------------------------------------------------
class _MasterIcon extends StatelessWidget {
  const _MasterIcon({required this.imagePath, this.highlighted = false});

  final String imagePath;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final ring = highlighted ? const Color(0xFF2E7BF6) : Colors.white;
    return Center(
      child: Container(
        width: highlighted ? 50 : 42,
        height: highlighted ? 50 : 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ring, width: 3),
          boxShadow: const [
            BoxShadow(color: Color(0x40000000), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: ClipOval(
          child: _markerImage(
            imagePath,
            size: highlighted ? 50 : 42,
            fit: BoxFit.cover,
            fallback: Container(
              color: const Color(0xFF2E7BF6),
              child: const Icon(Icons.person, color: Colors.white, size: 22),
            ),
          ),
        ),
      ),
    );
  }
}

/// Запасная иконка булавки, если картинка клиента не загрузилась.
class _PinIcon extends StatelessWidget {
  const _PinIcon({required this.color, required this.icon, this.size = 42});

  final Color color;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) =>
      Icon(icon, color: color, size: size, shadows: const [
        Shadow(color: Color(0x55000000), blurRadius: 4, offset: Offset(0, 2)),
      ]);
}

class _MeDot extends StatelessWidget {
  const _MeDot();

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF2E7BF6),
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: const [
            BoxShadow(color: Color(0x55000000), blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
      );
}

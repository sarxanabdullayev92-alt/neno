// ============================================================================
// FlutterFlow → Custom Code → Custom Functions → + Add
// Ставятся в ОБА проекта.
//
// ЗДЕСЬ ЧЕТЫРЕ ОТДЕЛЬНЫЕ ФУНКЦИИ. В FlutterFlow каждую заводите отдельной
// записью «Custom Function» и копируете только её блок.
// Дополнительных зависимостей не нужно.
// ============================================================================

import 'dart:math' as math;

// ----------------------------------------------------------------------------
// ФУНКЦИЯ 1 — distanceKm
//
// Параметры: lat1 double, lng1 double, lat2 double, lng2 double (все обязательные)
// Return Type: double (Nullable ✓)
//
// Расстояние по прямой, без обращения к серверу. Годится для мгновенной
// сортировки и подписей в списке. Если нужны километры ПО ДОРОГАМ —
// берите action getRouteInfo.
// ----------------------------------------------------------------------------
double? distanceKm(double lat1, double lng1, double lat2, double lng2) {
  const earthRadiusKm = 6371.0;

  double toRad(double deg) => deg * math.pi / 180.0;

  final dLat = toRad(lat2 - lat1);
  final dLng = toRad(lng2 - lng1);

  final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(toRad(lat1)) *
          math.cos(toRad(lat2)) *
          math.sin(dLng / 2) *
          math.sin(dLng / 2);

  final c = 2 * math.asin(math.min(1.0, math.sqrt(a)));
  return earthRadiusKm * c;
}

// ----------------------------------------------------------------------------
// ФУНКЦИЯ 2 — formatDistance
//
// Параметры: km double (Nullable)
// Return Type: String (Nullable ✓)
//
// 0.85 → "850 м"   |   12.44 → "12,4 км"   |   null → "—"
// ----------------------------------------------------------------------------
String? formatDistance(double? km) {
  if (km == null || km.isNaN || km.isInfinite || km < 0) return '—';

  if (km < 1) {
    final meters = (km * 1000).round();
    return '$meters м';
  }

  final text = km.toStringAsFixed(1).replaceAll('.', ',');
  return '$text км';
}

// ----------------------------------------------------------------------------
// ФУНКЦИЯ 3 — parseCoord
//
// Параметры: text String (Nullable), wantLatitude bool (обязательный)
// Return Type: double (Nullable ✓)
//
// Разбирает старые текстовые поля вида "55.751244, 37.618423"
// (masters.currentLocation, profile.usersLongANDLat, константа
// latitudeAndLOngitude). wantLatitude = true вернёт первое число, false — второе.
// Для новых записей используйте числовые колонки latitude / longitude.
// ----------------------------------------------------------------------------
double? parseCoord(String? text, bool wantLatitude) {
  if (text == null) return null;

  final parts = text.split(RegExp(r'[,;\s]+'))
      .where((p) => p.trim().isNotEmpty)
      .toList();
  if (parts.length < 2) return null;

  final value = double.tryParse(parts[wantLatitude ? 0 : 1].trim());
  if (value == null || value.isNaN) return null;

  // отсекаем заведомо мусорные значения
  if (wantLatitude && (value < -90 || value > 90)) return null;
  if (!wantLatitude && (value < -180 || value > 180)) return null;

  return value;
}

// ----------------------------------------------------------------------------
// ФУНКЦИЯ 4 — formatMinutes
//
// Параметры: min double (Nullable)
// Return Type: String (Nullable ✓)
//
// 11.6 → "~12 мин"   |   0.4 → "~1 мин"   |   75 → "~1 ч 15 мин"   |   null → "—"
// ----------------------------------------------------------------------------
String? formatMinutes(double? min) {
  if (min == null || min.isNaN || min.isInfinite || min < 0) return '—';

  final total = math.max(1, min.round());
  if (total < 60) return '~$total мин';

  final hours = total ~/ 60;
  final rest = total % 60;
  return rest == 0 ? '~$hours ч' : '~$hours ч $rest мин';
}

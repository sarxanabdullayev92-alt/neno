// ============================================================================
// FlutterFlow → Custom Code → Custom Actions → + Add
// Имя: getMyLocation
// Ставится в ОБА проекта (nado_clean и master_profi)
//
// Зависимости: geolocator: 14.0.2
//
// Параметры: нет
// Return Type: List<double>  (Nullable ✓)
//   [0] = широта, [1] = долгота
//   null — если разрешения нет или геолокация выключена
//
// Возвращает List, а не LatLng, потому что FlutterFlow не умеет отдавать
// свой LatLng из custom action. Разбирайте через индексы [0] и [1].
// ============================================================================

import 'package:geolocator/geolocator.dart';

Future<List<double>?> getMyLocation() async {
  try {
    // 1. Включена ли геолокация на устройстве
    if (!await Geolocator.isLocationServiceEnabled()) {
      return null;
    }

    // 2. Разрешение
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    // 3. Позиция
    final pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 20),
      ),
    );

    return [pos.latitude, pos.longitude];
  } catch (_) {
    // таймаут / отказ / нет GPS — пробуем последнюю известную точку
    try {
      final last = await Geolocator.getLastKnownPosition();
      if (last != null) return [last.latitude, last.longitude];
    } catch (_) {}
    return null;
  }
}

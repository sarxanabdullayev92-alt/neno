// ============================================================================
// FlutterFlow → Custom Code → Custom Actions → + Add
// Имя: loadNearbyMasters
// Ставится в nado_clean (приложение клиента)
//
// Зависимости: дополнительных нет
//
// Параметры:
//   lat       double  обязательный   вокруг какой точки искать
//   lng       double  обязательный
//   city      String  Nullable       фильтр по городу, напр. "Москва"
//   radiusKm  double  Nullable       по умолчанию 50
//   limit     int     Nullable       по умолчанию 50
//
// Return Type: String (Nullable ✓) — JSON-массив мастеров
//
// Нужно только если хотите показать мастеров СПИСКОМ рядом с картой
// или положить их в App State. Самой карте это не требуется:
// при autoLoadMasters = true виджет грузит их сам.
//
// Возвращает JSON-строку, потому что FlutterFlow не умеет отдавать
// список произвольных объектов из custom action. Строку можно передать
// в параметр mastersJson виджета OsmMapWidget.
// ============================================================================

import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<String?> loadNearbyMasters(
  double lat,
  double lng,
  String? city,
  double? radiusKm,
  int? limit,
) async {
  try {
    final res = await Supabase.instance.client.rpc(
      'nearby_masters',
      params: {
        'p_lat': lat,
        'p_lng': lng,
        'p_city': (city != null && city.trim().isEmpty) ? null : city,
        'p_radius_km': radiusKm ?? 50.0,
        'p_limit': limit ?? 50,
      },
    );

    return jsonEncode(res);
  } catch (_) {
    return null;
  }
}

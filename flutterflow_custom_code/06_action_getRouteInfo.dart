// ============================================================================
// FlutterFlow → Custom Code → Custom Actions → + Add
// Имя: getRouteInfo
// Ставится в ОБА проекта
//
// Зависимости: дополнительных нет (http уже в проекте)
//
// Параметры:
//   fromLat  double  обязательный
//   fromLng  double  обязательный
//   toLat    double  обязательный
//   toLng    double  обязательный
//
// Return Type: List<double> (Nullable ✓)
//   [0] = расстояние по дорогам, км
//   [1] = время в пути, минут
//   null — маршрут построить не удалось
//
// Нужно, когда цифры требуются ОТДЕЛЬНО от карты: на карточке
// «АДРЕС И ДИСТАНЦИЯ» в OrderOffer, в списке заказов и т.п.
// Если карта уже на экране — берите значения из callback onRouteInfo виджета,
// чтобы не запрашивать маршрут дважды.
// ============================================================================

import 'dart:convert';

import 'package:http/http.dart' as http;

const String _kOsrmBase = 'https://ugitubelnid.beget.app';

Future<List<double>?> getRouteInfo(
  double fromLat,
  double fromLng,
  double toLat,
  double toLng,
) async {
  try {
    final uri = Uri.parse(
      '$_kOsrmBase/route/v1/driving/'
      '$fromLng,$fromLat;$toLng,$toLat'
      '?overview=false',
    );

    final resp = await http.get(uri).timeout(const Duration(seconds: 12));
    if (resp.statusCode != 200) return null;

    final body = jsonDecode(resp.body) as Map<String, dynamic>;
    if (body['code'] != 'Ok') return null;

    final routes = body['routes'] as List;
    if (routes.isEmpty) return null;

    final route = routes.first as Map<String, dynamic>;
    final meters = (route['distance'] as num?)?.toDouble() ?? 0;
    final seconds = (route['duration'] as num?)?.toDouble() ?? 0;

    return [meters / 1000.0, seconds / 60.0];
  } catch (_) {
    return null;
  }
}

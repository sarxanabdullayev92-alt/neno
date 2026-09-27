// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// ============================================================================
// FlutterFlow → Custom Code → Custom Actions → + Add
// Имя: reverseGeocode
// Ставится ТОЛЬКО в клиентский проект (neno / nado_clean)
//
// Зависимости: дополнительных нет (http уже в проекте)
//
// Параметры:
//   lat  double  обязательный
//   lng  double  обязательный
//
// Return Type: List<String> (Nullable ✓)
//   [0] = адрес строкой, например «г Москва, ул Тверская, д 7»
//   [1] = город, например «Москва» (для orders.city)
//   null — рядом с точкой (100 м) адреса нет или нет сети
//
// Адрес по точке через DaData (бесплатно, тот же API-ключ, что у
// geocodeAddress). Вызывать из onCenterChanged карты — он срабатывает
// только когда карту отпустили, а не на каждое движение.
// ============================================================================

import 'dart:convert';

import 'package:http/http.dart' as http;

const String _kDadataGeolocateUrl =
    'https://suggestions.dadata.ru/suggestions/api/4_1/rs/geolocate/address';
const String _kDadataApiKey = 'd224b2dba5b06da6396bffdb4fc4d66be7f5a324';

Future<List<String>?> reverseGeocode(double lat, double lng) async {
  try {
    final resp = await http
        .post(
          Uri.parse(_kDadataGeolocateUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Token $_kDadataApiKey',
          },
          body: jsonEncode({
            'lat': lat,
            'lon': lng,
            'count': 1,
            'radius_meters': 100,
          }),
        )
        .timeout(const Duration(seconds: 10));
    if (resp.statusCode != 200) return null;

    final body =
        jsonDecode(utf8.decode(resp.bodyBytes)) as Map<String, dynamic>;
    final suggestions = body['suggestions'] as List? ?? const [];
    if (suggestions.isEmpty) return null;

    final first = suggestions.first as Map<String, dynamic>;
    final data = first['data'] as Map<String, dynamic>? ?? const {};
    final address = '${first['value'] ?? ''}';
    if (address.isEmpty) return null;

    // У городов федерального значения (Москва, Питер) city заполнен,
    // у деревень бывает только settlement.
    final city = '${data['city'] ?? data['settlement'] ?? ''}';
    return [address, city];
  } catch (_) {
    return null;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!

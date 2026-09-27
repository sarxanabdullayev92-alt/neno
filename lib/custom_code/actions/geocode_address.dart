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

import 'dart:convert';

import 'package:http/http.dart' as http;

const String _kDadataUrl =
    'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address';
const String _kDadataApiKey = 'd224b2dba5b06da6396bffdb4fc4d66be7f5a324';

Future<List<double>?> geocodeAddress(String address) async {
  final query = address.trim();
  if (query.isEmpty) return null;

  try {
    final resp = await http
        .post(
          Uri.parse(_kDadataUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Token $_kDadataApiKey',
          },
          body: jsonEncode({
            'query': query,
            'count': 5,
            // Без города в запросе первой идёт Москва (КЛАДР 77);
            // явно указанный город всё равно важнее.
            'locations_boost': [
              {'kladr_id': '77'},
            ],
          }),
        )
        .timeout(const Duration(seconds: 10));
    if (resp.statusCode != 200) return null;

    final body =
        jsonDecode(utf8.decode(resp.bodyBytes)) as Map<String, dynamic>;
    final suggestions = body['suggestions'] as List? ?? const [];

    // Первая подсказка с координатами: у неполного адреса
    // (например, только улица) их может не быть.
    for (final s in suggestions) {
      final data = (s as Map<String, dynamic>)['data'] as Map<String, dynamic>?;
      final lat = double.tryParse('${data?['geo_lat']}');
      final lng = double.tryParse('${data?['geo_lon']}');
      if (lat != null && lng != null) return [lat, lng];
    }
    return null;
  } catch (_) {
    return null;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!

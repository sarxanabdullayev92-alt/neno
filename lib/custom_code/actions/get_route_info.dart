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

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!

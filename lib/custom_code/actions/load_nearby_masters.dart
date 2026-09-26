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

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!

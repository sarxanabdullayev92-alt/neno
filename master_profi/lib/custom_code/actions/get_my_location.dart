// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!

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

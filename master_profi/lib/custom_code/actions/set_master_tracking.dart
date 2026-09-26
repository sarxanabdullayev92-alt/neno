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

import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Живёт между вызовами action, поэтому повторный вызов не плодит таймеры.
Timer? _masterTrackingTimer;
int? _masterTrackingInterval;

Future<bool?> setMasterTracking(
  bool enabled,
  int? intervalSeconds,
  String? city,
  bool? setOnline,
) async {
  // --- выключение ---
  if (!enabled) {
    _masterTrackingTimer?.cancel();
    _masterTrackingTimer = null;
    _masterTrackingInterval = null;

    try {
      await Supabase.instance.client
          .rpc('set_master_online', params: {'p_online': false});
      return true;
    } catch (_) {
      return false;
    }
  }

  // --- включение ---
  final interval =
      (intervalSeconds == null || intervalSeconds < 5) ? 60 : intervalSeconds;

  // разрешение спрашиваем один раз, на входе
  try {
    if (!await Geolocator.isLocationServiceEnabled()) return false;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
  } catch (_) {
    return false;
  }

  // интервал не изменился и таймер уже тикает — ничего не пересоздаём
  if (_masterTrackingTimer != null && _masterTrackingInterval == interval) {
    await _pushLocation(city, setOnline ?? true);
    return true;
  }

  _masterTrackingTimer?.cancel();
  _masterTrackingInterval = interval;

  // первую точку шлём сразу, не дожидаясь тика
  await _pushLocation(city, setOnline ?? true);

  _masterTrackingTimer = Timer.periodic(
    Duration(seconds: interval),
    (_) => _pushLocation(city, null),
  );

  return true;
}

Future<void> _pushLocation(String? city, bool? online) async {
  try {
    final pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 20),
      ),
    );

    await Supabase.instance.client.rpc('update_master_location', params: {
      'p_lat': pos.latitude,
      'p_lng': pos.longitude,
      'p_heading': pos.heading.isNaN ? null : pos.heading,
      'p_is_online': online,
      'p_city': city,
    });
  } catch (_) {
    // одна неудачная отправка не должна ронять цикл —
    // следующий тик попробует снова
  }
}

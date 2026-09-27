import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/flutter_flow/custom_functions.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

String fullAddress(
  String? address,
  String? details,
) {
  const emptyLabels = {'подъезд', 'этаж', 'кв.', 'кв'};
  final parts = <String>[];
  final main = (address ?? '').trim();
  if (main.isNotEmpty) parts.add(main);
  for (final raw in (details ?? '').split(',')) {
    final part = raw.trim();
    if (part.isEmpty || emptyLabels.contains(part.toLowerCase())) continue;
    parts.add(part);
  }
  return parts.join(', ');
}

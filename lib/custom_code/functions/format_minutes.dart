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

String? formatMinutes(double? min) {
  if (min == null || min.isNaN || min.isInfinite || min < 0) return '—';

  final total = math.max(1, min.round());
  if (total < 60) return '~$total мин';

  final hours = total ~/ 60;
  final rest = total % 60;
  return rest == 0 ? '~$hours ч' : '~$hours ч $rest мин';
}

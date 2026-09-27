import '/backend/supabase/supabase.dart';
import '/components/adress_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'map_page_widget.dart' show MapPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MapPageModel extends FlutterFlowModel<MapPageWidget> {
  ///  Local state fields for this page.

  double? routeKm;

  double? routeMin;

  double? searchLat;

  double? searchLng;

  bool isSearching = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getMyLocation] action in MapPage widget.
  List<double>? myLocation;
  // Stores action output result for [Custom Action - reverseGeocode] action in MapPage widget.
  List<String>? gpsGeo;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

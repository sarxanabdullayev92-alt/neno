import '/flutter_flow/flutter_flow_count_controller.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'long_pile_widget.dart' show LongPileWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LongPileModel extends FlutterFlowModel<LongPileWidget> {
  ///  Local state fields for this component.

  double? one = 700.0;

  ///  State fields for stateful widgets in this component.

  // State field(s) for CountController widget.
  int? countControllerValue;
  // Stores action output result for [Custom Action - getAllProductTypes] action in Button widget.
  List<String>? productGot;
  // Stores action output result for [Custom Action - getAllProductNames] action in Button widget.
  List<String>? productNameList;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}

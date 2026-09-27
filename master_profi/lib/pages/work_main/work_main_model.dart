import '/backend/supabase/supabase.dart';
import '/components/diagnostic_item/diagnostic_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'work_main_widget.dart' show WorkMainWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WorkMainModel extends FlutterFlowModel<WorkMainWidget> {
  ///  Local state fields for this page.

  double? routeKm;

  double? routeMin;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in WorkMain widget.
  List<MastersRow>? masterRow;
  // Stores action output result for [Custom Action - getMyLocation] action in WorkMain widget.
  List<double>? myLocation;
  // Model for DiagnosticItem.
  late DiagnosticItemModel diagnosticItemModel1;
  // Model for DiagnosticItem.
  late DiagnosticItemModel diagnosticItemModel2;
  // Model for DiagnosticItem.
  late DiagnosticItemModel diagnosticItemModel3;
  // State field(s) for Switch widget.
  bool? switchValue;
  // Stores action output result for [Custom Action - setMasterTracking] action in Switch widget.
  bool? setmasterTracking;
  // State field(s) for Timer widget.
  final timerInitialTimeMs = 60000;
  int timerMilliseconds = 60000;
  String timerValue = StopWatchTimer.getDisplayTime(
    60000,
    hours: false,
    milliSecond: false,
  );
  FlutterFlowTimerController timerController =
      FlutterFlowTimerController(StopWatchTimer(mode: StopWatchMode.countDown));

  @override
  void initState(BuildContext context) {
    diagnosticItemModel1 = createModel(context, () => DiagnosticItemModel());
    diagnosticItemModel2 = createModel(context, () => DiagnosticItemModel());
    diagnosticItemModel3 = createModel(context, () => DiagnosticItemModel());
  }

  @override
  void dispose() {
    diagnosticItemModel1.dispose();
    diagnosticItemModel2.dispose();
    diagnosticItemModel3.dispose();
    timerController.dispose();
  }
}

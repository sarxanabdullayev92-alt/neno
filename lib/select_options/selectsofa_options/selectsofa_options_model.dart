import '/components/button/button_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/parametr_sofa/aditional/aditional_widget.dart';
import '/parametr_sofa/kitchen_u_g/kitchen_u_g_widget.dart';
import '/parametr_sofa/sofa_p_o_b/sofa_p_o_b_widget.dart';
import '/parametr_sofa/sofa_p_r/sofa_p_r_widget.dart';
import '/parametr_sofa/sofa_u_g/sofa_u_g_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'selectsofa_options_widget.dart' show SelectsofaOptionsWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectsofaOptionsModel extends FlutterFlowModel<SelectsofaOptionsWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Custom Action - sumDoubleList] action in SelectsofaOptions widget.
  double? theAddition;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    buttonModel.dispose();
  }
}

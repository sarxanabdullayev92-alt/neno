import '/components/button/button_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/parametr_mattress/bed/bed_widget.dart';
import '/parametr_mattress/matras1/matras1_widget.dart';
import '/parametr_mattress/matras15/matras15_widget.dart';
import '/parametr_mattress/matras2/matras2_widget.dart';
import '/parametr_mattress/matras_king_size/matras_king_size_widget.dart';
import '/parametr_mattress/matraschildren/matraschildren_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'select_matras_options_widget.dart' show SelectMatrasOptionsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectMatrasOptionsModel
    extends FlutterFlowModel<SelectMatrasOptionsWidget> {
  ///  State fields for stateful widgets in this component.

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

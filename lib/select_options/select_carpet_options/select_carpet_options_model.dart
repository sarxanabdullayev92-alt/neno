import '/components/button/button_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/parametr_carpet/cotton_wool/cotton_wool_widget.dart';
import '/parametr_carpet/kovrolin/kovrolin_widget.dart';
import '/parametr_carpet/long_pile/long_pile_widget.dart';
import '/parametr_carpet/sinthetics/sinthetics_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import 'select_carpet_options_widget.dart' show SelectCarpetOptionsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectCarpetOptionsModel
    extends FlutterFlowModel<SelectCarpetOptionsWidget> {
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

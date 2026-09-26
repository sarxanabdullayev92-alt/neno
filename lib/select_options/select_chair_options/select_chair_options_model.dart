import '/components/button/button_widget.dart';
import '/components/service_item/service_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/parametr_chair/armchair/armchair_widget.dart';
import '/parametr_chair/chair/chair_widget.dart';
import '/parametr_chair/poof_banquette/poof_banquette_widget.dart';
import 'dart:ui';
import 'select_chair_options_widget.dart' show SelectChairOptionsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectChairOptionsModel
    extends FlutterFlowModel<SelectChairOptionsWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ServiceItem.
  late ServiceItemModel serviceItemModel1;
  // Model for ServiceItem.
  late ServiceItemModel serviceItemModel2;
  // Model for ServiceItem.
  late ServiceItemModel serviceItemModel3;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    serviceItemModel1 = createModel(context, () => ServiceItemModel());
    serviceItemModel2 = createModel(context, () => ServiceItemModel());
    serviceItemModel3 = createModel(context, () => ServiceItemModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    serviceItemModel1.dispose();
    serviceItemModel2.dispose();
    serviceItemModel3.dispose();
    buttonModel.dispose();
  }
}

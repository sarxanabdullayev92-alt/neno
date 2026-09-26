import '/components/button/button_widget.dart';
import '/components/service_item/service_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/parametr_carpet/cotton_wool/cotton_wool_widget.dart';
import '/parametr_carpet/kovrolin/kovrolin_widget.dart';
import '/parametr_carpet/long_pile/long_pile_widget.dart';
import '/parametr_carpet/sinthetics/sinthetics_widget.dart';
import 'dart:ui';
import 'select_leather_options_widget.dart' show SelectLeatherOptionsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectLeatherOptionsModel
    extends FlutterFlowModel<SelectLeatherOptionsWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ServiceItem.
  late ServiceItemModel serviceItemModel1;
  // Model for ServiceItem.
  late ServiceItemModel serviceItemModel2;
  // Model for ServiceItem.
  late ServiceItemModel serviceItemModel3;
  // Model for ServiceItem.
  late ServiceItemModel serviceItemModel4;
  // Model for ServiceItem.
  late ServiceItemModel serviceItemModel5;
  // Model for ServiceItem.
  late ServiceItemModel serviceItemModel6;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    serviceItemModel1 = createModel(context, () => ServiceItemModel());
    serviceItemModel2 = createModel(context, () => ServiceItemModel());
    serviceItemModel3 = createModel(context, () => ServiceItemModel());
    serviceItemModel4 = createModel(context, () => ServiceItemModel());
    serviceItemModel5 = createModel(context, () => ServiceItemModel());
    serviceItemModel6 = createModel(context, () => ServiceItemModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    serviceItemModel1.dispose();
    serviceItemModel2.dispose();
    serviceItemModel3.dispose();
    serviceItemModel4.dispose();
    serviceItemModel5.dispose();
    serviceItemModel6.dispose();
    buttonModel.dispose();
  }
}

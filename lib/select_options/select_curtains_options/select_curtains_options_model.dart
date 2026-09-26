import '/components/button/button_widget.dart';
import '/components/service_item/service_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/parametr_curtains/curtains/curtains_widget.dart';
import '/parametr_curtains/lambrequin/lambrequin_widget.dart';
import '/parametr_curtains/roman_curtain/roman_curtain_widget.dart';
import '/parametr_curtains/tulle/tulle_widget.dart';
import 'dart:ui';
import 'select_curtains_options_widget.dart' show SelectCurtainsOptionsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectCurtainsOptionsModel
    extends FlutterFlowModel<SelectCurtainsOptionsWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ServiceItem.
  late ServiceItemModel serviceItemModel1;
  // Model for ServiceItem.
  late ServiceItemModel serviceItemModel2;
  // Model for ServiceItem.
  late ServiceItemModel serviceItemModel3;
  // Model for ServiceItem.
  late ServiceItemModel serviceItemModel4;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    serviceItemModel1 = createModel(context, () => ServiceItemModel());
    serviceItemModel2 = createModel(context, () => ServiceItemModel());
    serviceItemModel3 = createModel(context, () => ServiceItemModel());
    serviceItemModel4 = createModel(context, () => ServiceItemModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    serviceItemModel1.dispose();
    serviceItemModel2.dispose();
    serviceItemModel3.dispose();
    serviceItemModel4.dispose();
    buttonModel.dispose();
  }
}

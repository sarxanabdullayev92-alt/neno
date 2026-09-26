import '/components/added_work_row/added_work_row_widget.dart';
import '/components/button/button_widget.dart';
import '/components/service_item2/service_item2_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'additional_works_widget.dart' show AdditionalWorksWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdditionalWorksModel extends FlutterFlowModel<AdditionalWorksWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for ServiceItem.
  late ServiceItem2Model serviceItemModel1;
  // Model for ServiceItem.
  late ServiceItem2Model serviceItemModel2;
  // Model for ServiceItem.
  late ServiceItem2Model serviceItemModel3;
  // Model for ServiceItem.
  late ServiceItem2Model serviceItemModel4;
  // Model for ServiceItem.
  late ServiceItem2Model serviceItemModel5;
  // Model for AddedWorkRow.
  late AddedWorkRowModel addedWorkRowModel1;
  // Model for AddedWorkRow.
  late AddedWorkRowModel addedWorkRowModel2;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;

  @override
  void initState(BuildContext context) {
    serviceItemModel1 = createModel(context, () => ServiceItem2Model());
    serviceItemModel2 = createModel(context, () => ServiceItem2Model());
    serviceItemModel3 = createModel(context, () => ServiceItem2Model());
    serviceItemModel4 = createModel(context, () => ServiceItem2Model());
    serviceItemModel5 = createModel(context, () => ServiceItem2Model());
    addedWorkRowModel1 = createModel(context, () => AddedWorkRowModel());
    addedWorkRowModel2 = createModel(context, () => AddedWorkRowModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    serviceItemModel1.dispose();
    serviceItemModel2.dispose();
    serviceItemModel3.dispose();
    serviceItemModel4.dispose();
    serviceItemModel5.dispose();
    addedWorkRowModel1.dispose();
    addedWorkRowModel2.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}

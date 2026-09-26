import '/backend/supabase/supabase.dart';
import '/components/button/button_widget.dart';
import '/components/info_row2/info_row2_widget.dart';
import '/components/service_item/service_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'active_order_detail_widget.dart' show ActiveOrderDetailWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ActiveOrderDetailModel extends FlutterFlowModel<ActiveOrderDetailWidget> {
  ///  Local state fields for this page.

  double? routeKm;

  double? routeMin;

  ///  State fields for stateful widgets in this page.

  // Model for InfoRow.
  late InfoRow2Model infoRowModel1;
  // Model for InfoRow.
  late InfoRow2Model infoRowModel2;
  // Model for InfoRow.
  late InfoRow2Model infoRowModel3;
  // Model for InfoRow.
  late InfoRow2Model infoRowModel4;
  // Model for ServiceItem.
  late ServiceItemModel serviceItemModel1;
  // Model for ServiceItem.
  late ServiceItemModel serviceItemModel2;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;
  // Model for Button.
  late ButtonModel buttonModel3;
  // Model for Button.
  late ButtonModel buttonModel4;

  @override
  void initState(BuildContext context) {
    infoRowModel1 = createModel(context, () => InfoRow2Model());
    infoRowModel2 = createModel(context, () => InfoRow2Model());
    infoRowModel3 = createModel(context, () => InfoRow2Model());
    infoRowModel4 = createModel(context, () => InfoRow2Model());
    serviceItemModel1 = createModel(context, () => ServiceItemModel());
    serviceItemModel2 = createModel(context, () => ServiceItemModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
    buttonModel3 = createModel(context, () => ButtonModel());
    buttonModel4 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    infoRowModel1.dispose();
    infoRowModel2.dispose();
    infoRowModel3.dispose();
    infoRowModel4.dispose();
    serviceItemModel1.dispose();
    serviceItemModel2.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
    buttonModel3.dispose();
    buttonModel4.dispose();
  }
}

import '/backend/supabase/supabase.dart';
import '/components/button/button_widget.dart';
import '/components/info_row/info_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'order_offer_widget.dart' show OrderOfferWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderOfferModel extends FlutterFlowModel<OrderOfferWidget> {
  ///  Local state fields for this page.

  double? routeKm;

  double? routeMin;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getMyLocation] action in OrderOffer widget.
  List<double>? myLocation;
  // Stores action output result for [Backend Call - Query Rows] action in OrderOffer widget.
  List<OrdersRow>? orderRows;
  // Stores action output result for [Custom Action - getRouteInfo] action in OrderOffer widget.
  List<double>? routeInfo;
  // Model for InfoRow.
  late InfoRowModel infoRowModel1;
  // Model for InfoRow.
  late InfoRowModel infoRowModel2;
  // Model for InfoRow.
  late InfoRowModel infoRowModel3;
  // Model for InfoRow.
  late InfoRowModel infoRowModel4;
  // Model for InfoRow.
  late InfoRowModel infoRowModel5;
  // Model for InfoRow.
  late InfoRowModel infoRowModel6;
  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for Button.
  late ButtonModel buttonModel2;
  // Stores action output result for [Custom Action - acceptOrder] action in Button widget.
  String? acceptResult;

  @override
  void initState(BuildContext context) {
    infoRowModel1 = createModel(context, () => InfoRowModel());
    infoRowModel2 = createModel(context, () => InfoRowModel());
    infoRowModel3 = createModel(context, () => InfoRowModel());
    infoRowModel4 = createModel(context, () => InfoRowModel());
    infoRowModel5 = createModel(context, () => InfoRowModel());
    infoRowModel6 = createModel(context, () => InfoRowModel());
    buttonModel1 = createModel(context, () => ButtonModel());
    buttonModel2 = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    infoRowModel1.dispose();
    infoRowModel2.dispose();
    infoRowModel3.dispose();
    infoRowModel4.dispose();
    infoRowModel5.dispose();
    infoRowModel6.dispose();
    buttonModel1.dispose();
    buttonModel2.dispose();
  }
}

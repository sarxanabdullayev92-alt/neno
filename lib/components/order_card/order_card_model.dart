import '/components/order_status_badge/order_status_badge_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'order_card_widget.dart' show OrderCardWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderCardModel extends FlutterFlowModel<OrderCardWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for OrderStatusBadge.
  late OrderStatusBadgeModel orderStatusBadgeModel;

  @override
  void initState(BuildContext context) {
    orderStatusBadgeModel = createModel(context, () => OrderStatusBadgeModel());
  }

  @override
  void dispose() {
    orderStatusBadgeModel.dispose();
  }
}

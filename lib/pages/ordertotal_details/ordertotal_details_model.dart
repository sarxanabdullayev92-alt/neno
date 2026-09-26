import '/components/button/button_widget.dart';
import '/components/order_item_row/order_item_row_widget.dart';
import '/components/status_badge/status_badge_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'ordertotal_details_widget.dart' show OrdertotalDetailsWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrdertotalDetailsModel extends FlutterFlowModel<OrdertotalDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for StatusBadge.
  late StatusBadgeModel statusBadgeModel;
  // State field(s) for RatingBar widget.
  double? ratingBarValue;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue;
  // Model for OrderItemRow.
  late OrderItemRowModel orderItemRowModel1;
  // Model for OrderItemRow.
  late OrderItemRowModel orderItemRowModel2;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    statusBadgeModel = createModel(context, () => StatusBadgeModel());
    orderItemRowModel1 = createModel(context, () => OrderItemRowModel());
    orderItemRowModel2 = createModel(context, () => OrderItemRowModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    statusBadgeModel.dispose();
    orderItemRowModel1.dispose();
    orderItemRowModel2.dispose();
    buttonModel.dispose();
  }
}

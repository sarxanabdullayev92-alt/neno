import '/components/bottom_nav/bottom_nav_widget.dart';
import '/components/bottom_nav_child/bottom_nav_child_widget.dart';
import '/components/order_item/order_item_widget.dart';
import '/components/tab_item/tab_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'order_list_widget.dart' show OrderListWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderListModel extends FlutterFlowModel<OrderListWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for TabItem.
  late TabItemModel tabItemModel1;
  // Model for TabItem.
  late TabItemModel tabItemModel2;
  // Model for TabItem.
  late TabItemModel tabItemModel3;
  // Model for OrderItem.
  late OrderItemModel orderItemModel1;
  // Model for OrderItem.
  late OrderItemModel orderItemModel2;
  // Model for OrderItem.
  late OrderItemModel orderItemModel3;
  // Model for BottomNav.
  late BottomNavModel bottomNavModel;

  @override
  void initState(BuildContext context) {
    tabItemModel1 = createModel(context, () => TabItemModel());
    tabItemModel2 = createModel(context, () => TabItemModel());
    tabItemModel3 = createModel(context, () => TabItemModel());
    orderItemModel1 = createModel(context, () => OrderItemModel());
    orderItemModel2 = createModel(context, () => OrderItemModel());
    orderItemModel3 = createModel(context, () => OrderItemModel());
    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  @override
  void dispose() {
    tabItemModel1.dispose();
    tabItemModel2.dispose();
    tabItemModel3.dispose();
    orderItemModel1.dispose();
    orderItemModel2.dispose();
    orderItemModel3.dispose();
    bottomNavModel.dispose();
  }
}

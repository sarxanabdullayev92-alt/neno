import '/backend/supabase/supabase.dart';
import '/components/bottom_nav/bottom_nav_widget.dart';
import '/components/bottom_nav_child2/bottom_nav_child2_widget.dart';
import '/components/tab_item/tab_item_widget.dart';
import '/components/transaction_row/transaction_row_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'earnings_wallet_widget.dart' show EarningsWalletWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EarningsWalletModel extends FlutterFlowModel<EarningsWalletWidget> {
  ///  Local state fields for this page.

  double? routeKm;

  double? routeMin;

  ///  State fields for stateful widgets in this page.

  // Model for TabItem.
  late TabItemModel tabItemModel1;
  // Model for TabItem.
  late TabItemModel tabItemModel2;
  // Model for TabItem.
  late TabItemModel tabItemModel3;
  // Model for TabItem.
  late TabItemModel tabItemModel4;
  // Model for TransactionRow.
  late TransactionRowModel transactionRowModel1;
  // Model for TransactionRow.
  late TransactionRowModel transactionRowModel2;
  // Model for TransactionRow.
  late TransactionRowModel transactionRowModel3;
  // Model for TransactionRow.
  late TransactionRowModel transactionRowModel4;
  // Model for BottomNav.
  late BottomNavModel bottomNavModel;

  @override
  void initState(BuildContext context) {
    tabItemModel1 = createModel(context, () => TabItemModel());
    tabItemModel2 = createModel(context, () => TabItemModel());
    tabItemModel3 = createModel(context, () => TabItemModel());
    tabItemModel4 = createModel(context, () => TabItemModel());
    transactionRowModel1 = createModel(context, () => TransactionRowModel());
    transactionRowModel2 = createModel(context, () => TransactionRowModel());
    transactionRowModel3 = createModel(context, () => TransactionRowModel());
    transactionRowModel4 = createModel(context, () => TransactionRowModel());
    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  @override
  void dispose() {
    tabItemModel1.dispose();
    tabItemModel2.dispose();
    tabItemModel3.dispose();
    tabItemModel4.dispose();
    transactionRowModel1.dispose();
    transactionRowModel2.dispose();
    transactionRowModel3.dispose();
    transactionRowModel4.dispose();
    bottomNavModel.dispose();
  }
}

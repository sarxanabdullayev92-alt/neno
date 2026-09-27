import '/auth/supabase_auth/auth_util.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/action_row/action_row_widget.dart';
import '/components/action_row_copy/action_row_copy_widget.dart';
import '/components/category_item/category_item_widget.dart';
import '/components/coment_widget.dart';
import '/components/other_people_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/profile/cash/cash_widget.dart';
import '/select_options/select_carpet_options/select_carpet_options_widget.dart';
import '/select_options/select_chair_options/select_chair_options_widget.dart';
import '/select_options/select_curtains_options/select_curtains_options_widget.dart';
import '/select_options/select_leather_options/select_leather_options_widget.dart';
import '/select_options/select_matras_options/select_matras_options_widget.dart';
import '/select_options/selectsofa_options/selectsofa_options_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'product_details_widget.dart' show ProductDetailsWidget;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailsModel extends FlutterFlowModel<ProductDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  Stream<List<ServicesRow>>? rowSupabaseStream;
  // Stores action output result for [Custom Action - getAllProductTypes] action in Container widget.
  List<String>? allProductType;
  // Model for ActionRow.
  late ActionRowModel actionRowModel1;
  // Model for ActionRow.
  late ActionRowModel actionRowModel2;
  // Model for ActionRowCopy component.
  late ActionRowCopyModel actionRowCopyModel;
  DateTime? datePicked;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  OrdersRow? theOrderRow;

  @override
  void initState(BuildContext context) {
    actionRowModel1 = createModel(context, () => ActionRowModel());
    actionRowModel2 = createModel(context, () => ActionRowModel());
    actionRowCopyModel = createModel(context, () => ActionRowCopyModel());
  }

  @override
  void dispose() {
    actionRowModel1.dispose();
    actionRowModel2.dispose();
    actionRowCopyModel.dispose();
  }
}

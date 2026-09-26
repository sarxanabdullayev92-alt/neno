import '/components/button/button_widget.dart';
import '/components/saved_address_item/saved_address_item_widget.dart';
import '/components/text_field/text_field_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'searching_for_address_widget.dart' show SearchingForAddressWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchingForAddressModel
    extends FlutterFlowModel<SearchingForAddressWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - getMyLocation] action in SearchingForAddress widget.
  List<double>? myLocation;
  // Model for TextField.
  late TextFieldModel textFieldModel1;
  // Model for TextField.
  late TextFieldModel textFieldModel2;
  // Model for TextField.
  late TextFieldModel textFieldModel3;
  // Model for TextField.
  late TextFieldModel textFieldModel4;
  // Model for TextField.
  late TextFieldModel textFieldModel5;
  // Model for SavedAddressItem.
  late SavedAddressItemModel savedAddressItemModel1;
  // Model for SavedAddressItem.
  late SavedAddressItemModel savedAddressItemModel2;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    textFieldModel1 = createModel(context, () => TextFieldModel());
    textFieldModel2 = createModel(context, () => TextFieldModel());
    textFieldModel3 = createModel(context, () => TextFieldModel());
    textFieldModel4 = createModel(context, () => TextFieldModel());
    textFieldModel5 = createModel(context, () => TextFieldModel());
    savedAddressItemModel1 =
        createModel(context, () => SavedAddressItemModel());
    savedAddressItemModel2 =
        createModel(context, () => SavedAddressItemModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    textFieldModel1.dispose();
    textFieldModel2.dispose();
    textFieldModel3.dispose();
    textFieldModel4.dispose();
    textFieldModel5.dispose();
    savedAddressItemModel1.dispose();
    savedAddressItemModel2.dispose();
    buttonModel.dispose();
  }
}

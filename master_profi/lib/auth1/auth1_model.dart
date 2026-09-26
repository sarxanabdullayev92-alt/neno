import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'auth1_widget.dart' show Auth1Widget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Auth1Model extends FlutterFlowModel<Auth1Widget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode1;
  TextEditingController? emailAddressTextController1;
  String? Function(BuildContext, String?)? emailAddressTextController1Validator;
  // State field(s) for passwordSingIn widget.
  FocusNode? passwordSingInFocusNode;
  TextEditingController? passwordSingInTextController;
  late bool passwordSingInVisibility;
  String? Function(BuildContext, String?)?
      passwordSingInTextControllerValidator;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<MastersRow>? masterRows;
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode2;
  TextEditingController? emailAddressTextController2;
  String? Function(BuildContext, String?)? emailAddressTextController2Validator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  // State field(s) for RepeatePassword widget.
  FocusNode? repeatePasswordFocusNode;
  TextEditingController? repeatePasswordTextController;
  late bool repeatePasswordVisibility;
  String? Function(BuildContext, String?)?
      repeatePasswordTextControllerValidator;
  // Stores action output result for [Backend Call - Insert Row] action in signupButton widget.
  MastersRow? createdMaster;

  @override
  void initState(BuildContext context) {
    passwordSingInVisibility = false;
    passwordVisibility = false;
    repeatePasswordVisibility = false;
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    emailAddressFocusNode1?.dispose();
    emailAddressTextController1?.dispose();

    passwordSingInFocusNode?.dispose();
    passwordSingInTextController?.dispose();

    emailAddressFocusNode2?.dispose();
    emailAddressTextController2?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    repeatePasswordFocusNode?.dispose();
    repeatePasswordTextController?.dispose();
  }
}

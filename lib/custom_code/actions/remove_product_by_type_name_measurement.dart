// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future removeProductByTypeNameMeasurement(
  String? productType,
  String? productName,
  String? measurement,
) async {
  final typeToRemove = productType ?? '';
  final nameToRemove = productName ?? '';
  final measurementToRemove = measurement ?? '';

  if (typeToRemove.isEmpty ||
      nameToRemove.isEmpty ||
      measurementToRemove.isEmpty) {
    // Need all 3 to identify a match, so bail out if any is missing
    return;
  }

  FFAppState().TheProductList.removeWhere(
        (item) =>
            item.productType == typeToRemove &&
            item.productName == nameToRemove &&
            item.measurement == measurementToRemove,
      );

  FFAppState().update(() {
    FFAppState().TheProductList = FFAppState().TheProductList.toList();
  });
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!

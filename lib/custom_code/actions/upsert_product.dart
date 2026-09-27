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

Future upsertProduct(
  String? productType,
  String? productName,
  String? measurement,
  double? costper1,
  int? quantity,
) async {
  final typeVal = productType ?? '';
  final nameVal = productName ?? '';
  final measurementVal = measurement ?? '';
  final costVal = costper1 ?? 0.0;
  final quantityVal = quantity ?? 0;

  if (typeVal.isEmpty || nameVal.isEmpty || measurementVal.isEmpty) {
    // Not enough info to identify or create a valid item
    return;
  }

  final list = FFAppState().TheProductList;

  final existingIndex = list.indexWhere(
    (item) =>
        item.productType == typeVal &&
        item.productName == nameVal &&
        item.measurement == measurementVal &&
        item.costper1 == costVal,
  );

  if (existingIndex != -1) {
    // Match found — update its quantity
    list[existingIndex].quantity = quantityVal;
  } else {
    // No match — insert a new item
    list.add(
      NumberAndPricesStruct(
        productType: typeVal,
        productName: nameVal,
        measurement: measurementVal,
        costper1: costVal,
        quantity: quantityVal,
      ),
    );
  }

  FFAppState().update(() {});
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!

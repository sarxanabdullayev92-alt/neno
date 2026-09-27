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

Future insertAllProductsToUnitDetails() async {
  final list = FFAppState().TheProductList;

  for (final item in list) {
    await SupaFlow.client.from('unitdetails').insert({
      'unitMeasure': item.measurement,
      'price': item.costper1,
      'quantity': item.quantity,
      'productType': item.productType,
      'productName': item.productName,
    });
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!

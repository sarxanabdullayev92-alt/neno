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

Future<bool?> insertAllProductsToUnitDetails(int orderId) async {
  final rows = FFAppState()
      .TheProductList
      .where((item) =>
          item.quantity > 0 &&
          item.productType.isNotEmpty &&
          item.productType != 'Hello World')
      .map((item) => {
            'order_id': orderId,
            'unitMeasure': item.measurement,
            'price': item.costper1,
            'quantity': item.quantity,
            'productType': item.productType,
            'productName': item.productName,
          })
      .toList();

  if (rows.isEmpty) return true;

  try {
    await SupaFlow.client.from('unitdetails').insert(rows);
    return true;
  } catch (_) {
    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!

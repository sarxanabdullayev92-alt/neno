// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!

import 'package:supabase_flutter/supabase_flutter.dart';

Future<String?> acceptOrder(int orderId) async {
  try {
    await Supabase.instance.client.rpc(
      'accept_order',
      params: {'p_order_id': orderId},
    );
    return 'ok';
  } on PostgrestException catch (e) {
    final msg = e.message.toLowerCase();
    if (msg.contains('already taken')) return 'taken';
    if (msg.contains('not a master')) return 'notmaster';
    return 'error';
  } catch (_) {
    return 'error';
  }
}

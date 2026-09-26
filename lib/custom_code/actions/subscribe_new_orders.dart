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

import 'package:supabase_flutter/supabase_flutter.dart';

RealtimeChannel? _newOrdersChannel;

Future<bool?> subscribeNewOrders(
  bool enabled,
  String? city,
  Future Function(int orderId)? onNewOrder,
) async {
  // --- отписка ---
  if (!enabled) {
    try {
      await _newOrdersChannel?.unsubscribe();
    } catch (_) {}
    _newOrdersChannel = null;
    return true;
  }

  // повторная подписка на тот же канал не нужна
  if (_newOrdersChannel != null) return true;

  try {
    _newOrdersChannel = Supabase.instance.client
        .channel('new_orders_feed')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'orders',
          callback: (payload) {
            final rec = payload.newRecord;

            // заказ уже кем-то занят — не дёргаем мастера
            if (rec['mastersID'] != null) return;

            // фильтр по городу делаем здесь: в Realtime-фильтре нельзя
            // задать «город совпадает ИЛИ город не указан»
            if (city != null && city.trim().isNotEmpty) {
              final orderCity = (rec['city'] ?? '').toString().trim();
              if (orderCity.isNotEmpty &&
                  orderCity.toLowerCase() != city.trim().toLowerCase()) {
                return;
              }
            }

            final id = rec['id'];
            final orderId = id is int ? id : int.tryParse('$id');
            if (orderId != null) onNewOrder?.call(orderId);
          },
        )
        .subscribe();

    return true;
  } catch (_) {
    _newOrdersChannel = null;
    return false;
  }
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!

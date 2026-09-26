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
// ============================================================================
// FlutterFlow → Custom Code → Custom Actions → + Add
// Имя: subscribeNewOrders
// Ставится ТОЛЬКО в master_profi (приложение мастера)
//
// Зависимости: дополнительных нет
//
// Параметры:
//   enabled    bool     обязательный   подписаться / отписаться
//   city       String   Nullable       слушать только свой город
//   onNewOrder Action   Nullable       вызывается при новом заказе,
//                                      параметр orderId (int)
//
// Return Type: bool (Nullable ✓)
//
// Вешать на страницу WorkMain: On Page Load → subscribeNewOrders(true, ...),
// в onNewOrder показать алерт / перейти на OrderOffer.
// Не забудьте вызвать с enabled = false при уходе со страницы.
// ============================================================================

import 'package:supabase_flutter/supabase_flutter.dart';

RealtimeChannel? _newOrdersChannel;

// Обработчик и город храним отдельно от канала: при повторном заходе на
// страницу канал переиспользуется, а вызываться должен обработчик новой
// страницы, а не той, что уже закрыта.
Future Function(int orderId)? _newOrdersHandler;
String? _newOrdersCity;

Future<bool?> subscribeNewOrders(
  bool enabled,
  String? city,
  Future Function(int orderId)? onNewOrder,
) async {
  // --- отписка ---
  if (!enabled) {
    _newOrdersHandler = null;
    try {
      await _newOrdersChannel?.unsubscribe();
    } catch (_) {}
    _newOrdersChannel = null;
    return true;
  }

  _newOrdersHandler = onNewOrder;
  _newOrdersCity = city;

  // канал уже открыт — достаточно обновить обработчик
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
            final myCity = _newOrdersCity;
            if (myCity != null && myCity.trim().isNotEmpty) {
              final orderCity = (rec['city'] ?? '').toString().trim();
              if (orderCity.isNotEmpty &&
                  orderCity.toLowerCase() != myCity.trim().toLowerCase()) {
                return;
              }
            }

            final id = rec['id'];
            final orderId = id is int ? id : int.tryParse('$id');
            if (orderId != null) _newOrdersHandler?.call(orderId);
          },
        )
        .subscribe();

    return true;
  } catch (_) {
    _newOrdersChannel = null;
    return false;
  }
}

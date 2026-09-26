// ============================================================================
// FlutterFlow → Custom Code → Custom Actions → + Add
// Имя: subscribeMyOrder
// Ставится ТОЛЬКО в nado_clean (приложение клиента)
//
// Зависимости: дополнительных нет
//
// Параметры:
//   enabled          bool     обязательный   следить / перестать следить
//   orderId          int      Nullable       id заказа клиента
//   onAccepted       Action   Nullable       мастер принял заказ,
//                                            параметр masterId (int)
//   onStatusChanged  Action   Nullable       статус заказа поменялся,
//                                            параметр status (String)
//
// Return Type: bool (Nullable ✓)
//
// Сразу после подписки заказ читается один раз: если мастер принял его,
// пока приложение было закрыто, onAccepted сработает сразу, а не только
// при следующем изменении.
//
// Вешать на страницу, где клиент ждёт мастера: On Page Load.
// В onAccepted — записать masterId в App State и показать карту с маршрутом.
// ============================================================================

import 'package:supabase_flutter/supabase_flutter.dart';

RealtimeChannel? _myOrderChannel;
int? _myOrderId;

// Обработчики храним отдельно: при повторном заходе на страницу должны
// вызываться обработчики новой страницы, а не той, что уже закрыта.
Future Function(int masterId)? _myOrderOnAccepted;
Future Function(String status)? _myOrderOnStatus;

int? _lastMasterId;
String? _lastStatus;

Future<bool?> subscribeMyOrder(
  bool enabled,
  int? orderId,
  Future Function(int masterId)? onAccepted,
  Future Function(String status)? onStatusChanged,
) async {
  // --- отписка ---
  if (!enabled || orderId == null) {
    await _closeMyOrderChannel();
    return true;
  }

  _myOrderOnAccepted = onAccepted;
  _myOrderOnStatus = onStatusChanged;

  // другой заказ — начинаем с чистого листа
  if (_myOrderId != orderId) {
    await _closeMyOrderChannel();
    _myOrderOnAccepted = onAccepted;
    _myOrderOnStatus = onStatusChanged;
    _myOrderId = orderId;
  }

  final client = Supabase.instance.client;

  try {
    if (_myOrderChannel == null) {
      _myOrderChannel = client
          .channel('my_order_$orderId')
          .onPostgresChanges(
            event: PostgresChangeEvent.update,
            schema: 'public',
            table: 'orders',
            filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'id',
              value: orderId,
            ),
            callback: (payload) => _handleOrderRow(payload.newRecord),
          )
          .subscribe();
    }

    // текущее состояние — вдруг заказ уже принят
    final row = await client
        .from('orders')
        .select('id, mastersID, orderStatus')
        .eq('id', orderId)
        .maybeSingle();
    if (row != null) {
      // сбрасываем «последние значения», чтобы новая страница получила
      // обработчики даже по уже известному состоянию
      _lastMasterId = null;
      _lastStatus = null;
      _handleOrderRow(row);
    }

    return true;
  } catch (_) {
    return false;
  }
}

void _handleOrderRow(Map<String, dynamic> rec) {
  final rawMaster = rec['mastersID'];
  final masterId =
      rawMaster is int ? rawMaster : int.tryParse('${rawMaster ?? ''}');
  final status = (rec['orderStatus'] ?? '').toString();

  if (masterId != null && masterId != _lastMasterId) {
    _lastMasterId = masterId;
    _myOrderOnAccepted?.call(masterId);
  }

  if (status.isNotEmpty && status != _lastStatus) {
    _lastStatus = status;
    _myOrderOnStatus?.call(status);
  }
}

Future<void> _closeMyOrderChannel() async {
  try {
    await _myOrderChannel?.unsubscribe();
  } catch (_) {}
  _myOrderChannel = null;
  _myOrderId = null;
  _myOrderOnAccepted = null;
  _myOrderOnStatus = null;
  _lastMasterId = null;
  _lastStatus = null;
}

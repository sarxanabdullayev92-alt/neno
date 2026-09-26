// ============================================================================
// FlutterFlow → Custom Code → Custom Actions → + Add
// Имя: acceptOrder
// Ставится ТОЛЬКО в master_profi (приложение мастера)
//
// Зависимости: дополнительных нет (supabase_flutter уже в проекте)
//
// Параметры:
//   orderId   int   обязательный
//
// Return Type: String (Nullable ✓)
//   "ok"      — заказ закреплён за вами
//   "taken"   — другой мастер успел раньше
//   "notmaster" — текущий пользователь не зарегистрирован как мастер
//   "error"   — сеть или прочий сбой
//
// Захват заказа атомарный: внутри RPC стоит условие «mastersID is null»,
// поэтому при одновременном нажатии двух мастеров второй получит "taken",
// а не перезапишет чужой заказ.
//
// Вешать на кнопку «ПРИНЯТЬ ЗАКАЗ» на странице OrderOffer.
// ============================================================================

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

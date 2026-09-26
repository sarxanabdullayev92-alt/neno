// Сквозная проверка живого трекинга:
//   мастер шлёт позицию через RPC → второй клиент видит движение по Realtime.
// Запуск: dart run tool/realtime_check.dart
// Диагностический скрипт, в приложение не входит.
//
// Токены получаем через REST: чистый Dart (без Flutter) не имеет
// хранилища сессии, поэтому auth.signUp здесь не используется.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:supabase/supabase.dart';

const _url = 'https://ugitubelnid.beget.app';
const _anon =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlzcyI6InN1cGFiYXNlIiwiaWF0IjoxNzg4NTY2NDAwLCJleHAiOjE5NDYzMzI4MDB9.xNIxrgeEL4AkIclz6xabUNvE-EBITuoJZIOYicvZSKo';

/// Регистрирует пользователя и возвращает (uid, access_token).
Future<(String, String)> _signUp(String email) async {
  final resp = await http.post(
    Uri.parse('$_url/auth/v1/signup'),
    headers: {'apikey': _anon, 'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': 'MapTest2026!'}),
  );
  final body = jsonDecode(resp.body) as Map<String, dynamic>;
  final token = body['access_token'] as String?;
  final uid = (body['user'] as Map?)?['id'] as String?;
  if (token == null || uid == null) {
    throw StateError('регистрация не удалась: ${resp.body}');
  }
  return (uid, token);
}

SupabaseClient _authed(String token) => SupabaseClient(
      _url,
      _anon,
      headers: {'Authorization': 'Bearer $token'},
    );

Future<void> main() async {
  final stamp = DateTime.now().millisecondsSinceEpoch;

  // --- 1. мастер ---
  final (masterUid, masterToken) = await _signUp('maptest.master.$stamp@example.com');
  stdout.writeln('мастер:  $masterUid');
  final master = _authed(masterToken);
  master.realtime.setAuth(masterToken);

  // masters.user_profile ссылается на profile.id — профиль нужен первым
  await master.from('profile').insert({'id': masterUid, 'name': 'Тест Мастер'});
  await master.from('masters').update({'user_profile': masterUid}).eq('id', 1);
  stdout.writeln('привязан к masters.id = 1');

  // --- 2. клиент, отдельная сессия ---
  final (viewerUid, viewerToken) = await _signUp('maptest.viewer.$stamp@example.com');
  stdout.writeln('клиент:  $viewerUid');
  final viewer = _authed(viewerToken);
  viewer.realtime.setAuth(viewerToken);

  final got = Completer<Map<String, dynamic>>();
  final channel = viewer
      .channel('master_track_1')
      .onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: 'masters',
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: 'id',
          value: 1,
        ),
        callback: (payload) {
          if (!got.isCompleted) got.complete(payload.newRecord);
        },
      )
      .subscribe((status, err) {
        stdout.writeln('канал клиента: $status'
            '${err != null ? "  ошибка: $err" : ""}');
      });

  await Future.delayed(const Duration(seconds: 5));

  // --- 3. мастер шлёт позицию (это и делает setMasterTracking) ---
  stdout.writeln('мастер отправляет позицию...');
  await master.rpc('update_master_location', params: {
    'p_lat': 55.7600,
    'p_lng': 37.6200,
    'p_heading': 90.0,
    'p_is_online': true,
    'p_city': 'Москва',
  });
  stdout.writeln('отправлено');

  // --- 4. клиент должен увидеть движение ---
  try {
    final rec = await got.future.timeout(const Duration(seconds: 25));
    stdout.writeln('');
    stdout.writeln('КЛИЕНТ УВИДЕЛ ДВИЖЕНИЕ МАСТЕРА:');
    stdout.writeln('  lat   = ${rec['latitude']}');
    stdout.writeln('  lng   = ${rec['longitude']}');
    stdout.writeln('  время = ${rec['location_updated_at']}');
    stdout.writeln('');
    stdout.writeln('Живой трекинг работает.');
  } on TimeoutException {
    stdout.writeln('');
    stdout.writeln('событие НЕ пришло за 25 секунд');
    exitCode = 1;
  }

  await channel.unsubscribe();
  await master.dispose();
  await viewer.dispose();
}

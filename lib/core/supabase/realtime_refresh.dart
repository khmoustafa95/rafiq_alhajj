import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const _realtimeDebounce = Duration(milliseconds: 400);

/// Coalesces rapid realtime events (e.g. initial snapshots on 5 tables) into one refresh.
void Function() _debouncedCallback(
  Ref ref, {
  void Function()? onEvent,
  Duration debounce = _realtimeDebounce,
}) {
  Timer? debounceTimer;
  final callback = onEvent ?? () => ref.invalidateSelf();

  ref.onDispose(() => debounceTimer?.cancel());

  return () {
    debounceTimer?.cancel();
    debounceTimer = Timer(debounce, callback);
  };
}

/// Subscribes to Supabase Realtime table streams and triggers [onEvent].
void watchSupabaseTable(
  Ref ref, {
  required SupabaseClient? client,
  required String table,
  List<String> primaryKey = const ['id'],
  String? eqColumn,
  Object? eqValue,
  void Function()? onEvent,
}) {
  if (client == null) {
    return;
  }

  final query = client.from(table).stream(primaryKey: primaryKey);
  final stream = eqColumn != null && eqValue != null
      ? query.eq(eqColumn, eqValue)
      : query;

  final schedule = _debouncedCallback(ref, onEvent: onEvent);
  final subscription = stream.listen((_) => schedule());

  ref.onDispose(() => unawaited(subscription.cancel()));
}

/// Subscribes to multiple tables; any change triggers [onEvent] once per debounce window.
void watchSupabaseTables(
  Ref ref, {
  required SupabaseClient? client,
  required List<String> tables,
  void Function()? onEvent,
}) {
  if (client == null) {
    return;
  }

  final schedule = _debouncedCallback(ref, onEvent: onEvent);
  final subscriptions = <StreamSubscription<List<Map<String, dynamic>>>>[];

  for (final table in tables) {
    subscriptions.add(
      client.from(table).stream(primaryKey: ['id']).listen((_) => schedule()),
    );
  }

  ref.onDispose(() {
    for (final subscription in subscriptions) {
      unawaited(subscription.cancel());
    }
  });
}

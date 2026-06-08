import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  final callback = onEvent ?? () => ref.invalidateSelf();
  final subscription = stream.listen((_) => callback());

  ref.onDispose(() => unawaited(subscription.cancel()));
}

/// Subscribes to multiple tables; any change triggers [onEvent] once per event.
void watchSupabaseTables(
  Ref ref, {
  required SupabaseClient? client,
  required List<String> tables,
  void Function()? onEvent,
}) {
  if (client == null) {
    return;
  }

  final callback = onEvent ?? () => ref.invalidateSelf();
  final subscriptions = <StreamSubscription<List<Map<String, dynamic>>>>[];

  for (final table in tables) {
    subscriptions.add(
      client.from(table).stream(primaryKey: ['id']).listen((_) => callback()),
    );
  }

  ref.onDispose(() {
    for (final subscription in subscriptions) {
      unawaited(subscription.cancel());
    }
  });
}

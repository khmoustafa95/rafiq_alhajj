import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/telemetry/agent_debug_log.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const _realtimeDebounce = Duration(milliseconds: 400);

typedef _RealtimeSchedule = void Function({String? table});

void _handleRealtimeStreamError(
  Object error,
  StackTrace stackTrace,
  String table,
) {
  if (kDebugMode) {
    debugPrint('Realtime stream unavailable for $table: $error');
  }
}

/// Coalesces rapid realtime events (e.g. initial snapshots on 5 tables) into one refresh.
_RealtimeSchedule _debouncedCallback(
  Ref ref, {
  void Function()? onEvent,
  Duration debounce = _realtimeDebounce,
}) {
  Timer? debounceTimer;
  final callback = onEvent ?? () => ref.invalidateSelf();

  ref.onDispose(() => debounceTimer?.cancel());

  return ({String? table}) {
    debounceTimer?.cancel();
    // #region agent log
    if (AppConfig.rebuildDebugLog) {
      agentDebugLog(
        location: 'realtime_refresh.dart:schedule',
        message: 'Realtime event scheduled',
        hypothesisId: 'A',
        data: {'table': table, 'debounceMs': debounce.inMilliseconds},
      );
    }
    // #endregion
    debounceTimer = Timer(debounce, () {
      // #region agent log
      if (AppConfig.rebuildDebugLog) {
        agentDebugLog(
          location: 'realtime_refresh.dart:fire',
          message: 'Realtime debounce fired — invalidating provider',
          hypothesisId: 'A',
          data: {'table': table},
        );
      }
      // #endregion
      callback();
    });
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
  var skipInitialSnapshot = true;
  final subscription = stream.listen(
    (_) {
      if (skipInitialSnapshot) {
        skipInitialSnapshot = false;
        return;
      }
      schedule(table: table);
    },
    onError: (Object error, StackTrace stackTrace) {
      _handleRealtimeStreamError(error, stackTrace, table);
    },
  );

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
    var skipInitialSnapshot = true;
    subscriptions.add(
      client.from(table).stream(primaryKey: ['id']).listen(
        (_) {
          if (skipInitialSnapshot) {
            skipInitialSnapshot = false;
            return;
          }
          schedule(table: table);
        },
        onError: (Object error, StackTrace stackTrace) {
          _handleRealtimeStreamError(error, stackTrace, table);
        },
      ),
    );
  }

  ref.onDispose(() {
    for (final subscription in subscriptions) {
      unawaited(subscription.cancel());
    }
  });
}

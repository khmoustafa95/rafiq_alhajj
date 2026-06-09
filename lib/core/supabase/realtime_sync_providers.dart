import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_refresh.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_tables.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'realtime_sync_providers.g.dart';

SupabaseClient? _realtimeClient() =>
    AppConfig.hasSupabase ? Supabase.instance.client : null;

/// Persistent realtime listeners. Must not live inside autoDispose data providers.
@Riverpod(keepAlive: true)
void realtimeSyncContentFeed(Ref ref) {
  watchSupabaseTables(
    ref,
    client: _realtimeClient(),
    tables: RealtimeTables.contentFeed,
    onEvent: () => RealtimeInvalidationRegistry.fire(ref, RealtimeSyncKeys.contentFeed),
  );
}

@Riverpod(keepAlive: true)
void realtimeSyncPilgrimRegistry(Ref ref) {
  watchSupabaseTables(
    ref,
    client: _realtimeClient(),
    tables: RealtimeTables.pilgrimRegistry,
    onEvent: () =>
        RealtimeInvalidationRegistry.fire(ref, RealtimeSyncKeys.pilgrimRegistry),
  );
}

@Riverpod(keepAlive: true)
void realtimeSyncPilgrimDashboard(Ref ref) {
  watchSupabaseTables(
    ref,
    client: _realtimeClient(),
    tables: RealtimeTables.pilgrimDashboard,
    onEvent: () =>
        RealtimeInvalidationRegistry.fire(ref, RealtimeSyncKeys.pilgrimDashboard),
  );
}

@Riverpod(keepAlive: true)
void realtimeSyncAdminAnalytics(Ref ref) {
  watchSupabaseTables(
    ref,
    client: _realtimeClient(),
    tables: RealtimeTables.adminAnalytics,
    onEvent: () =>
        RealtimeInvalidationRegistry.fire(ref, RealtimeSyncKeys.adminAnalytics),
  );
}

@Riverpod(keepAlive: true)
void realtimeSyncCompetitions(Ref ref) {
  watchSupabaseTables(
    ref,
    client: _realtimeClient(),
    tables: RealtimeTables.competitions,
    onEvent: () =>
        RealtimeInvalidationRegistry.fire(ref, RealtimeSyncKeys.competitions),
  );
}

@Riverpod(keepAlive: true)
void realtimeSyncSystemSettings(Ref ref) {
  watchSupabaseTables(
    ref,
    client: _realtimeClient(),
    tables: const ['system_settings'],
    onEvent: () =>
        RealtimeInvalidationRegistry.fire(ref, RealtimeSyncKeys.systemSettings),
  );
}

@Riverpod(keepAlive: true)
void realtimeSyncAdminOperators(Ref ref) {
  watchSupabaseTables(
    ref,
    client: _realtimeClient(),
    tables: const ['profiles'],
    onEvent: () =>
        RealtimeInvalidationRegistry.fire(ref, RealtimeSyncKeys.adminOperators),
  );
}

@Riverpod(keepAlive: true)
void realtimeSyncAdminGroups(Ref ref) {
  watchSupabaseTables(
    ref,
    client: _realtimeClient(),
    tables: const ['groups', 'group_administration_members'],
    onEvent: () =>
        RealtimeInvalidationRegistry.fire(ref, RealtimeSyncKeys.adminGroups),
  );
}

import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_attach.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_providers.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/sos/application/services/sos_service.dart';
import 'package:rafiq_alhajj/features/sos/data/repositories/sos_repository.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_alert.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_ping.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sos_providers.g.dart';

@Riverpod(keepAlive: true)
SosRepository sosRepository(Ref ref) {
  return SosRepository(AppConfig.hasSupabase ? Supabase.instance.client : null);
}

@Riverpod(keepAlive: true)
SosService sosService(Ref ref) {
  return SosService(ref.watch(sosRepositoryProvider));
}

/// The current pilgrim's active alert (if any).
@riverpod
Future<SosAlert?> mySosAlert(Ref ref) async {
  final profileId = ref.watch(authProfileIdProvider);
  if (profileId == null) {
    return null;
  }

  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.sosAlerts,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncSosAlertsProvider),
    handlerId: 'my_sos_alert',
    // Invalidate through the container: these data providers depend on the
    // sync provider, so `ref.invalidate` would trip Riverpod's debug
    // can-depend-on guard (false-positive cycle) and silently skip the refresh.
    onInvalidate: (ref) => ref.container.invalidate(mySosAlertProvider),
  );

  return ref.read(sosServiceProvider).loadMyActiveAlert(profileId);
}

/// All active alerts visible to the signed-in staff member (RLS-scoped by group).
@riverpod
Future<List<SosAlert>> activeSosAlerts(Ref ref) async {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.sosAlerts,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncSosAlertsProvider),
    handlerId: 'active_sos_alerts',
    onInvalidate: (ref) => ref.container.invalidate(activeSosAlertsProvider),
  );

  return ref.read(sosServiceProvider).loadActiveAlerts();
}

/// Breadcrumb trail for a single alert.
@riverpod
Future<List<SosPing>> sosAlertPings(Ref ref, String alertId) async {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.sosAlerts,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncSosAlertsProvider),
    handlerId: 'sos_pings_$alertId',
    onInvalidate: (ref) =>
        ref.container.invalidate(sosAlertPingsProvider(alertId)),
  );

  return ref.read(sosServiceProvider).loadPings(alertId);
}

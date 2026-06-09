import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_attach.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_providers.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/pilgrim/application/services/pilgrim_dashboard_service.dart';
import 'package:rafiq_alhajj/features/pilgrim/data/repositories/pilgrim_registry_repository.dart';
import 'package:rafiq_alhajj/features/pilgrim/data/repositories/pilgrim_remote_repository.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim_dashboard.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'pilgrim_providers.g.dart';

@Riverpod(keepAlive: true)
PilgrimRemoteRepository pilgrimRemoteRepository(Ref ref) {
  return PilgrimRemoteRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
PilgrimRegistryRepository pilgrimRegistryRepository(Ref ref) {
  return PilgrimRegistryRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
PilgrimDashboardService pilgrimDashboardService(Ref ref) {
  return PilgrimDashboardService(
    ref.watch(pilgrimRemoteRepositoryProvider),
    ref.watch(pilgrimRegistryRepositoryProvider),
  );
}

@riverpod
String? pilgrimUserId(Ref ref) {
  if (ref.watch(authAccessModeProvider) != AppAccessMode.pilgrim) {
    return null;
  }
  return ref.watch(authProfileIdProvider);
}

@riverpod
class PilgrimDashboardState extends _$PilgrimDashboardState {
  @override
  Future<PilgrimDashboard> build() async {
    final pilgrimId = ref.watch(pilgrimUserIdProvider);
    if (pilgrimId == null) {
      throw const PilgrimAccessDeniedException();
    }

    attachRealtimeSync(
      ref,
      syncKey: RealtimeSyncKeys.pilgrimDashboard,
      ensureSyncActive: (ref) => ref.watch(realtimeSyncPilgrimDashboardProvider),
      handlerId: 'pilgrim_dashboard',
      onInvalidate: (ref) => RealtimeInvalidationRegistry.safeInvalidate(
        ref,
        (r) => r.invalidate(pilgrimDashboardStateProvider),
      ),
    );

    final dashboard =
        await ref.read(pilgrimDashboardServiceProvider).loadDashboard(pilgrimId);
    await ref.read(pilgrimDashboardServiceProvider).syncPending(pilgrimId);
    return dashboard;
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> toggleRitual(String ritualKey, bool completed) async {
    final pilgrimId = ref.read(pilgrimUserIdProvider);
    if (pilgrimId == null) {
      return;
    }

    final previous = state.value;
    if (previous != null) {
      state = AsyncData(_withRitualUpdated(previous, ritualKey, completed));
    }

    state = await AsyncValue.guard(() async {
      return ref.read(pilgrimDashboardServiceProvider).toggleRitual(
            pilgrimId: pilgrimId,
            ritualKey: ritualKey,
            completed: completed,
          );
    });
    if (state.hasError && previous != null) {
      state = AsyncData(previous);
    }
  }
}

PilgrimDashboard _withRitualUpdated(
  PilgrimDashboard dashboard,
  String ritualKey,
  bool completed,
) {
  return dashboard.copyWith(
    hasPendingSync: true,
    rituals: dashboard.rituals
        .map(
          (ritual) => ritual.definition.key != ritualKey
              ? ritual
              : ritual.copyWith(
                  isCompleted: completed,
                  completedAt: completed ? DateTime.now() : null,
                  pendingSync: true,
                ),
        )
        .toList(),
  );
}

class PilgrimAccessDeniedException implements Exception {
  const PilgrimAccessDeniedException();
}

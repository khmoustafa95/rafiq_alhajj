import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/auth_session_state.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/pilgrim/application/services/pilgrim_dashboard_service.dart';
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
PilgrimDashboardService pilgrimDashboardService(Ref ref) {
  return PilgrimDashboardService(ref.watch(pilgrimRemoteRepositoryProvider));
}

@riverpod
String? pilgrimUserId(Ref ref) {
  final session = ref.watch(authSessionProvider).value;
  if (session is! AuthenticatedAuthSession) {
    return null;
  }
  if (session.accessMode != AppAccessMode.pilgrim) {
    return null;
  }
  return session.profile.id;
}

@riverpod
class PilgrimDashboardState extends _$PilgrimDashboardState {
  @override
  Future<PilgrimDashboard> build() async {
    final pilgrimId = ref.watch(pilgrimUserIdProvider);
    if (pilgrimId == null) {
      throw const PilgrimAccessDeniedException();
    }

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
    state = const AsyncLoading();
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

class PilgrimAccessDeniedException implements Exception {
  const PilgrimAccessDeniedException();
}

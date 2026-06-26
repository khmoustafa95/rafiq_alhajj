import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_attach.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_providers.dart';
import 'package:rafiq_alhajj/features/operator_intake/application/services/operator_registry_service.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/repositories/operator_registry_repository.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_record.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_update.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_credentials.dart';
import 'package:rafiq_alhajj/features/trips/presentation/providers/trips_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'operator_registry_providers.g.dart';

@Riverpod(keepAlive: true)
OperatorRegistryRepository operatorRegistryRepository(Ref ref) {
  return OperatorRegistryRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
OperatorRegistryService operatorRegistryService(Ref ref) {
  return OperatorRegistryService(ref.watch(operatorRegistryRepositoryProvider));
}

@Riverpod(keepAlive: true)
Future<List<PilgrimGroupOption>> pilgrimGroupFilterOptions(Ref ref) async {
  return ref.read(operatorRegistryServiceProvider).listGroupOptions();
}

@riverpod
Future<PaginatedResult<OperatorPilgrimSummary>> operatorPilgrimRegistryPage(
  Ref ref,
  StaffTableQuery query,
) async {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.pilgrimRegistry,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncPilgrimRegistryProvider),
    handlerId: 'operator_pilgrim_list',
    onInvalidate: (ref) {
      ref.invalidate(operatorPilgrimRegistryPageProvider);
      ref.invalidate(pilgrimGroupFilterOptionsProvider);
    },
  );

  final tripId = await ref.watch(activeTripProvider.future);
  return ref.read(operatorRegistryServiceProvider).listPage(query, tripId: tripId);
}

@riverpod
class OperatorPilgrimDetail extends _$OperatorPilgrimDetail {
  @override
  Future<OperatorPilgrimRecord?> build(String pilgrimId) async {
    attachRealtimeSync(
      ref,
      syncKey: RealtimeSyncKeys.pilgrimRegistry,
      ensureSyncActive: (ref) => ref.watch(realtimeSyncPilgrimRegistryProvider),
      handlerId: 'operator_pilgrim_detail',
      onInvalidate: (ref) => ref.invalidate(operatorPilgrimDetailProvider),
    );

    final tripId = await ref.watch(activeTripProvider.future);
    return ref
        .read(operatorRegistryServiceProvider)
        .loadPilgrim(pilgrimId, tripId: tripId);
  }

  Future<bool> save({
    required OperatorPilgrimUpdate update,
    bool includeProfileFields = false,
  }) async {
    try {
      final tripId = await ref.read(activeTripProvider.future);
      final enrollmentId = state.value?.enrollmentId;
      await ref.read(operatorRegistryServiceProvider).savePilgrim(
            pilgrimId: pilgrimId,
            update: update,
            includeProfileFields: includeProfileFields,
            tripId: tripId,
            enrollmentId: enrollmentId,
          );
      ref.invalidateSelf();
      ref.invalidate(operatorPilgrimRegistryPageProvider);
      await future;
      return true;
    } on OperatorRegistryException {
      return false;
    }
  }
}

@riverpod
class PilgrimPasswordReset extends _$PilgrimPasswordReset {
  @override
  FutureOr<void> build() {}

  /// Resets the pilgrim's login password and returns the new credentials, or
  /// null on failure.
  Future<PilgrimCredentials?> reset(String profileId) async {
    state = const AsyncLoading();
    PilgrimCredentials? credentials;
    state = await AsyncValue.guard(() async {
      credentials = await ref
          .read(operatorRegistryServiceProvider)
          .resetPilgrimPassword(profileId);
    });
    return state.hasError ? null : credentials;
  }
}

@riverpod
class PilgrimBulkEdit extends _$PilgrimBulkEdit {
  @override
  FutureOr<void> build() {}

  /// Applies [person]/[enrollment] field maps to all [pilgrimIds] at once.
  Future<bool> apply({
    required List<String> pilgrimIds,
    required Map<String, dynamic> person,
    required Map<String, dynamic> enrollment,
    required bool notify,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final tripId = await ref.read(activeTripProvider.future);
      await ref.read(operatorRegistryServiceProvider).bulkUpdateEnrollments(
            pilgrimIds: pilgrimIds,
            person: person,
            enrollment: enrollment,
            tripId: tripId,
            notify: notify,
          );
      ref.invalidate(operatorPilgrimRegistryPageProvider);
    });
    return !state.hasError;
  }
}

@riverpod
class PilgrimBulkAssignGroup extends _$PilgrimBulkAssignGroup {
  @override
  FutureOr<void> build() {}

  Future<bool> assign({
    required List<String> pilgrimIds,
    required String? groupId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final tripId = await ref.read(activeTripProvider.future);
      await ref.read(operatorRegistryServiceProvider).bulkAssignGroup(
            pilgrimIds: pilgrimIds,
            groupId: groupId,
            tripId: tripId,
          );
      ref.invalidate(operatorPilgrimRegistryPageProvider);
    });
    return !state.hasError;
  }
}

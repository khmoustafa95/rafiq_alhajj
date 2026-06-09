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

  return ref.read(operatorRegistryServiceProvider).listPage(query);
}

@riverpod
class OperatorPilgrimDetail extends _$OperatorPilgrimDetail {
  @override
  Future<OperatorPilgrimRecord?> build(String profileId) {
    attachRealtimeSync(
      ref,
      syncKey: RealtimeSyncKeys.pilgrimRegistry,
      ensureSyncActive: (ref) => ref.watch(realtimeSyncPilgrimRegistryProvider),
      handlerId: 'operator_pilgrim_detail',
      onInvalidate: (ref) => ref.invalidate(operatorPilgrimDetailProvider),
    );

    return ref.read(operatorRegistryServiceProvider).loadPilgrim(profileId);
  }

  Future<bool> save({
    required OperatorPilgrimUpdate update,
    bool includeProfileFields = false,
  }) async {
    try {
      await ref.read(operatorRegistryServiceProvider).savePilgrim(
            profileId: profileId,
            update: update,
            includeProfileFields: includeProfileFields,
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
class PilgrimBulkAssignGroup extends _$PilgrimBulkAssignGroup {
  @override
  FutureOr<void> build() {}

  Future<bool> assign({
    required List<String> profileIds,
    required String? groupId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(operatorRegistryServiceProvider).bulkAssignGroup(
            profileIds: profileIds,
            groupId: groupId,
          );
      ref.invalidate(operatorPilgrimRegistryPageProvider);
    });
    return !state.hasError;
  }
}

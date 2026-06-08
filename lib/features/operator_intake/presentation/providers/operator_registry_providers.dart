import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_refresh.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_tables.dart';
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

@riverpod
Future<List<PilgrimGroupOption>> pilgrimGroupFilterOptions(Ref ref) async {
  return ref.read(operatorRegistryServiceProvider).listGroupOptions();
}

@riverpod
Future<PaginatedResult<OperatorPilgrimSummary>> operatorPilgrimRegistryPage(
  Ref ref,
  StaffTableQuery query,
) async {
  final result = await ref.read(operatorRegistryServiceProvider).listPage(query);

  watchSupabaseTables(
    ref,
    client: AppConfig.hasSupabase ? Supabase.instance.client : null,
    tables: RealtimeTables.pilgrimRegistry,
  );

  return result;
}

@riverpod
class OperatorPilgrimDetail extends _$OperatorPilgrimDetail {
  @override
  Future<OperatorPilgrimRecord?> build(String profileId) {
    watchSupabaseTable(
      ref,
      client: AppConfig.hasSupabase ? Supabase.instance.client : null,
      table: 'pilgrim_details',
      eqColumn: 'profile_id',
      eqValue: profileId,
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

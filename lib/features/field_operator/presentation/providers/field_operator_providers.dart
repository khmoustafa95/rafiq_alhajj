import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_refresh.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_tables.dart';
import 'package:rafiq_alhajj/features/field_operator/application/services/field_operator_service.dart';
import 'package:rafiq_alhajj/features/field_operator/data/repositories/field_operator_repository.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_operator_stats.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/pilgrim_search_item.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim.dart';
import 'package:rafiq_alhajj/features/pilgrim/presentation/providers/pilgrim_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'field_operator_providers.g.dart';

SupabaseClient? _realtimeClient() =>
    AppConfig.hasSupabase ? Supabase.instance.client : null;

@Riverpod(keepAlive: true)
FieldOperatorRepository fieldOperatorRepository(Ref ref) {
  return FieldOperatorRepository(ref.watch(pilgrimRegistryRepositoryProvider));
}

@Riverpod(keepAlive: true)
FieldOperatorService fieldOperatorService(Ref ref) {
  return FieldOperatorService(ref.watch(fieldOperatorRepositoryProvider));
}

@riverpod
Future<FieldOperatorStats> fieldOperatorStats(Ref ref) {
  watchSupabaseTables(
    ref,
    client: _realtimeClient(),
    tables: RealtimeTables.pilgrimRegistry,
  );

  return ref.read(fieldOperatorServiceProvider).loadStats();
}

@riverpod
class FieldOperatorSearch extends _$FieldOperatorSearch {
  String _query = '';
  String? _statusFilter;

  @override
  Future<List<PilgrimSearchItem>> build() {
    watchSupabaseTables(
      ref,
      client: _realtimeClient(),
      tables: RealtimeTables.pilgrimRegistry,
    );

    return ref.read(fieldOperatorServiceProvider).searchPilgrims(
          query: _query,
          fieldStatusFilter: _statusFilter,
        );
  }

  Future<void> search(String query) async {
    _query = query;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(fieldOperatorServiceProvider).searchPilgrims(
            query: _query,
            fieldStatusFilter: _statusFilter,
          ),
    );
  }

  Future<void> filterByStatus(String? status) async {
    _statusFilter = status;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(fieldOperatorServiceProvider).searchPilgrims(
            query: _query,
            fieldStatusFilter: _statusFilter,
          ),
    );
  }

  String? get statusFilter => _statusFilter;

  Future<void> refresh() async {
    ref.invalidate(fieldOperatorStatsProvider);
    ref.invalidateSelf();
  }
}

@riverpod
class FieldOperatorPilgrimDetail extends _$FieldOperatorPilgrimDetail {
  @override
  Future<Pilgrim?> build(String profileId) {
    watchSupabaseTable(
      ref,
      client: _realtimeClient(),
      table: 'pilgrim_details',
      eqColumn: 'profile_id',
      eqValue: profileId,
    );

    return ref.read(fieldOperatorServiceProvider).loadPilgrim(profileId);
  }

  Future<bool> save({
    required String? fieldStatus,
    required String? medicalTestStatus,
  }) async {
    state = const AsyncLoading();
    var saved = false;

    state = await AsyncValue.guard(() async {
      await ref.read(fieldOperatorServiceProvider).savePilgrimUpdates(
            profileId: profileId,
            fieldStatus: fieldStatus,
            medicalTestStatus: medicalTestStatus,
          );
      saved = true;
      return ref.read(fieldOperatorServiceProvider).loadPilgrim(profileId);
    });

    if (saved) {
      ref.invalidate(fieldOperatorSearchProvider);
      ref.invalidate(fieldOperatorStatsProvider);
    }

    return !state.hasError;
  }
}

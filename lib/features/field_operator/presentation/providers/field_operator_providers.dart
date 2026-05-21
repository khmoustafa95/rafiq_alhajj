import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/field_operator/application/services/field_operator_service.dart';
import 'package:rafiq_alhajj/features/field_operator/data/repositories/field_operator_repository.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/pilgrim_field_record.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/pilgrim_search_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'field_operator_providers.g.dart';

@Riverpod(keepAlive: true)
FieldOperatorRepository fieldOperatorRepository(Ref ref) {
  return FieldOperatorRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
FieldOperatorService fieldOperatorService(Ref ref) {
  return FieldOperatorService(ref.watch(fieldOperatorRepositoryProvider));
}

@riverpod
class FieldOperatorSearch extends _$FieldOperatorSearch {
  @override
  Future<List<PilgrimSearchItem>> build() {
    return ref.read(fieldOperatorServiceProvider).searchPilgrims('');
  }

  Future<void> search(String query) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(fieldOperatorServiceProvider).searchPilgrims(query),
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

@riverpod
class FieldOperatorPilgrimDetail extends _$FieldOperatorPilgrimDetail {
  @override
  Future<PilgrimFieldRecord?> build(String profileId) {
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
    }

    return !state.hasError;
  }
}

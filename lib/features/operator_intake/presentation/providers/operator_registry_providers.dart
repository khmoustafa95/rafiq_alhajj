import 'package:rafiq_alhajj/core/config/app_config.dart';
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
class OperatorPilgrimRegistry extends _$OperatorPilgrimRegistry {
  List<OperatorPilgrimSummary> _all = const [];

  @override
  Future<List<OperatorPilgrimSummary>> build() async {
    _all = await ref.read(operatorRegistryServiceProvider).listPilgrims();
    return _all;
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> search(String query) async {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      state = AsyncData(_all);
      return;
    }

    state = AsyncData(
      _all.where((item) {
        return item.fullName.toLowerCase().contains(normalized) ||
            (item.passportNumber?.toLowerCase().contains(normalized) ?? false) ||
            (item.travelPermitNumber?.toLowerCase().contains(normalized) ??
                false);
      }).toList(),
    );
  }
}

@riverpod
class OperatorPilgrimDetail extends _$OperatorPilgrimDetail {
  @override
  Future<OperatorPilgrimRecord?> build(String profileId) {
    return ref.read(operatorRegistryServiceProvider).loadPilgrim(profileId);
  }

  Future<bool> save({
    required OperatorPilgrimUpdate update,
  }) async {
    try {
      await ref
          .read(operatorRegistryServiceProvider)
          .saveLogistics(profileId: profileId, update: update);
      ref.invalidateSelf();
      ref.invalidate(operatorPilgrimRegistryProvider);
      await future;
      return true;
    } on OperatorRegistryException {
      return false;
    }
  }
}

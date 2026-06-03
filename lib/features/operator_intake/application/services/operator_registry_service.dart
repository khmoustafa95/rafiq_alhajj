import 'package:rafiq_alhajj/features/operator_intake/data/repositories/operator_registry_repository.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_record.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_update.dart';

class OperatorRegistryService {
  const OperatorRegistryService(this._repository);

  final OperatorRegistryRepository _repository;

  Future<List<OperatorPilgrimSummary>> listPilgrims() =>
      _repository.fetchAll();

  Future<OperatorPilgrimRecord?> loadPilgrim(String profileId) =>
      _repository.fetchById(profileId);

  Future<void> saveLogistics({
    required String profileId,
    required OperatorPilgrimUpdate update,
  }) =>
      _repository.updateLogistics(profileId: profileId, update: update);
}

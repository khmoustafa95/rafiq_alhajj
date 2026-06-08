import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/repositories/operator_registry_repository.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_record.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_update.dart';

class OperatorRegistryService {
  const OperatorRegistryService(this._repository);

  final OperatorRegistryRepository _repository;

  Future<List<OperatorPilgrimSummary>> listPilgrims() =>
      _repository.fetchAll();

  Future<PaginatedResult<OperatorPilgrimSummary>> listPage(
    StaffTableQuery query,
  ) =>
      _repository.fetchPage(query);

  Future<OperatorPilgrimRecord?> loadPilgrim(String profileId) =>
      _repository.fetchById(profileId);

  Future<void> saveLogistics({
    required String profileId,
    required OperatorPilgrimUpdate update,
  }) =>
      _repository.updateLogistics(profileId: profileId, update: update);
}

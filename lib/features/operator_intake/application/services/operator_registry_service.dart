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

  Future<List<PilgrimGroupOption>> listGroupOptions() =>
      _repository.fetchGroupOptions();

  Future<OperatorPilgrimRecord?> loadPilgrim(String profileId) =>
      _repository.fetchById(profileId);

  Future<void> savePilgrim({
    required String profileId,
    required OperatorPilgrimUpdate update,
    bool includeProfileFields = false,
  }) =>
      _repository.savePilgrim(
        profileId: profileId,
        update: update,
        includeProfileFields: includeProfileFields,
      );

  Future<void> bulkAssignGroup({
    required List<String> profileIds,
    required String? groupId,
  }) =>
      _repository.bulkAssignGroup(profileIds: profileIds, groupId: groupId);
}

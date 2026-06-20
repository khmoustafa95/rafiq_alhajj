import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/repositories/operator_registry_repository.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_record.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_update.dart';

class OperatorRegistryService {
  const OperatorRegistryService(this._repository);

  final OperatorRegistryRepository _repository;

  Future<List<OperatorPilgrimSummary>> listPilgrims({String? tripId}) =>
      _repository.fetchAll(tripId: tripId);

  Future<PaginatedResult<OperatorPilgrimSummary>> listPage(
    StaffTableQuery query, {
    String? tripId,
  }) =>
      _repository.fetchPage(query, tripId: tripId);

  Future<List<PilgrimGroupOption>> listGroupOptions() =>
      _repository.fetchGroupOptions();

  Future<OperatorPilgrimRecord?> loadPilgrim(
    String pilgrimId, {
    String? tripId,
  }) =>
      _repository.fetchById(pilgrimId, tripId: tripId);

  Future<void> savePilgrim({
    required String pilgrimId,
    required OperatorPilgrimUpdate update,
    bool includeProfileFields = false,
    String? tripId,
    String? enrollmentId,
  }) =>
      _repository.savePilgrim(
        pilgrimId: pilgrimId,
        update: update,
        includeProfileFields: includeProfileFields,
        tripId: tripId,
        enrollmentId: enrollmentId,
      );

  Future<void> bulkAssignGroup({
    required List<String> pilgrimIds,
    required String? groupId,
    String? tripId,
  }) =>
      _repository.bulkAssignGroup(
        pilgrimIds: pilgrimIds,
        groupId: groupId,
        tripId: tripId,
      );
}

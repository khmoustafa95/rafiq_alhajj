import 'package:rafiq_alhajj/features/field_operator/data/repositories/field_operator_repository.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/pilgrim_field_record.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/pilgrim_search_item.dart';

class FieldOperatorService {
  const FieldOperatorService(this._repository);

  final FieldOperatorRepository _repository;

  Future<List<PilgrimSearchItem>> searchPilgrims(String query) async {
    final all = await _repository.fetchPilgrims();
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) {
      return all;
    }

    return all.where((item) {
      return item.fullName.toLowerCase().contains(trimmed) ||
          (item.passportNumber?.toLowerCase().contains(trimmed) ?? false) ||
          (item.travelPermitNumber?.toLowerCase().contains(trimmed) ?? false);
    }).toList(growable: false);
  }

  Future<PilgrimFieldRecord?> loadPilgrim(String profileId) {
    return _repository.fetchPilgrim(profileId);
  }

  Future<void> savePilgrimUpdates({
    required String profileId,
    required String? fieldStatus,
    required String? medicalTestStatus,
  }) {
    return _repository.updatePilgrimLogistics(
      profileId: profileId,
      fieldStatus: fieldStatus,
      medicalTestStatus: medicalTestStatus,
    );
  }
}

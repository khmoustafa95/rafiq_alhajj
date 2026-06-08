import 'package:rafiq_alhajj/features/field_operator/data/repositories/field_operator_repository.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_operator_stats.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/pilgrim_search_item.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim.dart';

class FieldOperatorService {
  const FieldOperatorService(this._repository);

  final FieldOperatorRepository _repository;

  Future<List<Pilgrim>> loadAllPilgrims() => _repository.fetchPilgrims();

  Future<FieldOperatorStats> loadStats() async {
    final pilgrims = await _repository.fetchPilgrims();
    return FieldOperatorStats.fromPilgrims(pilgrims);
  }

  Future<List<PilgrimSearchItem>> searchPilgrims({
    required String query,
    String? fieldStatusFilter,
  }) async {
    final all = await _repository.fetchPilgrims();
    final trimmed = query.trim().toLowerCase();

    final filtered = all.where((pilgrim) {
      if (fieldStatusFilter != null &&
          fieldStatusFilter.isNotEmpty &&
          pilgrim.fieldStatus != fieldStatusFilter) {
        return false;
      }

      if (trimmed.isEmpty) {
        return true;
      }

      final haystack = [
        pilgrim.displayName,
        pilgrim.fullNameAr,
        pilgrim.passportNumber,
        pilgrim.travelPermitNumber,
        pilgrim.stickerNumber,
        pilgrim.visaNumber,
        pilgrim.barcodeNumber,
        pilgrim.phoneNumber,
        pilgrim.whatsappNumber,
        pilgrim.groupName,
        pilgrim.cluster,
      ];

      return haystack.any(
        (value) => value != null && value.toLowerCase().contains(trimmed),
      );
    });

    return filtered
        .map(PilgrimSearchItem.fromPilgrim)
        .toList(growable: false);
  }

  Future<Pilgrim?> loadPilgrim(String profileId) {
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

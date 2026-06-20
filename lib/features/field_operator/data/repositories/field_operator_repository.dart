import 'package:rafiq_alhajj/features/pilgrim/data/repositories/pilgrim_registry_repository.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim.dart';

typedef FieldOperatorException = PilgrimRegistryException;

class FieldOperatorRepository {
  FieldOperatorRepository(this._registry);

  final PilgrimRegistryRepository _registry;

  bool get isAvailable => _registry.isAvailable;

  Future<List<Pilgrim>> fetchPilgrims({String? tripId}) =>
      _registry.fetchAllPilgrims(tripId: tripId);

  Future<Pilgrim?> fetchPilgrim(String profileId, {String? tripId}) =>
      _registry.fetchByProfileId(profileId, tripId: tripId);

  Future<void> updatePilgrimLogistics({
    required String profileId,
    required String? fieldStatus,
    required String? medicalTestStatus,
    String? tripId,
  }) {
    return _registry.updateFieldStatus(
      profileId: profileId,
      fieldStatus: fieldStatus,
      medicalTestStatus: medicalTestStatus,
      tripId: tripId,
    );
  }
}

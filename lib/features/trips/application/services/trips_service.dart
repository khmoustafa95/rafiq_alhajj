import 'package:rafiq_alhajj/features/trips/data/repositories/trips_repository.dart';
import 'package:rafiq_alhajj/features/trips/domain/models/trip.dart';
import 'package:rafiq_alhajj/features/trips/domain/models/trip_editor_input.dart';
import 'package:rafiq_alhajj/features/trips/domain/models/trip_office.dart';

class TripsService {
  const TripsService(this._repository);

  final TripsRepository _repository;

  Future<List<Trip>> fetchTrips() => _repository.fetchTrips();

  Future<Trip> fetchById(String id) => _repository.fetchById(id);

  Future<List<TripOffice>> fetchOffices(String tripId) =>
      _repository.fetchOffices(tripId);

  Future<List<TripGroupOption>> fetchAvailableGroups(String tripId) =>
      _repository.fetchAvailableGroups(tripId);

  Future<void> save(TripEditorInput input) => _repository.save(input);

  Future<void> delete(String id) => _repository.delete(id);

  Future<void> addOffice({required String tripId, required String groupId}) =>
      _repository.addOffice(tripId: tripId, groupId: groupId);

  Future<void> setOfficeStatus({
    required String tripGroupId,
    required String status,
  }) =>
      _repository.setOfficeStatus(tripGroupId: tripGroupId, status: status);

  Future<void> removeOffice(String tripGroupId) =>
      _repository.removeOffice(tripGroupId);

  /// Picks the stored active trip, else the first `active` trip, else the first
  /// trip in the list.
  Future<String?> resolveDefaultActiveTripId({
    required String? storedTripId,
  }) async {
    if (storedTripId != null && storedTripId.isNotEmpty) {
      return storedTripId;
    }

    final trips = await fetchTrips();
    if (trips.isEmpty) {
      return null;
    }
    final active = trips.where((trip) => trip.status == 'active');
    return active.isNotEmpty ? active.first.id : trips.first.id;
  }
}

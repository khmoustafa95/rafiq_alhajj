import 'package:rafiq_alhajj/features/sos/data/repositories/sos_repository.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_alert.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_ping.dart';

class SosService {
  SosService(this._repository);

  final SosRepository _repository;

  Future<String> raiseAlert({
    double? latitude,
    double? longitude,
    double? accuracy,
  }) =>
      _repository.raiseAlert(
        latitude: latitude,
        longitude: longitude,
        accuracy: accuracy,
      );

  Future<void> pushLocation({
    required String alertId,
    required double latitude,
    required double longitude,
    double? accuracy,
  }) =>
      _repository.pushLocation(
        alertId: alertId,
        latitude: latitude,
        longitude: longitude,
        accuracy: accuracy,
      );

  Future<void> cancelByPilgrim(String alertId) =>
      _repository.cancelByPilgrim(alertId);

  Future<void> resolveByStaff(String alertId) =>
      _repository.resolveByStaff(alertId);

  Future<SosAlert?> loadMyActiveAlert(String profileId) =>
      _repository.fetchMyActiveAlert(profileId);

  Future<List<SosAlert>> loadActiveAlerts() => _repository.fetchActiveAlerts();

  Future<List<SosPing>> loadPings(String alertId) =>
      _repository.fetchPings(alertId);
}

import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/pilgrim/data/data_sources/pilgrim_registry_remote_data_source.dart';
import 'package:rafiq_alhajj/features/pilgrim/data/dtos/pilgrim_dto.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PilgrimRegistryException implements Exception {
  const PilgrimRegistryException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Pilgrim registry request failed';
}

class PilgrimRegistryRepository {
  PilgrimRegistryRepository([SupabaseClient? client])
      : _remote =
            client == null ? null : PilgrimRegistryRemoteDataSource(client);

  final PilgrimRegistryRemoteDataSource? _remote;

  bool get isAvailable => AppConfig.hasSupabase && _remote != null;

  /// Reads pilgrims through the flat [pilgrim_enrollment_view] (person + trip
  /// enrollment joined). Optionally scoped to a single [tripId].
  Future<List<Pilgrim>> fetchAllPilgrims({String? tripId}) async {
    if (!isAvailable) {
      return [];
    }
    final remote = _remote!;
    try {
      final rows = await remote.fetchEnrollments(tripId: tripId);
      return rows.map(_rowToPilgrim).toList(growable: false);
    } on PostgrestException catch (e) {
      throw PilgrimRegistryException(e.message);
    }
  }

  Future<Pilgrim?> fetchByProfileId(String profileId, {String? tripId}) async {
    if (!isAvailable) {
      return null;
    }
    final remote = _remote!;
    try {
      final rows =
          await remote.fetchEnrollmentByProfile(profileId, tripId: tripId);
      if (rows.isEmpty) {
        return null;
      }

      return _rowToPilgrim(rows.first);
    } on PostgrestException catch (e) {
      throw PilgrimRegistryException(e.message);
    }
  }

  Future<Pilgrim?> fetchDetailsOnly(String profileId, {String? tripId}) async {
    return fetchByProfileId(profileId, tripId: tripId);
  }

  /// Updates the field status on the pilgrim's trip enrollment(s). When
  /// [tripId] is provided only that enrollment is updated.
  Future<void> updateFieldStatus({
    required String profileId,
    required String? fieldStatus,
    required String? medicalTestStatus,
    String? tripId,
  }) async {
    if (!isAvailable) {
      throw const PilgrimRegistryException('Supabase is not configured');
    }
    final remote = _remote!;
    try {
      final pilgrim = await remote.findPilgrimByProfile(profileId);
      if (pilgrim == null) {
        return;
      }

      await remote.updateEnrollmentFieldStatus(
        pilgrimId: pilgrim['id'] as String,
        payload: {
          'field_status': fieldStatus,
          'medical_test_status': medicalTestStatus,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        },
        tripId: tripId,
      );
    } on PostgrestException catch (e) {
      throw PilgrimRegistryException(e.message);
    }
  }

  Pilgrim _rowToPilgrim(Map<String, dynamic> row) {
    final dto = PilgrimDto.fromJson(row);
    return dto.toDomain(displayName: row['full_name'] as String?);
  }
}

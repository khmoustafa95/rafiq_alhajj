import 'package:rafiq_alhajj/features/pilgrim/data/pilgrim_registry_columns.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for the pilgrim registry (`pilgrim_enrollment_view`,
/// `pilgrims`, `trip_enrollments`).
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Mapping to
/// domain models is the repository's responsibility (see
/// `PilgrimRegistryRepository`).
class PilgrimRegistryRemoteDataSource {
  const PilgrimRegistryRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<List<Map<String, dynamic>>> fetchEnrollments({String? tripId}) async {
    var request = _client
        .from('pilgrim_enrollment_view')
        .select(PilgrimRegistryColumns.viewSelect);
    if (tripId != null && tripId.isNotEmpty) {
      request = request.eq('trip_id', tripId);
    }

    final rows = await request.order('full_name');
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchEnrollmentByProfile(
    String profileId, {
    String? tripId,
  }) async {
    var request = _client
        .from('pilgrim_enrollment_view')
        .select(PilgrimRegistryColumns.viewSelect)
        .eq('profile_id', profileId);
    if (tripId != null && tripId.isNotEmpty) {
      request = request.eq('trip_id', tripId);
    }

    final rows = await request.limit(1);
    return _asMaps(rows);
  }

  Future<Map<String, dynamic>?> findPilgrimByProfile(String profileId) async {
    final row = await _client
        .from('pilgrims')
        .select('id')
        .eq('profile_id', profileId)
        .maybeSingle();
    return row == null ? null : Map<String, dynamic>.from(row);
  }

  Future<void> updateEnrollmentFieldStatus({
    required String pilgrimId,
    required Map<String, dynamic> payload,
    String? tripId,
  }) async {
    var update = _client
        .from('trip_enrollments')
        .update(payload)
        .eq('pilgrim_id', pilgrimId);
    if (tripId != null && tripId.isNotEmpty) {
      update = update.eq('trip_id', tripId);
    }
    await update;
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

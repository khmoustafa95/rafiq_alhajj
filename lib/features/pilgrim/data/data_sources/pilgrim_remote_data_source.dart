import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for the pilgrim self-service experience
/// (`pilgrim_enrollment_view` + `ritual_logs`).
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Mapping to
/// domain models is the repository's responsibility (see
/// `PilgrimRemoteRepository`).
class PilgrimRemoteDataSource {
  const PilgrimRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const enrollmentColumns =
      'enrollment_id, trip_status, passport_number, travel_permit_number, '
      'medical_test_status, travel_date, hotel_name, hotel_location_url, '
      'transportation_details';

  Future<List<Map<String, dynamic>>> fetchEnrollmentRows(
    String profileId,
  ) async {
    final rows = await _client
        .from('pilgrim_enrollment_view')
        .select(enrollmentColumns)
        .eq('profile_id', profileId);
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchRitualLogs(
    String enrollmentId,
  ) async {
    final rows = await _client
        .from('ritual_logs')
        .select('ritual_key, is_completed, completed_at')
        .eq('enrollment_id', enrollmentId);
    return _asMaps(rows);
  }

  Future<void> upsertRitualLog(Map<String, dynamic> payload) async {
    await _client.from('ritual_logs').upsert(
          payload,
          onConflict: 'enrollment_id,ritual_key',
        );
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

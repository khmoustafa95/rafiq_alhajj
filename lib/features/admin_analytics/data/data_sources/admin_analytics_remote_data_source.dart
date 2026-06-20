import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for the admin analytics dashboard. Reads counts and
/// breakdowns from `pilgrims`, `profiles`, `groups`, `trip_enrollments`,
/// `ritual_logs`, and `pilgrim_documents`.
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Aggregation
/// and mapping is the repository's responsibility (see
/// `AdminAnalyticsRepository`).
class AdminAnalyticsRemoteDataSource {
  const AdminAnalyticsRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<List<Map<String, dynamic>>> fetchPilgrims() async {
    final rows = await _client.from('pilgrims').select('id');
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchOperators() async {
    final rows =
        await _client.from('profiles').select('id').eq('role', 'operator');
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchGroups() async {
    final rows = await _client.from('groups').select('id, name');
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchEnrollments() async {
    final rows =
        await _client.from('trip_enrollments').select('group_id, field_status');
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchCompletedRitualLogs() async {
    final rows = await _client
        .from('ritual_logs')
        .select('enrollment_id, ritual_key, is_completed')
        .eq('is_completed', true);
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchDocumentUploaders() async {
    final rows = await _client
        .from('pilgrim_documents')
        .select('uploaded_by, profiles:uploaded_by(full_name)');
    return _asMaps(rows);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

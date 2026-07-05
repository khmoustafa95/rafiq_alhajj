import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for the admin analytics dashboard.
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Aggregation
/// and mapping is the repository's responsibility (see [AdminAnalyticsRepository]).
class AdminAnalyticsRemoteDataSource {
  const AdminAnalyticsRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<List<Map<String, dynamic>>> fetchOperators() async {
    final rows =
        await _client.from('profiles').select('id').eq('role', 'operator');
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchGroups() async {
    final rows = await _client.from('groups').select('id, name');
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchEnrollments({String? tripId}) async {
    var query = _client.from('trip_enrollments').select(
          'group_id, field_status, travel_permit_number, medical_test_status, '
          'needs_wheelchair, trip_id, pilgrim_id, pilgrims(profile_id)',
        );
    if (tripId != null) {
      query = query.eq('trip_id', tripId);
    }
    final rows = await query;
    return _asMaps(rows);
  }

  Future<Map<String, dynamic>?> fetchTripById(String tripId) async {
    final row = await _client
        .from('trips')
        .select('id, name, type, season_year')
        .eq('id', tripId)
        .maybeSingle();
    if (row == null) {
      return null;
    }
    return Map<String, dynamic>.from(row as Map);
  }

  Future<List<Map<String, dynamic>>> fetchDocumentUploaders() async {
    final rows = await _client
        .from('pilgrim_documents')
        .select('uploaded_by, profiles:uploaded_by(full_name)');
    return _asMaps(rows);
  }

  Future<int> fetchActiveSosCount() async {
    final rows =
        await _client.from('sos_alerts').select('id').eq('status', 'active');
    return (rows as List<dynamic>).length;
  }

  Future<int> fetchPushFailureCount() async {
    final rows = await _client.from('push_dispatch_failures').select('id');
    return (rows as List<dynamic>).length;
  }

  Future<int> fetchActiveCompetitionCount() async {
    final rows =
        await _client.from('competitions').select('id').eq('is_active', true);
    return (rows as List<dynamic>).length;
  }

  Future<int> fetchCompetitionEntryCount() async {
    final rows = await _client.from('competition_entries').select('id');
    return (rows as List<dynamic>).length;
  }

  Future<int> fetchPublishedContentCount() async {
    final libraryRows = await _client.from('content_library').select('id');
    final topicRows = await _client.from('content_topics').select('id');
    return (libraryRows as List<dynamic>).length +
        (topicRows as List<dynamic>).length;
  }

  Future<List<Map<String, dynamic>>> fetchPilgrimDeviceTokens() async {
    final rows = await _client
        .from('device_tokens')
        .select('profile_id, profiles(role)');
    return _asMaps(rows);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

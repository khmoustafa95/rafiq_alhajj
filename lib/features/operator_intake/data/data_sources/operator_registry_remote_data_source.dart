import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/utils/postgrest_search_sanitize.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for the operator intake registry
/// (`pilgrim_enrollment_view`, `pilgrims`, `trip_enrollments`, `profiles`,
/// `groups`).
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Mapping to
/// domain models is the repository's responsibility (see
/// `OperatorRegistryRepository`).
class OperatorRegistryRemoteDataSource {
  const OperatorRegistryRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const viewSelect =
      'pilgrim_id, profile_id, enrollment_id, full_name, passport_number, '
      'travel_permit_number, medical_test_status, travel_date, hotel_name, '
      'hotel_location_url, transportation_details, gender, group_id, '
      'group_name, trip_id, trip_type';

  Future<List<Map<String, dynamic>>> fetchGroupOptions() async {
    final rows = await _client.from('groups').select('id, name').order('name');
    return _asMaps(rows);
  }

  Future<({List<Map<String, dynamic>> rows, int count})> fetchPage(
    StaffTableQuery query, {
    String? tripId,
  }) async {
    var request = _client.from('pilgrim_enrollment_view').select(viewSelect);

    if (tripId != null && tripId.isNotEmpty) {
      request = request.eq('trip_id', tripId);
    }

    final search = query.search.trim();
    if (search.isNotEmpty) {
      final term = sanitizePostgrestSearchTerm(search);
      request = request.or(
        'full_name.ilike.%$term%,passport_number.ilike.%$term%,'
        'travel_permit_number.ilike.%$term%',
      );
    }

    final gender = query.filters['gender'];
    if (gender != null && gender.isNotEmpty) {
      request = request.eq('gender', gender);
    }

    final groupId = query.filters['group_id'];
    if (groupId != null && groupId.isNotEmpty) {
      request = request.eq('group_id', groupId);
    }

    final response = await request
        .order(_sortColumn(query), ascending: query.sortAscending)
        .range(query.from, query.to)
        .count(CountOption.exact);

    return (rows: _asMaps(response.data), count: response.count);
  }

  Future<List<Map<String, dynamic>>> fetchById(
    String pilgrimId, {
    String? tripId,
  }) async {
    var request = _client
        .from('pilgrim_enrollment_view')
        .select(viewSelect)
        .eq('pilgrim_id', pilgrimId);
    if (tripId != null && tripId.isNotEmpty) {
      request = request.eq('trip_id', tripId);
    }

    final rows = await request.limit(1);
    return _asMaps(rows);
  }

  Future<void> updatePilgrimPerson(
    String pilgrimId,
    Map<String, dynamic> payload,
  ) async {
    await _client.from('pilgrims').update(payload).eq('id', pilgrimId);
  }

  Future<void> updateEnrollment(
    String pilgrimId,
    Map<String, dynamic> payload, {
    String? enrollmentId,
    String? tripId,
  }) async {
    var update = _client
        .from('trip_enrollments')
        .update(payload)
        .eq('pilgrim_id', pilgrimId);
    if (enrollmentId != null && enrollmentId.isNotEmpty) {
      update = update.eq('id', enrollmentId);
    } else if (tripId != null && tripId.isNotEmpty) {
      update = update.eq('trip_id', tripId);
    }
    await update;
  }

  Future<Map<String, dynamic>?> fetchPilgrimProfileId(String pilgrimId) async {
    final row = await _client
        .from('pilgrims')
        .select('profile_id')
        .eq('id', pilgrimId)
        .maybeSingle();
    return row == null ? null : Map<String, dynamic>.from(row);
  }

  Future<void> updateProfile(
    String profileId,
    Map<String, dynamic> payload,
  ) async {
    await _client.from('profiles').update(payload).eq('id', profileId);
  }

  Future<void> bulkAssignGroup({
    required List<String> pilgrimIds,
    required String? groupId,
    String? tripId,
  }) async {
    var request = _client
        .from('trip_enrollments')
        .update({'group_id': groupId}).inFilter('pilgrim_id', pilgrimIds);
    if (tripId != null && tripId.isNotEmpty) {
      request = request.eq('trip_id', tripId);
    }
    await request;
  }

  String _sortColumn(StaffTableQuery query) {
    return switch (query.sortColumnId) {
      'passport' => 'passport_number',
      'travel_date' => 'travel_date',
      'gender' => 'gender',
      'group' => 'group_name',
      'travel_permit' => 'travel_permit_number',
      'medical_test' => 'medical_test_status',
      'hotel' => 'hotel_name',
      _ => 'full_name',
    };
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

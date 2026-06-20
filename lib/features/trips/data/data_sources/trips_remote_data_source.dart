import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for `trips` and `trip_groups`.
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Mapping to
/// domain models is the repository's responsibility (see [TripsRepository]).
class TripsRemoteDataSource {
  const TripsRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const tripColumns =
      'id, type, season_year, name, status, start_date, end_date, '
      'created_at, updated_at';

  static const officeColumns =
      'id, trip_id, group_id, status, joined_at, withdrawn_at, '
      'groups(name, president_name)';

  Future<List<Map<String, dynamic>>> fetchTrips() async {
    final rows = await _client
        .from('trips')
        .select(tripColumns)
        .order('season_year', ascending: false)
        .order('created_at', ascending: false);
    return _asMaps(rows);
  }

  Future<Map<String, dynamic>> fetchById(String id) async {
    final row =
        await _client.from('trips').select(tripColumns).eq('id', id).single();
    return Map<String, dynamic>.from(row);
  }

  Future<Map<String, dynamic>> upsert(
    Map<String, dynamic> payload, {
    String? id,
  }) async {
    final row = id != null
        ? await _client
            .from('trips')
            .update(payload)
            .eq('id', id)
            .select(tripColumns)
            .single()
        : await _client
            .from('trips')
            .insert(payload)
            .select(tripColumns)
            .single();
    return Map<String, dynamic>.from(row);
  }

  Future<void> delete(String id) async {
    await _client.from('trips').delete().eq('id', id);
  }

  Future<List<Map<String, dynamic>>> fetchOffices(String tripId) async {
    final rows = await _client
        .from('trip_groups')
        .select(officeColumns)
        .eq('trip_id', tripId)
        .order('joined_at');
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchLinkedGroups(String tripId) async {
    final rows = await _client
        .from('trip_groups')
        .select('group_id')
        .eq('trip_id', tripId);
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchAllGroups() async {
    final rows = await _client.from('groups').select('id, name').order('name');
    return _asMaps(rows);
  }

  Future<void> addOffice({
    required String tripId,
    required String groupId,
  }) async {
    await _client.from('trip_groups').insert({
      'trip_id': tripId,
      'group_id': groupId,
      'status': 'active',
    });
  }

  Future<void> setOfficeStatus({
    required String tripGroupId,
    required String status,
  }) async {
    await _client.from('trip_groups').update({
      'status': status,
      'withdrawn_at': status == 'withdrawn'
          ? DateTime.now().toUtc().toIso8601String()
          : null,
    }).eq('id', tripGroupId);
  }

  Future<void> removeOffice(String tripGroupId) async {
    await _client.from('trip_groups').delete().eq('id', tripGroupId);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

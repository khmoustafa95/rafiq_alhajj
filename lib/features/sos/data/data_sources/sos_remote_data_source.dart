import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for SOS alerts + location pings.
class SosRemoteDataSource {
  const SosRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const alertColumns =
      'id, pilgrim_profile_id, group_id, status, latitude, longitude, '
      'accuracy, note, started_at, last_location_at, '
      'profiles!pilgrim_profile_id(full_name), groups(name)';

  String? get currentUserId => _client.auth.currentUser?.id;

  /// Creates (or reuses) the caller's active alert; returns its id.
  Future<String> raiseAlert({
    double? latitude,
    double? longitude,
    double? accuracy,
  }) async {
    final id = await _client.rpc<String>(
      'raise_sos_alert',
      params: {
        'p_lat': latitude,
        'p_lng': longitude,
        'p_accuracy': accuracy,
      },
    );
    return id;
  }

  Future<void> pushLocation({
    required String alertId,
    required double latitude,
    required double longitude,
    double? accuracy,
  }) async {
    await _client.from('sos_alerts').update({
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
      'last_location_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('id', alertId);

    await _client.from('sos_location_pings').insert({
      'alert_id': alertId,
      'latitude': latitude,
      'longitude': longitude,
      'accuracy': accuracy,
    });
  }

  Future<void> cancelByPilgrim(String alertId) async {
    await _client.from('sos_alerts').update({
      'status': 'cancelled',
      'resolved_at': DateTime.now().toUtc().toIso8601String(),
    }).eq('id', alertId);
  }

  Future<void> resolveByStaff(String alertId) async {
    await _client.from('sos_alerts').update({
      'status': 'resolved',
      'resolved_at': DateTime.now().toUtc().toIso8601String(),
      'resolved_by': currentUserId,
    }).eq('id', alertId);
  }

  Future<Map<String, dynamic>?> fetchMyActiveAlert(String profileId) async {
    final row = await _client
        .from('sos_alerts')
        .select(alertColumns)
        .eq('pilgrim_profile_id', profileId)
        .eq('status', 'active')
        .maybeSingle();
    return row == null ? null : Map<String, dynamic>.from(row);
  }

  Future<List<Map<String, dynamic>>> fetchActiveAlerts() async {
    final rows = await _client
        .from('sos_alerts')
        .select(alertColumns)
        .eq('status', 'active')
        .order('started_at', ascending: false);
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchPings(String alertId) async {
    final rows = await _client
        .from('sos_location_pings')
        .select('id, alert_id, latitude, longitude, accuracy, created_at')
        .eq('alert_id', alertId)
        .order('created_at');
    return _asMaps(rows);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

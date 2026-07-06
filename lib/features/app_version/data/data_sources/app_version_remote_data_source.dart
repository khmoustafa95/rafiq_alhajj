import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for [app_version_policies].
class AppVersionRemoteDataSource {
  const AppVersionRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const columns =
      'platform, min_version, latest_version, store_url, '
      'release_notes_ar, release_notes_en, updated_at';

  String? get currentUserId => _client.auth.currentUser?.id;

  Future<List<Map<String, dynamic>>> fetchAll() async {
    final rows = await _client
        .from('app_version_policies')
        .select(columns)
        .order('platform');
    return _asMaps(rows);
  }

  Future<Map<String, dynamic>?> fetchForPlatform(String platform) async {
    final row = await _client
        .from('app_version_policies')
        .select(columns)
        .eq('platform', platform)
        .maybeSingle();
    if (row == null) {
      return null;
    }
    return Map<String, dynamic>.from(row as Map);
  }

  Future<Map<String, dynamic>> upsert(Map<String, dynamic> payload) async {
    final row = await _client
        .from('app_version_policies')
        .upsert(payload)
        .select(columns)
        .single();
    return Map<String, dynamic>.from(row as Map);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

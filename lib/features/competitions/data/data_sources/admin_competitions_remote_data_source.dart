import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for admin management of `competitions`.
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Mapping to
/// domain models is the repository's responsibility
/// (see [AdminCompetitionsRepository]).
class AdminCompetitionsRemoteDataSource {
  const AdminCompetitionsRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const competitionColumns =
      'id, title, description, starts_at, ends_at, is_active';

  Future<List<Map<String, dynamic>>> fetchAll() async {
    final rows = await _client
        .from('competitions')
        .select(competitionColumns)
        .order('starts_at', ascending: false);
    return _asMaps(rows);
  }

  Future<Map<String, dynamic>> update(
    String id,
    Map<String, dynamic> payload,
  ) async {
    final row = await _client
        .from('competitions')
        .update(payload)
        .eq('id', id)
        .select(competitionColumns)
        .single();
    return Map<String, dynamic>.from(row);
  }

  Future<Map<String, dynamic>> insert(Map<String, dynamic> payload) async {
    final row = await _client
        .from('competitions')
        .insert(payload)
        .select(competitionColumns)
        .single();
    return Map<String, dynamic>.from(row);
  }

  Future<void> delete(String id) async {
    await _client.from('competitions').delete().eq('id', id);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for `competitions` and `competition_entries`.
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Mapping to
/// domain models is the repository's responsibility (see [CompetitionsRepository]).
class CompetitionsRemoteDataSource {
  const CompetitionsRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const competitionColumns =
      'id, title, description, starts_at, ends_at, is_active';

  static const entryColumns =
      'id, competition_id, profile_id, score, joined_at, '
      'profiles(full_name)';

  Future<List<Map<String, dynamic>>> fetchActive() async {
    final rows = await _client
        .from('competitions')
        .select(competitionColumns)
        .eq('is_active', true)
        .gte('ends_at', DateTime.now().toUtc().toIso8601String())
        .order('starts_at');
    return _asMaps(rows);
  }

  Future<Map<String, dynamic>?> fetchById(String competitionId) async {
    final row = await _client
        .from('competitions')
        .select(competitionColumns)
        .eq('id', competitionId)
        .maybeSingle();
    return row == null ? null : Map<String, dynamic>.from(row);
  }

  Future<List<Map<String, dynamic>>> fetchEntries(String competitionId) async {
    final rows = await _client
        .from('competition_entries')
        .select(entryColumns)
        .eq('competition_id', competitionId)
        .order('score', ascending: false)
        .limit(20);
    return _asMaps(rows);
  }

  Future<Map<String, dynamic>> insertEntry({
    required String competitionId,
    required String profileId,
  }) async {
    final row = await _client
        .from('competition_entries')
        .insert({
          'competition_id': competitionId,
          'profile_id': profileId,
        })
        .select(entryColumns)
        .single();
    return Map<String, dynamic>.from(row);
  }

  Future<Map<String, dynamic>> fetchEntryScore(String entryId) async {
    final row = await _client
        .from('competition_entries')
        .select('score')
        .eq('id', entryId)
        .single();
    return Map<String, dynamic>.from(row);
  }

  Future<Map<String, dynamic>> updateEntryScore({
    required String entryId,
    required int score,
  }) async {
    final row = await _client
        .from('competition_entries')
        .update({'score': score})
        .eq('id', entryId)
        .select(entryColumns)
        .single();
    return Map<String, dynamic>.from(row);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

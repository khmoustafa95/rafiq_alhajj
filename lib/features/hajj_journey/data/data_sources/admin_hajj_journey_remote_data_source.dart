import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for admin management of `hajj_journey_steps` and
/// `hajj_journey_media`.
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Mapping to
/// domain models is the repository's responsibility
/// (see [AdminHajjJourneyRepository]).
class AdminHajjJourneyRemoteDataSource {
  const AdminHajjJourneyRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const stepColumns =
      'id, ritual_key, sort_order, title_ar, title_en, '
      'description_ar, description_en, is_active, '
      'hajj_journey_media(id, media_type, title, url, sort_order)';

  Future<List<Map<String, dynamic>>> fetchAll() async {
    final rows = await _client
        .from('hajj_journey_steps')
        .select(stepColumns)
        .order('sort_order');
    return _asMaps(rows);
  }

  Future<Map<String, dynamic>?> fetchByRitualKey(String ritualKey) async {
    final row = await _client
        .from('hajj_journey_steps')
        .select(stepColumns)
        .eq('ritual_key', ritualKey)
        .maybeSingle();
    return row == null ? null : Map<String, dynamic>.from(row);
  }

  Future<void> upsertStep(Map<String, dynamic> payload) async {
    await _client.from('hajj_journey_steps').upsert(
          payload,
          onConflict: 'ritual_key',
        );
  }

  Future<void> deleteMedia(String stepId) async {
    await _client.from('hajj_journey_media').delete().eq('step_id', stepId);
  }

  Future<void> insertMedia(List<Map<String, dynamic>> payloads) async {
    await _client.from('hajj_journey_media').insert(payloads);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

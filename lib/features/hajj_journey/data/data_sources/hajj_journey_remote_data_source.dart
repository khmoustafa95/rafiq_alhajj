import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for `hajj_journey_steps` and `hajj_journey_media`.
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Mapping to
/// domain models is the repository's responsibility
/// (see [HajjJourneyRepository]).
class HajjJourneyRemoteDataSource {
  const HajjJourneyRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const stepColumns =
      'id, ritual_key, sort_order, title_ar, title_en, '
      'description_ar, description_en, is_active, '
      'hajj_journey_media(id, media_type, title, url, sort_order)';

  Future<List<Map<String, dynamic>>> fetchActiveSteps() async {
    final rows = await _client
        .from('hajj_journey_steps')
        .select(stepColumns)
        .eq('is_active', true)
        .order('sort_order');
    return _asMaps(rows);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

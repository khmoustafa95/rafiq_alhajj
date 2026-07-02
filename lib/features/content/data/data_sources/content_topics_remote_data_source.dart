import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for the public `content_topics` catalogue.
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Mapping to
/// domain models is the repository's responsibility.
class ContentTopicsRemoteDataSource {
  const ContentTopicsRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const topicColumns =
      'id, title, title_ar, title_en, description, description_ar, '
      'description_en, cover_image_url, visibility, sort_order, is_active, '
      'publication_status, published_at, created_at, '
      'content_topic_media(id, media_type, title, url, sort_order)';

  Future<List<Map<String, dynamic>>> fetchActive() async {
    final rows = await _client
        .from('content_topics')
        .select(topicColumns)
        .eq('is_active', true)
        .order('sort_order');
    return _asMaps(rows);
  }

  Future<Map<String, dynamic>?> fetchById(String id) async {
    final row = await _client
        .from('content_topics')
        .select(topicColumns)
        .eq('id', id)
        .eq('is_active', true)
        .maybeSingle();
    if (row == null) {
      return null;
    }
    return Map<String, dynamic>.from(row);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

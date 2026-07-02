import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for the `content_topics` and `content_topic_media`
/// CMS tables.
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Mapping to
/// domain models and payload building is the repository's responsibility.
class AdminContentTopicsRemoteDataSource {
  const AdminContentTopicsRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const topicColumns =
      'id, title, title_ar, title_en, description, description_ar, '
      'description_en, cover_image_url, visibility, sort_order, is_active, '
      'publication_status, published_at, created_at, '
      'content_topic_media(id, media_type, title, url, sort_order)';

  Future<List<Map<String, dynamic>>> fetchAll() async {
    final rows = await _client
        .from('content_topics')
        .select(topicColumns)
        .order('sort_order');
    return _asMaps(rows);
  }

  Future<Map<String, dynamic>?> fetchById(String id) async {
    final row = await _client
        .from('content_topics')
        .select(topicColumns)
        .eq('id', id)
        .maybeSingle();
    if (row == null) {
      return null;
    }
    return Map<String, dynamic>.from(row);
  }

  Future<void> updateTopic(String id, Map<String, dynamic> payload) async {
    await _client.from('content_topics').update(payload).eq('id', id);
  }

  Future<Map<String, dynamic>> insertTopic(Map<String, dynamic> payload) async {
    final row = await _client
        .from('content_topics')
        .insert(payload)
        .select('id')
        .single();
    return Map<String, dynamic>.from(row);
  }

  Future<void> deleteMedia(String topicId) async {
    await _client.from('content_topic_media').delete().eq('topic_id', topicId);
  }

  Future<void> insertMedia(List<Map<String, dynamic>> rows) async {
    await _client.from('content_topic_media').insert(rows);
  }

  Future<void> deleteTopic(String id) async {
    await _client.from('content_topics').delete().eq('id', id);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

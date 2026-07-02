import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for pilgrim learning progress.
class ContentLearningProgressRemoteDataSource {
  const ContentLearningProgressRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const columns =
      'id, profile_id, topic_id, media_id, topic_title, media_title, '
      'position_ms, completed, updated_at';

  Future<List<Map<String, dynamic>>> fetchForProfile(String profileId) async {
    final rows = await _client
        .from('content_learning_progress')
        .select(columns)
        .eq('profile_id', profileId)
        .order('updated_at', ascending: false);
    return _asMaps(rows);
  }

  Future<void> upsert({
    required String profileId,
    required String topicId,
    required String mediaId,
    String? topicTitle,
    String? mediaTitle,
    required int positionMs,
    required bool completed,
  }) async {
    await _client.from('content_learning_progress').upsert(
      {
        'profile_id': profileId,
        'topic_id': topicId,
        'media_id': mediaId,
        'topic_title': topicTitle,
        'media_title': mediaTitle,
        'position_ms': positionMs,
        'completed': completed,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      },
      onConflict: 'profile_id,media_id',
    );
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

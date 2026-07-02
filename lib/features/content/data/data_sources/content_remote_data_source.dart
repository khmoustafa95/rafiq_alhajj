import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for the public `content_library`.
///
/// Owns all [SupabaseClient] calls and returns raw rows. Mapping to domain
/// models is the repository's responsibility (see [SupabaseContentRepository]).
class ContentRemoteDataSource {
  const ContentRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const Duration _requestTimeout = Duration(seconds: 15);

  static const columns =
      'id, title, title_ar, title_en, description, description_ar, '
      'description_en, media_url, type, visibility, publication_status, '
      'published_at, created_at';

  Future<List<Map<String, dynamic>>> fetchBrowsableFeed() async {
    final rows = await _client
        .from('content_library')
        .select(columns)
        .inFilter('type', ['news', 'announcement'])
        .order('created_at', ascending: false)
        .timeout(_requestTimeout);
    return _asMaps(rows);
  }

  Future<Map<String, dynamic>?> fetchById(String id) async {
    final row = await _client
        .from('content_library')
        .select(columns)
        .eq('id', id)
        .maybeSingle()
        .timeout(_requestTimeout);

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

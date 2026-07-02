import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/utils/postgrest_search_sanitize.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for the `content_library` CMS table.
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Mapping to
/// domain models and payload building is the repository's responsibility.
class AdminContentRemoteDataSource {
  const AdminContentRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const contentColumns =
      'id, title, title_ar, title_en, description, description_ar, '
      'description_en, media_url, type, visibility, publication_status, '
      'published_at, created_at';

  Future<Map<String, dynamic>?> fetchById(String id) async {
    final row = await _client
        .from('content_library')
        .select(contentColumns)
        .eq('id', id)
        .maybeSingle();
    if (row == null) {
      return null;
    }
    return Map<String, dynamic>.from(row);
  }

  Future<({List<Map<String, dynamic>> rows, int count})> fetchPage(
    StaffTableQuery query,
  ) async {
    var request = _client.from('content_library').select(contentColumns);

    final search = query.search.trim();
    if (search.isNotEmpty) {
      final term = sanitizePostgrestSearchTerm(search);
      request = request.or(
        'title.ilike.%$term%,title_ar.ilike.%$term%,title_en.ilike.%$term%,'
        'description.ilike.%$term%,description_ar.ilike.%$term%',
      );
    }

    final type = query.filters['type'];
    if (type != null && type.isNotEmpty) {
      request = request.eq('type', type);
    }

    final visibility = query.filters['visibility'];
    if (visibility != null && visibility.isNotEmpty) {
      request = request.eq('visibility', visibility);
    }

    final sortColumn = switch (query.sortColumnId) {
      'type' => 'type',
      'visibility' => 'visibility',
      'created_at' => 'created_at',
      _ => 'title',
    };

    final response = await request
        .order(sortColumn, ascending: query.sortAscending)
        .range(query.from, query.to)
        .count(CountOption.exact);

    return (rows: _asMaps(response.data), count: response.count);
  }

  Future<List<Map<String, dynamic>>> fetchAll() async {
    final rows = await _client
        .from('content_library')
        .select(contentColumns)
        .order('created_at', ascending: false);
    return _asMaps(rows);
  }

  Future<Map<String, dynamic>> upsert(
    Map<String, dynamic> payload, {
    String? id,
  }) async {
    final row = id != null
        ? await _client
            .from('content_library')
            .update(payload)
            .eq('id', id)
            .select(contentColumns)
            .single()
        : await _client
            .from('content_library')
            .insert(payload)
            .select(contentColumns)
            .single();
    return Map<String, dynamic>.from(row);
  }

  Future<void> delete(String id) async {
    await _client.from('content_library').delete().eq('id', id);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

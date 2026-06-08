import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/utils/postgrest_search_sanitize.dart';
import 'package:rafiq_alhajj/features/admin_content/domain/models/content_editor_input.dart';
import 'package:rafiq_alhajj/features/content/data/dtos/content_item_dto.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminContentException implements Exception {
  const AdminContentException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Content CMS request failed';
}

class AdminContentRepository {
  AdminContentRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  static const _contentSelect =
      'id, title, description, media_url, type, visibility, created_at';

  Future<ContentItem?> fetchById(String id) async {
    if (!isAvailable) {
      throw const AdminContentException('Supabase is not configured');
    }

    try {
      final row = await _client!
          .from('content_library')
          .select(_contentSelect)
          .eq('id', id)
          .maybeSingle();

      if (row == null) {
        return null;
      }

      return ContentItemDto.fromJson(
        Map<String, dynamic>.from(row as Map),
      ).toDomain();
    } on PostgrestException catch (e) {
      throw AdminContentException(e.message);
    }
  }

  Future<PaginatedResult<ContentItem>> fetchPage(StaffTableQuery query) async {
    if (!isAvailable) {
      throw const AdminContentException('Supabase is not configured');
    }

    try {
      var request = _client!.from('content_library').select(_contentSelect);

      final search = query.search.trim();
      if (search.isNotEmpty) {
        final term = sanitizePostgrestSearchTerm(search);
        request = request.or(
          'title.ilike.%$term%,description.ilike.%$term%',
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

      final rows = response.data as List<dynamic>;
      return PaginatedResult(
        items: rows
            .map(
              (row) => ContentItemDto.fromJson(
                Map<String, dynamic>.from(row as Map),
              ).toDomain(),
            )
            .toList(),
        totalCount: response.count,
        pageSize: query.pageSize,
      );
    } on PostgrestException catch (e) {
      throw AdminContentException(e.message);
    }
  }

  Future<List<ContentItem>> fetchAll() async {
    if (!isAvailable) {
      throw const AdminContentException('Supabase is not configured');
    }

    try {
      final rows = await _client!
          .from('content_library')
          .select(_contentSelect)
          .order('created_at', ascending: false);

      return (rows as List<dynamic>)
          .map(
            (row) => ContentItemDto.fromJson(
              Map<String, dynamic>.from(row as Map),
            ).toDomain(),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw AdminContentException(e.message);
    }
  }

  Future<ContentItem> upsert(ContentEditorInput input) async {
    if (!isAvailable) {
      throw const AdminContentException('Supabase is not configured');
    }

    try {
      final payload = input.toDatabasePayload();

      if (input.id != null) {
        final row = await _client!
            .from('content_library')
            .update(payload)
            .eq('id', input.id!)
            .select(_contentSelect)
            .single();
        return ContentItemDto.fromJson(Map<String, dynamic>.from(row)).toDomain();
      }

      final row = await _client!
          .from('content_library')
          .insert(payload)
          .select(_contentSelect)
          .single();
      return ContentItemDto.fromJson(Map<String, dynamic>.from(row)).toDomain();
    } on PostgrestException catch (e) {
      throw AdminContentException(e.message);
    }
  }

  Future<void> delete(String id) async {
    if (!isAvailable) {
      throw const AdminContentException('Supabase is not configured');
    }

    try {
      await _client!.from('content_library').delete().eq('id', id);
    } on PostgrestException catch (e) {
      throw AdminContentException(e.message);
    }
  }
}

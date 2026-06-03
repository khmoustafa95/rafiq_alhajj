import 'package:rafiq_alhajj/core/config/app_config.dart';
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

  Future<List<ContentItem>> fetchAll() async {
    if (!isAvailable) {
      throw const AdminContentException('Supabase is not configured');
    }

    try {
      final rows = await _client!
          .from('content_library')
          .select(
            'id, title, description, media_url, type, visibility, created_at',
          )
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
            .select(
              'id, title, description, media_url, type, visibility, created_at',
            )
            .single();
        return ContentItemDto.fromJson(Map<String, dynamic>.from(row)).toDomain();
      }

      final row = await _client!
          .from('content_library')
          .insert(payload)
          .select(
            'id, title, description, media_url, type, visibility, created_at',
          )
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

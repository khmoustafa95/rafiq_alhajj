import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContentTopicsException implements Exception {
  const ContentTopicsException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Content topics request failed';
}

class ContentTopicsRepository {
  ContentTopicsRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  Future<List<ContentTopic>> fetchActive({
    required bool includePilgrimOnly,
  }) async {
    if (!isAvailable) {
      return [];
    }

    try {
      final rows = await _client!
          .from('content_topics')
          .select(
            'id, title, description, cover_image_url, visibility, '
            'sort_order, is_active, created_at, '
            'content_topic_media(id, media_type, title, url, sort_order)',
          )
          .eq('is_active', true)
          .order('sort_order');

      return (rows as List<dynamic>)
          .map((row) => _mapTopic(Map<String, dynamic>.from(row as Map)))
          .where(
            (topic) =>
                topic.visibility == ContentVisibility.public ||
                (includePilgrimOnly &&
                    topic.visibility == ContentVisibility.pilgrimOnly),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ContentTopicsException(e.message);
    }
  }

  Future<ContentTopic?> fetchById(String id) async {
    if (!isAvailable) {
      return null;
    }

    try {
      final row = await _client!
          .from('content_topics')
          .select(
            'id, title, description, cover_image_url, visibility, '
            'sort_order, is_active, created_at, '
            'content_topic_media(id, media_type, title, url, sort_order)',
          )
          .eq('id', id)
          .eq('is_active', true)
          .maybeSingle();

      if (row == null) {
        return null;
      }

      return _mapTopic(Map<String, dynamic>.from(row));
    } on PostgrestException catch (e) {
      throw ContentTopicsException(e.message);
    }
  }

  ContentTopic _mapTopic(Map<String, dynamic> row) {
    final mediaRows = row['content_topic_media'] as List<dynamic>? ?? [];
    final media = mediaRows
        .map((m) => _mapMedia(Map<String, dynamic>.from(m as Map)))
        .toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

    return ContentTopic(
      id: row['id'] as String,
      title: row['title'] as String,
      description: row['description'] as String?,
      coverImageUrl: row['cover_image_url'] as String?,
      visibility: ContentVisibility.fromDatabase(
        row['visibility'] as String,
      ),
      sortOrder: row['sort_order'] as int? ?? 0,
      isActive: row['is_active'] as bool? ?? true,
      media: media,
      createdAt: DateTime.parse(row['created_at'] as String),
    );
  }

  ContentTopicMedia _mapMedia(Map<String, dynamic> row) {
    return ContentTopicMedia(
      id: row['id'] as String,
      mediaType: EducationalMediaType.typeFromKey(
        row['media_type'] as String,
      ),
      title: row['title'] as String?,
      url: row['url'] as String,
      sortOrder: row['sort_order'] as int? ?? 0,
    );
  }
}

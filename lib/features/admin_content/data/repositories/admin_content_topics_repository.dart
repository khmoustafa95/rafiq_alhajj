import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/features/content/data/repositories/content_topics_repository.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminContentTopicsRepository {
  AdminContentTopicsRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  Future<List<ContentTopic>> fetchAll() async {
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
          .order('sort_order');

      return (rows as List<dynamic>)
          .map((row) => _mapTopic(Map<String, dynamic>.from(row as Map)))
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
          .maybeSingle();

      if (row == null) {
        return null;
      }

      return _mapTopic(Map<String, dynamic>.from(row));
    } on PostgrestException catch (e) {
      throw ContentTopicsException(e.message);
    }
  }

  Future<String> upsertTopic({
    String? id,
    required ContentTopicEditorInput input,
  }) async {
    if (!isAvailable) {
      throw const ContentTopicsException('Supabase unavailable');
    }

    try {
      final payload = {
        'title': input.title.trim(),
        'description': _nullIfEmpty(input.description),
        'cover_image_url': _nullIfEmpty(input.coverImageUrl),
        'visibility': input.visibility.databaseValue,
        'sort_order': input.sortOrder,
        'is_active': input.isActive,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      };

      if (id != null) {
        await _client!.from('content_topics').update(payload).eq('id', id);
        return id;
      }

      final row = await _client!
          .from('content_topics')
          .insert(payload)
          .select('id')
          .single();

      return row['id'] as String;
    } on PostgrestException catch (e) {
      throw ContentTopicsException(e.message);
    }
  }

  Future<void> replaceMedia({
    required String topicId,
    required List<ContentTopicMediaInput> media,
  }) async {
    if (!isAvailable) {
      throw const ContentTopicsException('Supabase unavailable');
    }

    try {
      await _client!.from('content_topic_media').delete().eq('topic_id', topicId);

      if (media.isEmpty) {
        return;
      }

      await _client.from('content_topic_media').insert(
            media
                .map(
                  (item) => {
                    'topic_id': topicId,
                    'media_type': item.mediaTypeKey,
                    'title': _nullIfEmpty(item.title),
                    'url': item.url.trim(),
                    'sort_order': item.sortOrder,
                  },
                )
                .toList(),
          );
    } on PostgrestException catch (e) {
      throw ContentTopicsException(e.message);
    }
  }

  Future<void> deleteTopic(String id) async {
    if (!isAvailable) {
      throw const ContentTopicsException('Supabase unavailable');
    }

    try {
      await _client!.from('content_topics').delete().eq('id', id);
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

  static String? _nullIfEmpty(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}

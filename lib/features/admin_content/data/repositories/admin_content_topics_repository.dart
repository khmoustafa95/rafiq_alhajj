import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/features/admin_content/data/data_sources/admin_content_topics_remote_data_source.dart';
import 'package:rafiq_alhajj/features/content/data/repositories/content_topics_repository.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_publication_status.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminContentTopicsRepository {
  AdminContentTopicsRepository([SupabaseClient? client])
      : _remote = AppConfig.hasSupabase && client != null
            ? AdminContentTopicsRemoteDataSource(client)
            : null;

  final AdminContentTopicsRemoteDataSource? _remote;

  bool get isAvailable => _remote != null;

  Future<List<ContentTopic>> fetchAll() async {
    final remote = _remote;
    if (remote == null) {
      return [];
    }

    try {
      final rows = await remote.fetchAll();

      return rows.map(_mapTopic).toList();
    } on PostgrestException catch (e) {
      throw ContentTopicsException(e.message);
    }
  }

  Future<ContentTopic?> fetchById(String id) async {
    final remote = _remote;
    if (remote == null) {
      return null;
    }

    try {
      final row = await remote.fetchById(id);

      if (row == null) {
        return null;
      }

      return _mapTopic(row);
    } on PostgrestException catch (e) {
      throw ContentTopicsException(e.message);
    }
  }

  Future<String> upsertTopic({
    String? id,
    required ContentTopicEditorInput input,
  }) async {
    final remote = _remote;
    if (remote == null) {
      throw const ContentTopicsException('Supabase unavailable');
    }

    try {
      final payload = {
        'title': input.titleAr.trim(),
        'title_ar': input.titleAr.trim(),
        'title_en': _nullIfEmpty(input.titleEn),
        'description_ar': _nullIfEmpty(input.descriptionAr),
        'description_en': _nullIfEmpty(input.descriptionEn),
        'description': _nullIfEmpty(input.descriptionAr),
        'cover_image_url': _nullIfEmpty(input.coverImageUrl),
        'visibility': input.visibility.databaseValue,
        'sort_order': input.sortOrder,
        'is_active': input.isActive,
        'publication_status': input.publicationStatus.databaseValue,
        'published_at': input.publicationStatus ==
                ContentPublicationStatus.published
            ? (input.publishedAt ?? DateTime.now().toUtc()).toIso8601String()
            : null,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      };

      if (id != null) {
        await remote.updateTopic(id, payload);
        return id;
      }

      final row = await remote.insertTopic(payload);

      return row['id'] as String;
    } on PostgrestException catch (e) {
      throw ContentTopicsException(e.message);
    }
  }

  Future<void> replaceMedia({
    required String topicId,
    required List<ContentTopicMediaInput> media,
  }) async {
    final remote = _remote;
    if (remote == null) {
      throw const ContentTopicsException('Supabase unavailable');
    }

    try {
      await remote.deleteMedia(topicId);

      if (media.isEmpty) {
        return;
      }

      await remote.insertMedia(
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
    final remote = _remote;
    if (remote == null) {
      throw const ContentTopicsException('Supabase unavailable');
    }

    try {
      await remote.deleteTopic(id);
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
      titleAr: (row['title_ar'] as String?) ?? row['title'] as String,
      titleEn: row['title_en'] as String?,
      descriptionAr:
          (row['description_ar'] as String?) ?? row['description'] as String?,
      descriptionEn: row['description_en'] as String?,
      coverImageUrl: row['cover_image_url'] as String?,
      visibility: ContentVisibility.fromDatabase(
        row['visibility'] as String,
      ),
      sortOrder: row['sort_order'] as int? ?? 0,
      isActive: row['is_active'] as bool? ?? true,
      publicationStatus: row['publication_status'] != null
          ? ContentPublicationStatus.fromDatabase(
              row['publication_status'] as String,
            )
          : ContentPublicationStatus.published,
      publishedAt: row['published_at'] != null
          ? DateTime.parse(row['published_at'] as String)
          : null,
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

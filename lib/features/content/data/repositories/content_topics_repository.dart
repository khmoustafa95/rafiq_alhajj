import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/features/content/data/data_sources/content_topics_remote_data_source.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_publication_status.dart';
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
  ContentTopicsRepository([SupabaseClient? client])
      : _remote = AppConfig.hasSupabase && client != null
            ? ContentTopicsRemoteDataSource(client)
            : null;

  final ContentTopicsRemoteDataSource? _remote;

  bool get isAvailable => _remote != null;

  Future<List<ContentTopic>> fetchActive({
    required bool includePilgrimOnly,
  }) async {
    final remote = _remote;
    if (remote == null) {
      return [];
    }

    try {
      final rows = await remote.fetchActive();

      return rows
          .map(_mapTopic)
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
}

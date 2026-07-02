import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/content/data/data_sources/content_learning_progress_remote_data_source.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_media_progress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ContentLearningProgressRepository {
  ContentLearningProgressRepository([SupabaseClient? client])
      : _remote = AppConfig.hasSupabase && client != null
            ? ContentLearningProgressRemoteDataSource(client)
            : null;

  final ContentLearningProgressRemoteDataSource? _remote;

  bool get isAvailable => _remote != null;

  Future<List<ContentMediaProgress>> fetchForProfile(String profileId) async {
    final remote = _remote;
    if (remote == null) {
      return [];
    }

    try {
      final rows = await remote.fetchForProfile(profileId);
      return rows.map(_mapRow).whereType<ContentMediaProgress>().toList();
    } on PostgrestException {
      return [];
    }
  }

  Future<void> upsert({
    required String profileId,
    required ContentMediaProgress progress,
  }) async {
    final remote = _remote;
    if (remote == null) {
      return;
    }

    try {
      await remote.upsert(
        profileId: profileId,
        topicId: progress.topicId,
        mediaId: progress.mediaId,
        topicTitle: progress.topicTitle,
        mediaTitle: progress.mediaTitle,
        positionMs: progress.positionMs,
        completed: progress.completed,
      );
    } on PostgrestException {
      // Offline-first: local cache remains authoritative until next sync.
    }
  }

  ContentMediaProgress? _mapRow(Map<String, dynamic> row) {
    try {
      return ContentMediaProgress(
        topicId: row['topic_id'] as String,
        mediaId: row['media_id'] as String,
        topicTitle: row['topic_title'] as String? ?? '',
        mediaTitle: row['media_title'] as String?,
        positionMs: row['position_ms'] as int? ?? 0,
        completed: row['completed'] as bool? ?? false,
        updatedAt: DateTime.parse(row['updated_at'] as String),
      );
    } catch (_) {
      return null;
    }
  }
}

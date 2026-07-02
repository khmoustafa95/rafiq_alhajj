import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_media_progress_cache.dart';
import 'package:rafiq_alhajj/features/content/data/repositories/content_learning_progress_repository.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_media_progress.dart';

/// Merges local learning progress with Supabase (offline-first, last-write-wins).
class ContentLearningProgressSyncService {
  const ContentLearningProgressSyncService(this._repository);

  final ContentLearningProgressRepository _repository;

  Future<void> pushLocal(String profileId, ContentMediaProgress progress) async {
    if (!_repository.isAvailable) {
      return;
    }
    await _repository.upsert(profileId: profileId, progress: progress);
  }

  Future<void> pullAndMerge(String profileId) async {
    if (!_repository.isAvailable || !AppConfig.hasSupabase) {
      return;
    }

    final remote = await _repository.fetchForProfile(profileId);
    if (remote.isEmpty) {
      return;
    }

    final local = await ContentMediaProgressCache.readAll(profileId);
    final localByMedia = {for (final p in local) p.mediaId: p};

    for (final server in remote) {
      final existing = localByMedia[server.mediaId];
      if (existing == null ||
          server.updatedAt.isAfter(existing.updatedAt)) {
        await ContentMediaProgressCache.save(profileId, server);
      }
    }
  }

  Future<List<ContentMediaProgress>> listAll(String profileId) async {
    return ContentMediaProgressCache.readAll(profileId);
  }
}

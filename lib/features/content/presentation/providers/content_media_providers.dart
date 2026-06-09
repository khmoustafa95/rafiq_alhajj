import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/content/application/services/content_media_cache_service.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_media_cache_store.dart';
import 'package:rafiq_alhajj/features/content/data/storage/content_media_storage_service.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'content_media_providers.g.dart';

@Riverpod(keepAlive: true)
Future<ContentMediaCacheStore> contentMediaCacheStore(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return ContentMediaCacheStore(prefs);
}

@Riverpod(keepAlive: true)
Future<ContentMediaCacheService> contentMediaCacheService(Ref ref) async {
  final store = await ref.watch(contentMediaCacheStoreProvider.future);
  return ContentMediaCacheService(store);
}

@Riverpod(keepAlive: true)
ContentMediaStorageService contentMediaStorageService(Ref ref) {
  return ContentMediaStorageService(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
class ContentMediaDownloadController extends _$ContentMediaDownloadController {
  @override
  Future<ContentDownloadState> build() async {
    final store = await ref.watch(contentMediaCacheStoreProvider.future);
    return ContentDownloadState(offlineEnabled: store.offlineEnabled);
  }

  Future<void> setOfflineEnabled(
    bool enabled, {
    List<ContentTopic> topics = const [],
  }) async {
    final store = await ref.read(contentMediaCacheStoreProvider.future);
    await store.setOfflineEnabled(enabled);
    state = AsyncData(
      (state.value ?? const ContentDownloadState()).copyWith(
        offlineEnabled: enabled,
      ),
    );

    if (enabled && topics.isNotEmpty) {
      await enqueueTopics(topics);
    }
  }

  Future<void> enqueueTopics(List<ContentTopic> topics) async {
    final cache = await ref.read(contentMediaCacheServiceProvider.future);
    final current = state.value ?? const ContentDownloadState();
    final jobs = Map<String, MediaDownloadJob>.from(current.jobs);

    for (final topic in topics) {
      for (final media in topic.media) {
        if (!ContentMediaUrlRules.isCacheable(media.url)) {
          jobs[media.id] = MediaDownloadJob(
            mediaId: media.id,
            status: MediaDownloadStatus.skipped,
          );
          continue;
        }
        jobs[media.id] = MediaDownloadJob(
          mediaId: media.id,
          status: MediaDownloadStatus.queued,
        );
      }
    }

    state = AsyncData(
      current.copyWith(jobs: jobs, isProcessing: true),
    );

    await _processQueue(topics, cache);
  }

  Future<void> enqueueTopic(ContentTopic topic) {
    return enqueueTopics([topic]);
  }

  Future<void> clearCache() async {
    final store = await ref.read(contentMediaCacheStoreProvider.future);
    final cache = await ref.read(contentMediaCacheServiceProvider.future);
    await cache.clearAll();
    await store.setOfflineEnabled(false);
    state = const AsyncData(ContentDownloadState());
  }

  Future<void> _processQueue(
    List<ContentTopic> topics,
    ContentMediaCacheService cache,
  ) async {
    final jobs = Map<String, MediaDownloadJob>.from(
      state.value?.jobs ?? const {},
    );

    for (final topic in topics) {
      for (final media in topic.media) {
        if (!ContentMediaUrlRules.isCacheable(media.url)) {
          continue;
        }

        jobs[media.id] = MediaDownloadJob(
          mediaId: media.id,
          status: MediaDownloadStatus.downloading,
        );
        state = AsyncData(
          (state.value ?? const ContentDownloadState()).copyWith(
            jobs: Map.from(jobs),
            isProcessing: true,
          ),
        );

        final result = await cache.downloadMedia(
          mediaId: media.id,
          remoteUrl: media.url,
          topicId: topic.id,
          mediaType: media.mediaType,
          onProgress: (progress) {
            jobs[media.id] = MediaDownloadJob(
              mediaId: media.id,
              status: MediaDownloadStatus.downloading,
              progress: progress,
            );
            state = AsyncData(
              (state.value ?? const ContentDownloadState()).copyWith(
                jobs: Map.from(jobs),
                isProcessing: true,
              ),
            );
          },
        );
        jobs[media.id] = result;
      }
    }

    state = AsyncData(
      (state.value ?? const ContentDownloadState()).copyWith(
        jobs: jobs,
        isProcessing: false,
      ),
    );
  }
}

@riverpod
Future<String> resolvedMediaPlaybackUrl(
  Ref ref,
  String mediaId,
  String remoteUrl,
) async {
  final cache = await ref.watch(contentMediaCacheServiceProvider.future);
  return cache.resolvePlaybackUrl(
    mediaId: mediaId,
    remoteUrl: remoteUrl,
  );
}

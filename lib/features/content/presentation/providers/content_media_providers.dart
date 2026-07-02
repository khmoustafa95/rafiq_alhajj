import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/core/network/dio_provider.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/content/application/services/content_media_cache_service.dart';
import 'package:rafiq_alhajj/features/content/data/data_sources/content_media_remote_data_source.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_media_cache_store.dart';
import 'package:rafiq_alhajj/features/content/data/local/media_encryption_service.dart';
import 'package:rafiq_alhajj/features/content/data/storage/content_media_storage_service.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'content_media_providers.g.dart';

@Riverpod(keepAlive: true)
Future<ContentMediaCacheStore> contentMediaCacheStore(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  final profileId = ref.watch(authProfileIdProvider);
  final profileKey = profileId ?? 'guest';
  return ContentMediaCacheStore(prefs, profileKey: profileKey);
}

@Riverpod(keepAlive: true)
MediaEncryptionService mediaEncryptionService(Ref ref) {
  return MediaEncryptionService();
}

@Riverpod(keepAlive: true)
Future<ContentMediaCacheService> contentMediaCacheService(Ref ref) async {
  final store = await ref.watch(contentMediaCacheStoreProvider.future);
  final encryption = ref.watch(mediaEncryptionServiceProvider);
  final storage = ref.watch(contentMediaStorageServiceProvider);
  final dio = ref.watch(dioProvider);
  return ContentMediaCacheService(store, encryption, storage, dio: dio);
}

@Riverpod(keepAlive: true)
ContentMediaStorageService contentMediaStorageService(Ref ref) {
  final client = AppConfig.hasSupabase ? Supabase.instance.client : null;
  return ContentMediaStorageService(
    dataSource:
        client != null ? ContentMediaRemoteDataSource(client) : null,
    dio: ref.watch(dioProvider),
  );
}

class _PendingMedia {
  const _PendingMedia({
    required this.mediaId,
    required this.url,
    required this.topicId,
    required this.mediaType,
  });

  final String mediaId;
  final String url;
  final String topicId;
  final EducationalMediaType mediaType;
}

@Riverpod(keepAlive: true)
class ContentMediaDownloadController extends _$ContentMediaDownloadController {
  static const _maxAttempts = 3;

  final Map<String, _PendingMedia> _pending = {};
  final Map<String, CancelToken> _tokens = {};
  StreamSubscription<List<ConnectivityResult>>? _connectivitySub;
  bool _processing = false;

  @override
  Future<ContentDownloadState> build() async {
    final store = await ref.watch(contentMediaCacheStoreProvider.future);
    final cache = await ref.watch(contentMediaCacheServiceProvider.future);

    _connectivitySub ??=
        Connectivity().onConnectivityChanged.listen((results) {
      final onWifi = results.any(
        (r) =>
            r == ConnectivityResult.wifi || r == ConnectivityResult.ethernet,
      );
      final current = state.value;
      if (onWifi && (current?.waitingForWifi ?? false)) {
        unawaited(_processQueue());
      }
    });

    ref.onDispose(() {
      unawaited(_connectivitySub?.cancel());
      for (final token in _tokens.values) {
        token.cancel('disposed');
      }
    });

    return ContentDownloadState(
      offlineEnabled: store.offlineEnabled,
      wifiOnly: store.wifiOnly,
      quotaBytes: store.quotaBytes,
      usageBytes: cache.usageBytes,
    );
  }

  ContentDownloadState get _state =>
      state.value ?? const ContentDownloadState();

  Future<void> setOfflineEnabled(
    bool enabled, {
    List<ContentTopic> topics = const [],
  }) async {
    final store = await ref.read(contentMediaCacheStoreProvider.future);
    await store.setOfflineEnabled(enabled);
    state = AsyncData(_state.copyWith(offlineEnabled: enabled));

    if (enabled && topics.isNotEmpty) {
      await enqueueTopics(topics);
    }
  }

  Future<void> setWifiOnly(bool value) async {
    final store = await ref.read(contentMediaCacheStoreProvider.future);
    await store.setWifiOnly(value);
    state = AsyncData(_state.copyWith(wifiOnly: value));
    if (!value && _state.waitingForWifi) {
      await _processQueue();
    }
  }

  Future<void> enqueueTopics(List<ContentTopic> topics) async {
    final jobs = Map<String, MediaDownloadJob>.from(_state.jobs);

    for (final topic in topics) {
      for (final media in topic.media) {
        if (!ContentMediaUrlRules.isCacheable(media.url)) {
          jobs[media.id] = MediaDownloadJob(
            mediaId: media.id,
            status: MediaDownloadStatus.skipped,
          );
          continue;
        }
        // Don't re-queue a completed item.
        if (jobs[media.id]?.status == MediaDownloadStatus.completed) {
          continue;
        }
        _pending[media.id] = _PendingMedia(
          mediaId: media.id,
          url: media.url,
          topicId: topic.id,
          mediaType: media.mediaType,
        );
        jobs[media.id] = MediaDownloadJob(
          mediaId: media.id,
          status: MediaDownloadStatus.queued,
        );
      }
    }

    state = AsyncData(_state.copyWith(jobs: jobs));
    await _processQueue();
  }

  Future<void> enqueueJourneyStepMedia({
    required String ritualKey,
    required List<({String mediaId, String url, EducationalMediaType mediaType})>
        media,
  }) async {
    final topicId = 'journey_$ritualKey';
    final jobs = Map<String, MediaDownloadJob>.from(_state.jobs);

    for (final item in media) {
      if (!ContentMediaUrlRules.isCacheable(item.url)) {
        jobs[item.mediaId] = MediaDownloadJob(
          mediaId: item.mediaId,
          status: MediaDownloadStatus.skipped,
        );
        continue;
      }
      if (jobs[item.mediaId]?.status == MediaDownloadStatus.completed) {
        continue;
      }
      _pending[item.mediaId] = _PendingMedia(
        mediaId: item.mediaId,
        url: item.url,
        topicId: topicId,
        mediaType: item.mediaType,
      );
      jobs[item.mediaId] = MediaDownloadJob(
        mediaId: item.mediaId,
        status: MediaDownloadStatus.queued,
      );
    }

    state = AsyncData(_state.copyWith(jobs: jobs));
    await _processQueue();
  }

  Future<void> enqueueTopic(ContentTopic topic) async {
    await enqueueTopics([topic]);
    final cache = await ref.read(contentMediaCacheServiceProvider.future);
    final coverUrl = topic.coverImageUrl;
    if (coverUrl != null &&
        coverUrl.isNotEmpty &&
        ContentMediaUrlRules.isCacheable(coverUrl)) {
      await cache.downloadMedia(
        mediaId: coverMediaId(topic.id),
        remoteUrl: coverUrl,
        topicId: topic.id,
        mediaType: EducationalMediaType.image,
      );
    }
  }

  /// Synthetic media id for a topic cover image in the offline cache.
  static String coverMediaId(String topicId) => 'cover_topic_$topicId';

  /// Synthetic media id for a news/announcement cover image.
  static String contentCoverMediaId(String contentId) =>
      'cover_content_$contentId';

  Future<int?> estimateTopicDownloadBytes(ContentTopic topic) async {
    final cache = await ref.read(contentMediaCacheServiceProvider.future);
    var total = 0;
    var hasEstimate = false;
    for (final media in topic.media) {
      if (!ContentMediaUrlRules.isCacheable(media.url)) {
        continue;
      }
      final bytes = await cache.estimateDownloadBytes(media.url);
      if (bytes != null) {
        total += bytes;
        hasEstimate = true;
      }
    }
    final cover = topic.coverImageUrl;
    if (cover != null && ContentMediaUrlRules.isCacheable(cover)) {
      final bytes = await cache.estimateDownloadBytes(cover);
      if (bytes != null) {
        total += bytes;
        hasEstimate = true;
      }
    }
    return hasEstimate ? total : null;
  }

  void pause(String mediaId) {
    _tokens[mediaId]?.cancel('paused');
    _setJob(mediaId, MediaDownloadStatus.paused);
  }

  Future<void> retry(String mediaId) async {
    if (!_pending.containsKey(mediaId)) {
      return;
    }
    _setJob(mediaId, MediaDownloadStatus.queued, progress: 0);
    await _processQueue();
  }

  Future<void> removeTopicDownloads(String topicId) async {
    final cache = await ref.read(contentMediaCacheServiceProvider.future);
    await cache.removeTopic(topicId);
    final jobs = Map<String, MediaDownloadJob>.from(_state.jobs);
    _pending.removeWhere((id, p) {
      if (p.topicId == topicId) {
        _tokens.remove(id)?.cancel('removed');
        jobs.remove(id);
        return true;
      }
      return false;
    });
    // Also drop completed jobs for media that were enqueued elsewhere.
    state = AsyncData(_state.copyWith(jobs: jobs, usageBytes: cache.usageBytes));
  }

  Future<void> clearCache() async {
    final store = await ref.read(contentMediaCacheStoreProvider.future);
    final cache = await ref.read(contentMediaCacheServiceProvider.future);
    for (final token in _tokens.values) {
      token.cancel('cleared');
    }
    _tokens.clear();
    _pending.clear();
    await cache.clearAll();
    await store.setOfflineEnabled(false);
    state = AsyncData(
      ContentDownloadState(
        wifiOnly: store.wifiOnly,
        quotaBytes: store.quotaBytes,
      ),
    );
  }

  Future<bool> _isWifi() async {
    final results = await Connectivity().checkConnectivity();
    return results.any(
      (r) => r == ConnectivityResult.wifi || r == ConnectivityResult.ethernet,
    );
  }

  Future<void> _processQueue() async {
    if (_processing) {
      return;
    }
    _processing = true;
    final cache = await ref.read(contentMediaCacheServiceProvider.future);
    final store = await ref.read(contentMediaCacheStoreProvider.future);
    try {
      state = AsyncData(
        _state.copyWith(isProcessing: true, waitingForWifi: false),
      );

      while (true) {
        final next = _nextQueued();
        if (next == null) {
          break;
        }
        if (store.wifiOnly && !await _isWifi()) {
          state = AsyncData(
            _state.copyWith(isProcessing: false, waitingForWifi: true),
          );
          return;
        }
        await _downloadOne(next, cache);
      }

      state = AsyncData(
        _state.copyWith(
          isProcessing: false,
          waitingForWifi: false,
          usageBytes: cache.usageBytes,
        ),
      );
    } finally {
      _processing = false;
    }
  }

  _PendingMedia? _nextQueued() {
    for (final pending in _pending.values) {
      if (_state.jobs[pending.mediaId]?.status == MediaDownloadStatus.queued) {
        return pending;
      }
    }
    return null;
  }

  Future<void> _downloadOne(
    _PendingMedia pending,
    ContentMediaCacheService cache,
  ) async {
    final token = CancelToken();
    _tokens[pending.mediaId] = token;

    var attempt = 0;
    while (true) {
      attempt++;
      _setJob(pending.mediaId, MediaDownloadStatus.downloading, progress: 0);

      final result = await cache.downloadMedia(
        mediaId: pending.mediaId,
        remoteUrl: pending.url,
        topicId: pending.topicId,
        mediaType: pending.mediaType,
        cancelToken: token,
        onProgress: (progress) {
          _setJob(
            pending.mediaId,
            MediaDownloadStatus.downloading,
            progress: progress,
          );
        },
      );

      if (result.status == MediaDownloadStatus.failed &&
          attempt < _maxAttempts &&
          !token.isCancelled) {
        await Future<void>.delayed(Duration(seconds: attempt * 2));
        continue;
      }

      _tokens.remove(pending.mediaId);
      state = AsyncData(_state.copyWith(jobs: {..._state.jobs, pending.mediaId: result}));
      return;
    }
  }

  void _setJob(
    String mediaId,
    MediaDownloadStatus status, {
    double? progress,
  }) {
    final jobs = Map<String, MediaDownloadJob>.from(_state.jobs);
    final existing = jobs[mediaId];
    jobs[mediaId] = MediaDownloadJob(
      mediaId: mediaId,
      status: status,
      progress: progress ?? existing?.progress ?? 0,
    );
    state = AsyncData(_state.copyWith(jobs: jobs));
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

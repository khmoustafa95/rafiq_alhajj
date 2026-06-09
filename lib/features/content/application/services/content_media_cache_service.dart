import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_media_cache_store.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';

enum MediaDownloadStatus { idle, queued, downloading, completed, failed, skipped }

class MediaDownloadJob {
  const MediaDownloadJob({
    required this.mediaId,
    required this.status,
    this.progress = 0,
    this.error,
  });

  final String mediaId;
  final MediaDownloadStatus status;
  final double progress;
  final String? error;

  MediaDownloadJob copyWith({
    MediaDownloadStatus? status,
    double? progress,
    String? error,
  }) {
    return MediaDownloadJob(
      mediaId: mediaId,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      error: error,
    );
  }
}

class ContentDownloadState {
  const ContentDownloadState({
    this.offlineEnabled = false,
    this.jobs = const {},
    this.isProcessing = false,
  });

  final bool offlineEnabled;
  final Map<String, MediaDownloadJob> jobs;
  final bool isProcessing;

  ContentDownloadState copyWith({
    bool? offlineEnabled,
    Map<String, MediaDownloadJob>? jobs,
    bool? isProcessing,
  }) {
    return ContentDownloadState(
      offlineEnabled: offlineEnabled ?? this.offlineEnabled,
      jobs: jobs ?? this.jobs,
      isProcessing: isProcessing ?? this.isProcessing,
    );
  }
}

abstract final class ContentMediaUrlRules {
  static bool isCacheable(String url) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) {
      return false;
    }
    if (trimmed.startsWith('file://')) {
      return false;
    }
    final lower = trimmed.toLowerCase();
    if (lower.contains('youtube.com') ||
        lower.contains('youtu.be') ||
        lower.contains('youtube.com/embed')) {
      return false;
    }
    return trimmed.startsWith('http://') || trimmed.startsWith('https://');
  }
}

class ContentMediaCacheService {
  ContentMediaCacheService(this._store, {Dio? dio}) : _dio = dio ?? Dio();

  final ContentMediaCacheStore _store;
  final Dio _dio;

  Future<Directory> _cacheDir() async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory('${base.path}/content_media');
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  String? localPathFor(String mediaId) {
    return _store.readManifest()[mediaId]?.localPath;
  }

  Future<String> resolvePlaybackUrl({
    required String mediaId,
    required String remoteUrl,
  }) async {
    final local = localPathFor(mediaId);
    if (local != null && File(local).existsSync()) {
      return local;
    }
    return remoteUrl;
  }

  Future<void> clearAll() async {
    final dir = await _cacheDir();
    if (dir.existsSync()) {
      await dir.delete(recursive: true);
    }
    await _store.clearManifest();
  }

  Future<MediaDownloadJob> downloadMedia({
    required String mediaId,
    required String remoteUrl,
    required String topicId,
    required EducationalMediaType mediaType,
    void Function(double progress)? onProgress,
  }) async {
    if (!ContentMediaUrlRules.isCacheable(remoteUrl)) {
      return MediaDownloadJob(
        mediaId: mediaId,
        status: MediaDownloadStatus.skipped,
      );
    }

    final existing = _store.readManifest()[mediaId];
    if (existing != null && File(existing.localPath).existsSync()) {
      if (existing.remoteUrl == remoteUrl) {
        return MediaDownloadJob(
          mediaId: mediaId,
          status: MediaDownloadStatus.completed,
          progress: 1,
        );
      }
    }

    try {
      final dir = await _cacheDir();
      final extension = _extensionForUrl(remoteUrl, mediaType);
      final file = File('${dir.path}/$mediaId$extension');

      await _dio.download(
        remoteUrl,
        file.path,
        onReceiveProgress: (received, total) {
          if (total <= 0) {
            return;
          }
          onProgress?.call(received / total);
        },
      );

      final manifest = _store.readManifest();
      manifest[mediaId] = CachedContentMediaEntry(
        mediaId: mediaId,
        remoteUrl: remoteUrl,
        localPath: file.path,
        topicId: topicId,
        mediaType: mediaType.name,
        updatedAtMs: DateTime.now().millisecondsSinceEpoch,
      );
      await _store.writeManifest(manifest);

      return MediaDownloadJob(
        mediaId: mediaId,
        status: MediaDownloadStatus.completed,
        progress: 1,
      );
    } catch (e) {
      return MediaDownloadJob(
        mediaId: mediaId,
        status: MediaDownloadStatus.failed,
        error: e.toString(),
      );
    }
  }

  Future<void> downloadTopicMedia(ContentTopic topic) async {
    for (final item in topic.media) {
      await downloadMedia(
        mediaId: item.id,
        remoteUrl: item.url,
        topicId: topic.id,
        mediaType: item.mediaType,
      );
    }
  }

  int cachedCountForTopic(String topicId) {
    return _store
        .readManifest()
        .values
        .where((e) => e.topicId == topicId)
        .length;
  }

  int get cachedMediaCount => _store.readManifest().length;

  static String _extensionForUrl(String url, EducationalMediaType type) {
    final uri = Uri.tryParse(url);
    final path = uri?.path ?? '';
    final dot = path.lastIndexOf('.');
    if (dot != -1 && dot < path.length - 1) {
      final ext = path.substring(dot);
      if (ext.length <= 6) {
        return ext;
      }
    }
    return switch (type) {
      EducationalMediaType.audio => '.mp3',
      EducationalMediaType.image => '.jpg',
      EducationalMediaType.video => '.mp4',
    };
  }
}

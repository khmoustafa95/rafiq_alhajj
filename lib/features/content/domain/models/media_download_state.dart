import 'package:rafiq_alhajj/features/content/data/local/content_media_cache_store.dart';

enum MediaDownloadStatus {
  idle,
  queued,
  downloading,
  paused,
  completed,
  failed,
  skipped,
}

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
    this.wifiOnly = true,
    this.jobs = const {},
    this.isProcessing = false,
    this.usageBytes = 0,
    this.quotaBytes = ContentMediaCacheStore.defaultQuotaBytes,
    this.waitingForWifi = false,
  });

  final bool offlineEnabled;
  final bool wifiOnly;
  final Map<String, MediaDownloadJob> jobs;
  final bool isProcessing;
  final int usageBytes;
  final int quotaBytes;
  final bool waitingForWifi;

  ContentDownloadState copyWith({
    bool? offlineEnabled,
    bool? wifiOnly,
    Map<String, MediaDownloadJob>? jobs,
    bool? isProcessing,
    int? usageBytes,
    int? quotaBytes,
    bool? waitingForWifi,
  }) {
    return ContentDownloadState(
      offlineEnabled: offlineEnabled ?? this.offlineEnabled,
      wifiOnly: wifiOnly ?? this.wifiOnly,
      jobs: jobs ?? this.jobs,
      isProcessing: isProcessing ?? this.isProcessing,
      usageBytes: usageBytes ?? this.usageBytes,
      quotaBytes: quotaBytes ?? this.quotaBytes,
      waitingForWifi: waitingForWifi ?? this.waitingForWifi,
    );
  }
}

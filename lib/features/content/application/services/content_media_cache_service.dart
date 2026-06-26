import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_media_cache_store.dart';
import 'package:rafiq_alhajj/features/content/data/local/media_encryption_service.dart';
import 'package:rafiq_alhajj/features/content/data/storage/content_media_storage_service.dart';

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

/// Decides which refs can be stored offline.
abstract final class ContentMediaUrlRules {
  static bool isCacheable(String url) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) {
      return false;
    }
    // Private bucket refs are always downloadable (resolved via signed URL).
    if (ContentMediaStorageService.isPrivateRef(trimmed)) {
      return true;
    }
    if (trimmed.startsWith('file://')) {
      return false;
    }
    final lower = trimmed.toLowerCase();
    // External players (YouTube/Vimeo) can't be saved as plain media files.
    if (lower.contains('youtube.com') ||
        lower.contains('youtu.be') ||
        lower.contains('vimeo.com')) {
      return false;
    }
    return trimmed.startsWith('http://') || trimmed.startsWith('https://');
  }
}

class MediaCacheException implements Exception {
  const MediaCacheException(this.message);
  final String message;
  @override
  String toString() => message;
}

class ContentMediaCacheService {
  ContentMediaCacheService(
    this._store,
    this._encryption,
    this._storage, {
    Dio? dio,
  }) : _dio = dio ?? Dio();

  /// Reject downloads whose body exceeds this hard cap (bucket limit is 50 MiB;
  /// allow a little headroom). Guards against a misbehaving server / wrong URL.
  static const _maxDownloadBytes = 60 * 1024 * 1024;

  final ContentMediaCacheStore _store;
  final MediaEncryptionService _encryption;
  final ContentMediaStorageService _storage;
  final Dio _dio;

  /// In-memory map of mediaId -> decrypted temp file path for the session.
  final Map<String, String> _decryptedPaths = {};

  Future<Directory> _encryptedDir() async {
    final base = await getApplicationSupportDirectory();
    final dir = Directory('${base.path}/content_media_enc');
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  Future<Directory> _decryptDir() async {
    final base = await getTemporaryDirectory();
    final dir = Directory('${base.path}/content_media_dec');
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  int get cachedMediaCount => _store.readManifest().length;

  int cachedCountForTopic(String topicId) {
    return _store
        .readManifest()
        .values
        .where((e) => e.topicId == topicId)
        .length;
  }

  int get usageBytes {
    var total = 0;
    for (final entry in _store.readManifest().values) {
      total += entry.bytes;
    }
    return total;
  }

  bool isCached(String mediaId) {
    final entry = _store.readManifest()[mediaId];
    return entry != null && File(entry.encryptedPath).existsSync();
  }

  /// Resolves a source the players can consume:
  ///  * a decrypted local file path when an offline copy exists, else
  ///  * a signed URL for `private://` refs, else
  ///  * the plain remote URL.
  Future<String> resolvePlaybackUrl({
    required String mediaId,
    required String remoteUrl,
  }) async {
    final entry = _store.readManifest()[mediaId];
    if (entry != null && File(entry.encryptedPath).existsSync()) {
      final decrypted = await _ensureDecrypted(entry);
      if (decrypted != null) {
        return decrypted;
      }
    }
    if (ContentMediaStorageService.isPrivateRef(remoteUrl)) {
      final signed = await _storage.createSignedUrl(remoteUrl);
      if (signed != null) {
        return signed;
      }
    }
    return remoteUrl;
  }

  Future<String?> _ensureDecrypted(CachedContentMediaEntry entry) async {
    final cached = _decryptedPaths[entry.mediaId];
    if (cached != null && File(cached).existsSync()) {
      return cached;
    }
    try {
      final dir = await _decryptDir();
      final ext = _extensionFor(entry.mimeType, entry.remoteRef, entry.mediaType);
      final target = File('${dir.path}/${entry.mediaId}$ext');
      await _encryption.decryptFile(
        src: File(entry.encryptedPath),
        dst: target,
        nonce: _encryption.decodeNonce(entry.nonce),
      );
      _decryptedPaths[entry.mediaId] = target.path;
      _touch(entry.mediaId);
      return target.path;
    } catch (_) {
      return null;
    }
  }

  void _touch(String mediaId) {
    final manifest = _store.readManifest();
    final entry = manifest[mediaId];
    if (entry == null) {
      return;
    }
    manifest[mediaId] =
        entry.copyWith(lastAccessMs: DateTime.now().millisecondsSinceEpoch);
    // Fire-and-forget; ordering doesn't matter for an LRU timestamp.
    unawaited(_store.writeManifest(manifest));
  }

  Future<MediaDownloadJob> downloadMedia({
    required String mediaId,
    required String remoteUrl,
    required String topicId,
    required EducationalMediaType mediaType,
    void Function(double progress)? onProgress,
    CancelToken? cancelToken,
  }) async {
    if (!ContentMediaUrlRules.isCacheable(remoteUrl)) {
      return MediaDownloadJob(
        mediaId: mediaId,
        status: MediaDownloadStatus.skipped,
      );
    }

    final existing = _store.readManifest()[mediaId];
    if (existing != null &&
        existing.remoteRef == remoteUrl &&
        File(existing.encryptedPath).existsSync()) {
      return MediaDownloadJob(
        mediaId: mediaId,
        status: MediaDownloadStatus.completed,
        progress: 1,
      );
    }

    File? tempFile;
    try {
      final downloadUrl = await _resolveDownloadUrl(remoteUrl);
      if (downloadUrl == null) {
        return MediaDownloadJob(
          mediaId: mediaId,
          status: MediaDownloadStatus.failed,
          error: 'unresolved_url',
        );
      }

      final tempDir = await _decryptDir();
      tempFile = File(
        '${tempDir.path}/dl_${mediaId}_${DateTime.now().millisecondsSinceEpoch}.part',
      );

      final response = await _dio.download(
        downloadUrl,
        tempFile.path,
        cancelToken: cancelToken,
        options: Options(
          followRedirects: true,
          validateStatus: (status) => status != null && status < 400,
        ),
        onReceiveProgress: (received, total) {
          if (total > 0) {
            onProgress?.call((received / total).clamp(0.0, 1.0));
          }
        },
      );

      _validateDownload(response, tempFile);

      final size = await tempFile.length();
      await _ensureQuota(size, replacingMediaId: mediaId);

      final dir = await _encryptedDir();
      final encFile = File('${dir.path}/$mediaId.enc');
      final nonce = _encryption.newNonce();
      await _encryption.encryptFile(
        src: tempFile,
        dst: encFile,
        nonce: nonce,
      );

      final manifest = _store.readManifest();
      manifest[mediaId] = CachedContentMediaEntry(
        mediaId: mediaId,
        remoteRef: remoteUrl,
        encryptedPath: encFile.path,
        nonce: _encryption.encodeNonce(nonce),
        topicId: topicId,
        mediaType: mediaType.name,
        bytes: size,
        mimeType: _contentType(response),
        lastAccessMs: DateTime.now().millisecondsSinceEpoch,
        updatedAtMs: DateTime.now().millisecondsSinceEpoch,
      );
      await _store.writeManifest(manifest);

      // A previously decrypted copy is now stale.
      _decryptedPaths.remove(mediaId);

      return MediaDownloadJob(
        mediaId: mediaId,
        status: MediaDownloadStatus.completed,
        progress: 1,
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return MediaDownloadJob(
          mediaId: mediaId,
          status: MediaDownloadStatus.paused,
        );
      }
      return MediaDownloadJob(
        mediaId: mediaId,
        status: MediaDownloadStatus.failed,
        error: e.message,
      );
    } catch (e) {
      return MediaDownloadJob(
        mediaId: mediaId,
        status: MediaDownloadStatus.failed,
        error: e.toString(),
      );
    } finally {
      if (tempFile != null && tempFile.existsSync()) {
        try {
          await tempFile.delete();
        } catch (_) {
          // best-effort temp cleanup
        }
      }
    }
  }

  Future<String?> _resolveDownloadUrl(String remoteUrl) async {
    if (ContentMediaStorageService.isPrivateRef(remoteUrl)) {
      return _storage.createSignedUrl(remoteUrl);
    }
    return remoteUrl;
  }

  void _validateDownload(Response<dynamic> response, File file) {
    final contentType = _contentType(response)?.toLowerCase() ?? '';
    // Reject HTML error/landing pages masquerading as media (e.g. a Vimeo page).
    if (contentType.contains('text/html') ||
        contentType.contains('application/xhtml')) {
      throw const MediaCacheException('invalid_content_type');
    }
    final length = file.existsSync() ? file.lengthSync() : 0;
    if (length <= 0) {
      throw const MediaCacheException('empty_download');
    }
    if (length > _maxDownloadBytes) {
      throw const MediaCacheException('too_large');
    }
  }

  String? _contentType(Response<dynamic> response) {
    final value = response.headers.value(Headers.contentTypeHeader);
    return value?.split(';').first.trim();
  }

  /// Evicts least-recently-used entries until [incomingBytes] fits under the
  /// quota. Throws when a single item is larger than the whole quota.
  Future<void> _ensureQuota(
    int incomingBytes, {
    required String replacingMediaId,
  }) async {
    final quota = _store.quotaBytes;
    if (incomingBytes > quota) {
      throw const MediaCacheException('exceeds_quota');
    }
    final manifest = _store.readManifest();
    final previous = manifest[replacingMediaId]?.bytes ?? 0;
    var used = usageBytes - previous;

    if (used + incomingBytes <= quota) {
      return;
    }

    final candidates = manifest.values
        .where((e) => e.mediaId != replacingMediaId)
        .toList()
      ..sort((a, b) => a.lastAccessMs.compareTo(b.lastAccessMs));

    for (final entry in candidates) {
      if (used + incomingBytes <= quota) {
        break;
      }
      await _deleteEntryFiles(entry);
      manifest.remove(entry.mediaId);
      used -= entry.bytes;
    }
    await _store.writeManifest(manifest);
  }

  Future<void> _deleteEntryFiles(CachedContentMediaEntry entry) async {
    try {
      final enc = File(entry.encryptedPath);
      if (enc.existsSync()) {
        await enc.delete();
      }
    } catch (_) {
      // best-effort
    }
    final dec = _decryptedPaths.remove(entry.mediaId);
    if (dec != null) {
      try {
        final f = File(dec);
        if (f.existsSync()) {
          await f.delete();
        }
      } catch (_) {
        // best-effort
      }
    }
  }

  Future<void> removeMedia(String mediaId) async {
    final manifest = _store.readManifest();
    final entry = manifest.remove(mediaId);
    if (entry == null) {
      return;
    }
    await _deleteEntryFiles(entry);
    await _store.writeManifest(manifest);
  }

  Future<void> removeTopic(String topicId) async {
    final manifest = _store.readManifest();
    final toRemove =
        manifest.values.where((e) => e.topicId == topicId).toList();
    if (toRemove.isEmpty) {
      return;
    }
    for (final entry in toRemove) {
      await _deleteEntryFiles(entry);
      manifest.remove(entry.mediaId);
    }
    await _store.writeManifest(manifest);
  }

  /// Wipes all encrypted blobs, decrypted temp files and the manifest.
  Future<void> clearAll() async {
    final encDir = await _encryptedDir();
    if (encDir.existsSync()) {
      await encDir.delete(recursive: true);
    }
    await wipeDecryptTemp();
    await _store.clearManifest();
  }

  /// Deletes only the plaintext decrypt-temp files (e.g. on logout) without
  /// touching the encrypted store.
  Future<void> wipeDecryptTemp() async {
    _decryptedPaths.clear();
    try {
      final decDir = await _decryptDir();
      if (decDir.existsSync()) {
        await decDir.delete(recursive: true);
      }
    } catch (_) {
      // best-effort
    }
  }

  String _extensionFor(
    String? mimeType,
    String ref,
    String mediaType,
  ) {
    final mime = mimeType?.toLowerCase() ?? '';
    if (mime.contains('mp4')) return '.mp4';
    if (mime.contains('webm')) return '.webm';
    if (mime.contains('quicktime')) return '.mov';
    if (mime.contains('mpeg') && mediaType == 'audio') return '.mp3';
    if (mime.contains('aac')) return '.aac';
    if (mime.contains('wav')) return '.wav';
    if (mime.contains('ogg')) return '.ogg';
    if (mime.contains('png')) return '.png';
    if (mime.contains('webp')) return '.webp';
    if (mime.contains('gif')) return '.gif';
    if (mime.contains('jpeg') || mime.contains('jpg')) return '.jpg';
    if (mime.contains('pdf')) return '.pdf';

    final path = Uri.tryParse(ref)?.path ?? ref;
    final dot = path.lastIndexOf('.');
    if (dot != -1 && dot < path.length - 1) {
      final ext = path.substring(dot);
      if (ext.length <= 6 && !ext.contains('/')) {
        return ext;
      }
    }
    return switch (mediaType) {
      'audio' => '.mp3',
      'image' => '.jpg',
      'pdf' => '.pdf',
      _ => '.mp4',
    };
  }
}

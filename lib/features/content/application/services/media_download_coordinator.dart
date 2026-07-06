import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/features/content/application/services/media_content_url_rules.dart';
import 'package:rafiq_alhajj/features/content/application/services/media_playback_resolver.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_media_cache_store.dart';
import 'package:rafiq_alhajj/features/content/data/local/media_encryption_service.dart';
import 'package:rafiq_alhajj/features/content/data/storage/content_media_storage_service.dart';
import 'package:rafiq_alhajj/features/content/domain/models/media_download_state.dart';

/// Result of reconciling the offline manifest against encrypted blobs on disk.
class ManifestReconcileResult {
  const ManifestReconcileResult({
    this.removedManifestEntries = 0,
    this.removedOrphanFiles = 0,
  });

  final int removedManifestEntries;
  final int removedOrphanFiles;

  bool get changed => removedManifestEntries > 0 || removedOrphanFiles > 0;
}

/// Downloads, validates, encrypts, and evicts offline media blobs.
class MediaDownloadCoordinator {
  MediaDownloadCoordinator({
    required ContentMediaCacheStore store,
    required MediaEncryptionService encryption,
    required ContentMediaStorageService storage,
    required MediaPlaybackResolver playback,
    required Dio dio,
    required Future<Directory> Function() encryptedDir,
    required Future<Directory> Function() decryptDir,
  })  : _store = store,
        _encryption = encryption,
        _storage = storage,
        _playback = playback,
        _dio = dio,
        _encryptedDir = encryptedDir,
        _decryptDir = decryptDir;

  /// Reject downloads whose body exceeds this hard cap (bucket limit is 50 MiB;
  /// allow a little headroom). Guards against a misbehaving server / wrong URL.
  static const maxDownloadBytes = 60 * 1024 * 1024;

  final ContentMediaCacheStore _store;
  final MediaEncryptionService _encryption;
  final ContentMediaStorageService _storage;
  final MediaPlaybackResolver _playback;
  final Dio _dio;
  final Future<Directory> Function() _encryptedDir;
  final Future<Directory> Function() _decryptDir;

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

      validateDownload(response, tempFile);

      final size = await tempFile.length();
      await ensureQuota(size, replacingMediaId: mediaId);

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
        mimeType: downloadContentType(response),
        lastAccessMs: DateTime.now().millisecondsSinceEpoch,
        updatedAtMs: DateTime.now().millisecondsSinceEpoch,
      );
      await _store.writeManifest(manifest);

      // A previously decrypted copy is now stale.
      _playback.removeDecryptedPath(mediaId);

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

  /// Best-effort HEAD request to estimate download size before enqueueing.
  Future<int?> estimateDownloadBytes(String remoteUrl) async {
    if (!ContentMediaUrlRules.isCacheable(remoteUrl)) {
      return null;
    }
    try {
      final downloadUrl = await _resolveDownloadUrl(remoteUrl);
      if (downloadUrl == null) {
        return null;
      }
      final response = await _dio.head<void>(
        downloadUrl,
        options: Options(
          followRedirects: true,
          validateStatus: (status) => status != null && status < 400,
        ),
      );
      final length = response.headers.value(Headers.contentLengthHeader);
      if (length == null) {
        return null;
      }
      return int.tryParse(length);
    } catch (_) {
      return null;
    }
  }

  /// Drops manifest rows whose encrypted blobs are missing and deletes orphan
  /// `.enc` files that are no longer referenced.
  Future<ManifestReconcileResult> reconcileManifest() async {
    final manifest = _store.readManifest();
    var removedManifestEntries = 0;
    var removedOrphanFiles = 0;

    final staleIds = <String>[];
    for (final entry in manifest.values) {
      if (!File(entry.encryptedPath).existsSync()) {
        staleIds.add(entry.mediaId);
      }
    }
    for (final mediaId in staleIds) {
      manifest.remove(mediaId);
      await _playback.deleteDecryptedFile(mediaId);
      removedManifestEntries++;
    }
    if (staleIds.isNotEmpty) {
      await _store.writeManifest(manifest);
    }

    final encDir = await _encryptedDir();
    if (encDir.existsSync()) {
      final referenced = manifest.values
          .map((e) => File(e.encryptedPath).path)
          .toSet();
      await for (final entity in encDir.list()) {
        if (entity is! File || !entity.path.endsWith('.enc')) {
          continue;
        }
        if (!referenced.contains(entity.path)) {
          try {
            await entity.delete();
            removedOrphanFiles++;
          } catch (_) {
            // best-effort
          }
        }
      }
    }

    return ManifestReconcileResult(
      removedManifestEntries: removedManifestEntries,
      removedOrphanFiles: removedOrphanFiles,
    );
  }

  Future<void> removeMedia(String mediaId) async {
    final manifest = _store.readManifest();
    final entry = manifest.remove(mediaId);
    if (entry == null) {
      return;
    }
    await deleteEntryFiles(entry);
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
      await deleteEntryFiles(entry);
      manifest.remove(entry.mediaId);
    }
    await _store.writeManifest(manifest);
  }

  Future<void> clearEncryptedStore() async {
    final encDir = await _encryptedDir();
    if (encDir.existsSync()) {
      await encDir.delete(recursive: true);
    }
    await _store.clearManifest();
  }

  Future<String?> _resolveDownloadUrl(String remoteUrl) async {
    if (ContentMediaStorageService.isPrivateRef(remoteUrl)) {
      return _storage.createSignedUrl(remoteUrl);
    }
    return remoteUrl;
  }

  /// Evicts least-recently-used entries until [incomingBytes] fits under the
  /// quota. Throws when a single item is larger than the whole quota.
  Future<void> ensureQuota(
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
      await deleteEntryFiles(entry);
      manifest.remove(entry.mediaId);
      used -= entry.bytes;
    }
    await _store.writeManifest(manifest);
  }

  int get usageBytes {
    var total = 0;
    for (final entry in _store.readManifest().values) {
      total += entry.bytes;
    }
    return total;
  }

  Future<void> deleteEntryFiles(CachedContentMediaEntry entry) async {
    try {
      final enc = File(entry.encryptedPath);
      if (enc.existsSync()) {
        await enc.delete();
      }
    } catch (_) {
      // best-effort
    }
    await _playback.deleteDecryptedFile(entry.mediaId);
  }
}

/// Validates a completed HTTP download before encryption.
void validateDownload(Response<dynamic> response, File file) {
  final contentType = downloadContentType(response)?.toLowerCase() ?? '';
  // Reject HTML error/landing pages masquerading as media (e.g. a Vimeo page).
  if (contentType.contains('text/html') ||
      contentType.contains('application/xhtml')) {
    throw const MediaCacheException('invalid_content_type');
  }
  final length = file.existsSync() ? file.lengthSync() : 0;
  if (length <= 0) {
    throw const MediaCacheException('empty_download');
  }
  if (length > MediaDownloadCoordinator.maxDownloadBytes) {
    throw const MediaCacheException('too_large');
  }
}

String? downloadContentType(Response<dynamic> response) {
  final value = response.headers.value(Headers.contentTypeHeader);
  return value?.split(';').first.trim();
}

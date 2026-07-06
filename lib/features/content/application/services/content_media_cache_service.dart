import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/features/content/application/services/media_download_coordinator.dart';
import 'package:rafiq_alhajj/features/content/application/services/media_playback_resolver.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_media_cache_store.dart';
import 'package:rafiq_alhajj/features/content/data/local/media_encryption_service.dart';
import 'package:rafiq_alhajj/features/content/data/storage/content_media_storage_service.dart';
import 'package:rafiq_alhajj/features/content/domain/models/media_download_state.dart';

export 'package:rafiq_alhajj/features/content/application/services/media_content_url_rules.dart';
export 'package:rafiq_alhajj/features/content/application/services/media_download_coordinator.dart';
export 'package:rafiq_alhajj/features/content/domain/models/media_download_state.dart';

/// Thin facade over offline media playback resolution and download coordination.
class ContentMediaCacheService {
  ContentMediaCacheService(
    this._store,
    MediaEncryptionService encryption,
    ContentMediaStorageService storage, {
    required Dio dio,
  }) {
    final profileKey = _store.profileKey;
    _playback = MediaPlaybackResolver(
      store: _store,
      encryption: encryption,
      storage: storage,
      decryptDir: () => _decryptDirFor(profileKey),
    );
    _downloads = MediaDownloadCoordinator(
      store: _store,
      encryption: encryption,
      storage: storage,
      playback: _playback,
      dio: dio,
      encryptedDir: () => _encryptedDirFor(profileKey),
      decryptDir: () => _decryptDirFor(profileKey),
    );
  }

  final ContentMediaCacheStore _store;
  late final MediaPlaybackResolver _playback;
  late final MediaDownloadCoordinator _downloads;

  static Future<Directory> _encryptedDirFor(String profileSuffix) async {
    final base = await getApplicationSupportDirectory();
    final dir = Directory('${base.path}/content_media_enc_$profileSuffix');
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  static Future<Directory> _decryptDirFor(String profileSuffix) async {
    final base = await getTemporaryDirectory();
    final dir = Directory('${base.path}/content_media_dec_$profileSuffix');
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

  int get usageBytes => _downloads.usageBytes;

  bool isCached(String mediaId) {
    final entry = _store.readManifest()[mediaId];
    return entry != null && File(entry.encryptedPath).existsSync();
  }

  Future<String> resolvePlaybackUrl({
    required String mediaId,
    required String remoteUrl,
  }) =>
      _playback.resolvePlaybackUrl(mediaId: mediaId, remoteUrl: remoteUrl);

  Future<MediaDownloadJob> downloadMedia({
    required String mediaId,
    required String remoteUrl,
    required String topicId,
    required EducationalMediaType mediaType,
    void Function(double progress)? onProgress,
    CancelToken? cancelToken,
  }) =>
      _downloads.downloadMedia(
        mediaId: mediaId,
        remoteUrl: remoteUrl,
        topicId: topicId,
        mediaType: mediaType,
        onProgress: onProgress,
        cancelToken: cancelToken,
      );

  Future<void> removeMedia(String mediaId) => _downloads.removeMedia(mediaId);

  Future<void> removeTopic(String topicId) => _downloads.removeTopic(topicId);

  /// Wipes all encrypted blobs, decrypted temp files and the manifest.
  Future<void> clearAll() async {
    await _downloads.clearEncryptedStore();
    await wipeDecryptTemp();
  }

  /// Deletes only the plaintext decrypt-temp files (e.g. on logout) without
  /// touching the encrypted store.
  Future<void> wipeDecryptTemp() => _playback.wipeDecryptTemp();

  Future<int?> estimateDownloadBytes(String remoteUrl) =>
      _downloads.estimateDownloadBytes(remoteUrl);

  /// Reconciles manifest rows with encrypted blobs on disk (app resume / boot).
  Future<ManifestReconcileResult> reconcileManifest() =>
      _downloads.reconcileManifest();
}

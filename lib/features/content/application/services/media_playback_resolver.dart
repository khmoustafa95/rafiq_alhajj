import 'dart:async';
import 'dart:io';
import 'package:rafiq_alhajj/features/content/application/services/media_content_url_rules.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_media_cache_store.dart';
import 'package:rafiq_alhajj/features/content/data/local/media_encryption_service.dart';
import 'package:rafiq_alhajj/features/content/data/storage/content_media_storage_service.dart';

/// Resolves offline/online playback URLs and manages decrypt-temp files.
class MediaPlaybackResolver {
  MediaPlaybackResolver({
    required ContentMediaCacheStore store,
    required MediaEncryptionService encryption,
    required ContentMediaStorageService storage,
    required Future<Directory> Function() decryptDir,
    Map<String, String>? decryptedPaths,
  })  : _store = store,
        _encryption = encryption,
        _storage = storage,
        _decryptDir = decryptDir,
        _decryptedPaths = decryptedPaths ?? {};

  final ContentMediaCacheStore _store;
  final MediaEncryptionService _encryption;
  final ContentMediaStorageService _storage;
  final Future<Directory> Function() _decryptDir;
  final Map<String, String> _decryptedPaths;

  Map<String, String> get decryptedPaths => _decryptedPaths;

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
      final decrypted = await ensureDecrypted(entry);
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

  Future<String?> ensureDecrypted(CachedContentMediaEntry entry) async {
    final cached = _decryptedPaths[entry.mediaId];
    if (cached != null && File(cached).existsSync()) {
      return cached;
    }
    try {
      final dir = await _decryptDir();
      final ext = MediaFileNaming.extensionFor(
        mimeType: entry.mimeType,
        ref: entry.remoteRef,
        mediaType: entry.mediaType,
      );
      final target = File('${dir.path}/${entry.mediaId}$ext');
      await _encryption.decryptFile(
        src: File(entry.encryptedPath),
        dst: target,
        nonce: _encryption.decodeNonce(entry.nonce),
      );
      _decryptedPaths[entry.mediaId] = target.path;
      touch(entry.mediaId);
      return target.path;
    } catch (_) {
      return null;
    }
  }

  void touch(String mediaId) {
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

  void removeDecryptedPath(String mediaId) {
    _decryptedPaths.remove(mediaId);
  }

  void clearDecryptedPaths() {
    _decryptedPaths.clear();
  }

  Future<void> deleteDecryptedFile(String mediaId) async {
    final dec = _decryptedPaths.remove(mediaId);
    if (dec == null) {
      return;
    }
    try {
      final file = File(dec);
      if (file.existsSync()) {
        await file.delete();
      }
    } catch (_) {
      // best-effort
    }
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
}

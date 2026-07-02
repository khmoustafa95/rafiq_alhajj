import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// A single encrypted-at-rest offline media entry.
class CachedContentMediaEntry {
  const CachedContentMediaEntry({
    required this.mediaId,
    required this.remoteRef,
    required this.encryptedPath,
    required this.nonce,
    required this.topicId,
    required this.mediaType,
    required this.bytes,
    required this.lastAccessMs,
    required this.updatedAtMs,
    this.mimeType,
  });

  final String mediaId;

  /// The original DB ref (`https://...` or `private://...`). Used to detect
  /// content changes and to re-resolve a signed URL when the local copy is gone.
  final String remoteRef;

  /// Absolute path of the encrypted blob in the (backup-excluded) support dir.
  final String encryptedPath;

  /// Base64 AES-CTR nonce for [encryptedPath].
  final String nonce;
  final String topicId;
  final String mediaType;

  /// Encrypted blob size on disk (== plaintext size for AES-CTR).
  final int bytes;
  final String? mimeType;
  final int lastAccessMs;
  final int updatedAtMs;

  CachedContentMediaEntry copyWith({
    String? remoteRef,
    int? lastAccessMs,
  }) {
    return CachedContentMediaEntry(
      mediaId: mediaId,
      remoteRef: remoteRef ?? this.remoteRef,
      encryptedPath: encryptedPath,
      nonce: nonce,
      topicId: topicId,
      mediaType: mediaType,
      bytes: bytes,
      mimeType: mimeType,
      lastAccessMs: lastAccessMs ?? this.lastAccessMs,
      updatedAtMs: updatedAtMs,
    );
  }

  Map<String, dynamic> toJson() => {
        'mediaId': mediaId,
        'remoteRef': remoteRef,
        'encryptedPath': encryptedPath,
        'nonce': nonce,
        'topicId': topicId,
        'mediaType': mediaType,
        'bytes': bytes,
        'mimeType': mimeType,
        'lastAccessMs': lastAccessMs,
        'updatedAtMs': updatedAtMs,
      };

  static CachedContentMediaEntry? fromJson(Map<String, dynamic> json) {
    final mediaId = json['mediaId'] as String?;
    final encryptedPath = json['encryptedPath'] as String?;
    final nonce = json['nonce'] as String?;
    if (mediaId == null || encryptedPath == null || nonce == null) {
      return null;
    }
    return CachedContentMediaEntry(
      mediaId: mediaId,
      remoteRef: json['remoteRef'] as String? ?? '',
      encryptedPath: encryptedPath,
      nonce: nonce,
      topicId: json['topicId'] as String? ?? '',
      mediaType: json['mediaType'] as String? ?? '',
      bytes: json['bytes'] as int? ?? 0,
      mimeType: json['mimeType'] as String?,
      lastAccessMs: json['lastAccessMs'] as int? ?? 0,
      updatedAtMs: json['updatedAtMs'] as int? ?? 0,
    );
  }
}

class ContentMediaCacheStore {
  ContentMediaCacheStore(this._prefs, {this.profileKey = 'guest'});

  static const _manifestPrefix = 'content_media_cache_manifest_v2_';
  static const _offlineEnabledPrefix = 'content_offline_enabled_v1_';
  static const _wifiOnlyPrefix = 'content_offline_wifi_only_v1_';
  static const _quotaBytesPrefix = 'content_offline_quota_bytes_v1_';

  /// Per-profile namespace so downloads survive sign-out / re-login.
  final String profileKey;

  /// Default storage cap for offline media: 1 GiB.
  static const defaultQuotaBytes = 1024 * 1024 * 1024;

  final SharedPreferences _prefs;

  String get _manifestKey => '$_manifestPrefix$profileKey';
  String get _offlineEnabledKey => '$_offlineEnabledPrefix$profileKey';
  String get _wifiOnlyKey => '$_wifiOnlyPrefix$profileKey';
  String get _quotaBytesKey => '$_quotaBytesPrefix$profileKey';

  bool get offlineEnabled => _prefs.getBool(_offlineEnabledKey) ?? false;

  Future<void> setOfflineEnabled(bool value) =>
      _prefs.setBool(_offlineEnabledKey, value);

  /// Whether downloads should only run on Wi-Fi/ethernet. Defaults to true to
  /// protect pilgrims' mobile data (Coursera-style).
  bool get wifiOnly => _prefs.getBool(_wifiOnlyKey) ?? true;

  Future<void> setWifiOnly(bool value) => _prefs.setBool(_wifiOnlyKey, value);

  int get quotaBytes => _prefs.getInt(_quotaBytesKey) ?? defaultQuotaBytes;

  Future<void> setQuotaBytes(int value) =>
      _prefs.setInt(_quotaBytesKey, value);

  Map<String, CachedContentMediaEntry> readManifest() {
    final raw = _prefs.getString(_manifestKey);
    if (raw == null || raw.isEmpty) {
      return {};
    }
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final entries = <String, CachedContentMediaEntry>{};
      for (final entry in decoded.entries) {
        final value = CachedContentMediaEntry.fromJson(
          Map<String, dynamic>.from(entry.value as Map),
        );
        if (value != null) {
          entries[entry.key] = value;
        }
      }
      return entries;
    } catch (_) {
      return {};
    }
  }

  Future<void> writeManifest(Map<String, CachedContentMediaEntry> manifest) {
    final encoded = jsonEncode(
      manifest.map((key, value) => MapEntry(key, value.toJson())),
    );
    return _prefs.setString(_manifestKey, encoded);
  }

  Future<void> clearManifest() => _prefs.remove(_manifestKey);
}

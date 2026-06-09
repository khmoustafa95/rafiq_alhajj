import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CachedContentMediaEntry {
  const CachedContentMediaEntry({
    required this.mediaId,
    required this.remoteUrl,
    required this.localPath,
    required this.topicId,
    required this.mediaType,
    required this.updatedAtMs,
  });

  final String mediaId;
  final String remoteUrl;
  final String localPath;
  final String topicId;
  final String mediaType;
  final int updatedAtMs;

  Map<String, dynamic> toJson() => {
        'mediaId': mediaId,
        'remoteUrl': remoteUrl,
        'localPath': localPath,
        'topicId': topicId,
        'mediaType': mediaType,
        'updatedAtMs': updatedAtMs,
      };

  static CachedContentMediaEntry? fromJson(Map<String, dynamic> json) {
    final mediaId = json['mediaId'] as String?;
    final localPath = json['localPath'] as String?;
    if (mediaId == null || localPath == null) {
      return null;
    }
    return CachedContentMediaEntry(
      mediaId: mediaId,
      remoteUrl: json['remoteUrl'] as String? ?? '',
      localPath: localPath,
      topicId: json['topicId'] as String? ?? '',
      mediaType: json['mediaType'] as String? ?? '',
      updatedAtMs: json['updatedAtMs'] as int? ?? 0,
    );
  }
}

class ContentMediaCacheStore {
  ContentMediaCacheStore(this._prefs);

  static const _manifestKey = 'content_media_cache_manifest_v1';
  static const _offlineEnabledKey = 'content_offline_enabled_v1';

  final SharedPreferences _prefs;

  bool get offlineEnabled => _prefs.getBool(_offlineEnabledKey) ?? false;

  Future<void> setOfflineEnabled(bool value) async {
    await _prefs.setBool(_offlineEnabledKey, value);
  }

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

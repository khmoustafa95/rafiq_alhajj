import 'dart:convert';

import 'package:rafiq_alhajj/features/content/domain/models/content_media_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class ContentMediaProgressCache {
  static String _key(String profileKey) =>
      'content_media_progress_v1_$profileKey';

  static Future<ContentMediaProgress?> readLatest(String profileKey) async {
    final all = await readAll(profileKey);
    if (all.isEmpty) {
      return null;
    }
    all.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    final latest = all.first;
    if (latest.completed) {
      return null;
    }
    return latest;
  }

  static Future<List<ContentMediaProgress>> readAll(String profileKey) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key(profileKey));
    if (raw == null) {
      return [];
    }
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return decoded.values
          .map(
            (v) => ContentMediaProgress.fromJson(
              Map<String, dynamic>.from(v as Map),
            ),
          )
          .whereType<ContentMediaProgress>()
          .toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> save(
    String profileKey,
    ContentMediaProgress progress,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key(profileKey));
    final map = <String, dynamic>{};
    if (raw != null) {
      try {
        map.addAll(Map<String, dynamic>.from(jsonDecode(raw) as Map));
      } catch (_) {
        // reset corrupt store
      }
    }
    map[progress.mediaId] = progress.toJson();
    await prefs.setString(_key(profileKey), jsonEncode(map));
  }
}

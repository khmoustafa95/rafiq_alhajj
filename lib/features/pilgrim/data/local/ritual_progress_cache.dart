import 'dart:convert';

import 'package:rafiq_alhajj/features/pilgrim/domain/models/ritual_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class RitualProgressCache {
  static String _key(String userId) => 'ritual_progress_$userId';

  static Future<Map<String, RitualProgress>> read(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key(userId));
    if (raw == null) {
      return {};
    }

    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map(
      (key, value) => MapEntry(
        key,
        RitualProgress.fromJson(Map<String, dynamic>.from(value as Map)),
      ),
    );
  }

  static Future<void> write(
    String userId,
    Map<String, RitualProgress> progress,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = progress.map(
      (key, value) => MapEntry(key, value.toJson()),
    );
    await prefs.setString(_key(userId), jsonEncode(encoded));
  }
}

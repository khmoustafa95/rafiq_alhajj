import 'package:shared_preferences/shared_preferences.dart';

/// Remembers which optional [latest_version] the user dismissed per platform.
class OptionalUpdateDismissStore {
  const OptionalUpdateDismissStore();

  static const _keyPrefix = 'optional_update_dismissed_';

  Future<bool> wasDismissed(String platform, String latestVersion) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('$_keyPrefix$platform') == latestVersion;
  }

  Future<void> dismiss(String platform, String latestVersion) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_keyPrefix$platform', latestVersion);
  }
}

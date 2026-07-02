import 'package:shared_preferences/shared_preferences.dart';

abstract final class ContentWifiOnboardingPrefs {
  static const _key = 'content_wifi_onboarding_shown_v1';

  static Future<bool> wasShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  static Future<void> markShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }
}

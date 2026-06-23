import 'package:shared_preferences/shared_preferences.dart';

/// Persists when a guest last opened the notifications inbox, so the bell badge
/// can show *unread* announcements (items newer than this) instead of the total.
///
/// Guests have no per-user `read_at` state in Supabase, so "unread" is derived
/// locally from this timestamp.
class GuestNotificationsSeenStore {
  const GuestNotificationsSeenStore();

  static const String _key = 'guest_notifications_last_seen';

  Future<DateTime?> lastSeen() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    return DateTime.tryParse(raw);
  }

  Future<void> markSeen([DateTime? at]) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key,
      (at ?? DateTime.now()).toUtc().toIso8601String(),
    );
  }
}

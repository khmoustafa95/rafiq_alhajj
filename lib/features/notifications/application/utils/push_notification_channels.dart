/// Android notification channel IDs (OS-level category controls).
abstract final class PushNotificationChannels {
  static const String announcements = 'rafiq_announcements';
  static const String content = 'rafiq_content';
  static const String competitions = 'rafiq_competitions';
  static const String urgent = 'rafiq_urgent';

  /// Maps a Supabase `notifications.type` value to a channel id.
  static String forType(String? type) {
    switch (type) {
      case 'announcement':
        return announcements;
      case 'content_published':
        return content;
      case 'competition':
        return competitions;
      case 'ritual_update':
      case 'system':
        return urgent;
      default:
        return announcements;
    }
  }
}

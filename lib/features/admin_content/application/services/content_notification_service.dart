import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Opt-in publisher for content notifications. Wraps the admin-guarded
/// `publish_content_notification` RPC which inserts `content_published`
/// notifications for eligible pilgrims (the DB push-dispatch trigger then fans
/// them out to FCM).
class ContentNotificationService {
  const ContentNotificationService(this._client);

  final SupabaseClient? _client;

  /// Notifies eligible pilgrims about a created/updated content item or topic.
  /// [route] is `content` (feed item) or `contentTopic` (library topic).
  /// Best-effort: failures are swallowed so they never block a successful save.
  Future<void> publish({
    required String title,
    required String route,
    required String id,
    required ContentVisibility visibility,
  }) async {
    final client = _client;
    if (client == null) {
      return;
    }
    try {
      await client.rpc<dynamic>(
        'publish_content_notification',
        params: {
          'p_title_ar': title,
          'p_title_en': title,
          'p_route': route,
          'p_id': id,
          'p_visibility': visibility.databaseValue,
        },
      );
    } on PostgrestException {
      // best-effort: an admin can re-trigger from the editor if needed.
    } on AuthException {
      // best-effort
    }
  }
}

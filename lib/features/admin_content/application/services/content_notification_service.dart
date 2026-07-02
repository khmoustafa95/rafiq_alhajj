import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/admin_content/data/data_sources/content_notification_remote_data_source.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Opt-in publisher for content notifications. Wraps the admin-guarded
/// `publish_content_notification` RPC which inserts `content_published`
/// notifications for eligible pilgrims (the DB push-dispatch trigger then fans
/// them out to FCM).
class ContentNotificationService {
  ContentNotificationService([SupabaseClient? client])
      : _remote = AppConfig.hasSupabase && client != null
            ? ContentNotificationRemoteDataSource(client)
            : null;

  final ContentNotificationRemoteDataSource? _remote;

  /// Notifies eligible pilgrims about a created/updated content item or topic.
  /// [route] is `content` (feed item) or `contentTopic` (library topic).
  /// Best-effort: failures are swallowed so they never block a successful save.
  Future<void> publish({
    required String title,
    required String route,
    required String id,
    required ContentVisibility visibility,
  }) async {
    final remote = _remote;
    if (remote == null) {
      return;
    }
    try {
      await remote.publishContentNotification(
        titleAr: title,
        titleEn: title,
        route: route,
        id: id,
        visibility: visibility.databaseValue,
      );
    } on PostgrestException {
      // best-effort: an admin can re-trigger from the editor if needed.
    } on AuthException {
      // best-effort
    }
  }
}

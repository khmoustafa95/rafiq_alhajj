import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase RPC access for opt-in content publish notifications.
class ContentNotificationRemoteDataSource {
  const ContentNotificationRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<void> publishContentNotification({
    required String titleAr,
    required String titleEn,
    required String route,
    required String id,
    required String visibility,
  }) {
    return _client.rpc<dynamic>(
      'publish_content_notification',
      params: {
        'p_title_ar': titleAr,
        'p_title_en': titleEn,
        'p_route': route,
        'p_id': id,
        'p_visibility': visibility,
      },
    );
  }
}

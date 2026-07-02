import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for `notification_preferences`.
class NotificationPreferencesRemoteDataSource {
  const NotificationPreferencesRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const _table = 'notification_preferences';

  Future<Map<String, dynamic>?> fetchRow(String profileId) async {
    final row = await _client
        .from(_table)
        .select()
        .eq('profile_id', profileId)
        .maybeSingle();
    return row;
  }

  Future<void> upsert({
    required String profileId,
    required bool pushEnabled,
    required bool pushAnnouncements,
    required bool pushContent,
    required bool pushCompetitions,
    required bool pushUrgent,
  }) async {
    await _client.from(_table).upsert(
      {
        'profile_id': profileId,
        'push_enabled': pushEnabled,
        'push_announcements': pushAnnouncements,
        'push_content': pushContent,
        'push_competitions': pushCompetitions,
        'push_urgent': pushUrgent,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      },
      onConflict: 'profile_id',
    );
  }
}

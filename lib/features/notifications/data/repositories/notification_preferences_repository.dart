import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/notifications/data/data_sources/notification_preferences_remote_data_source.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationPreferencesException implements Exception {
  const NotificationPreferencesException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Notification preferences request failed';
}

class NotificationPreferencesRepository {
  NotificationPreferencesRepository([SupabaseClient? client])
      : _remote = (AppConfig.hasSupabase && client != null)
            ? NotificationPreferencesRemoteDataSource(client)
            : null;

  final NotificationPreferencesRemoteDataSource? _remote;

  bool get isAvailable => _remote != null;

  Future<NotificationPreferences> fetch(String profileId) async {
    final remote = _remote;
    if (remote == null) {
      return NotificationPreferences.defaults();
    }

    try {
      final row = await remote.fetchRow(profileId);
      if (row == null) {
        return NotificationPreferences.defaults();
      }
      return _mapRow(row);
    } on PostgrestException catch (e) {
      throw NotificationPreferencesException(e.message);
    }
  }

  Future<void> save({
    required String profileId,
    required NotificationPreferences preferences,
  }) async {
    final remote = _remote;
    if (remote == null) {
      return;
    }

    try {
      await remote.upsert(
        profileId: profileId,
        pushEnabled: preferences.pushEnabled,
        pushAnnouncements: preferences.pushAnnouncements,
        pushContent: preferences.pushContent,
        pushCompetitions: preferences.pushCompetitions,
        pushUrgent: preferences.pushUrgent,
      );
    } on PostgrestException catch (e) {
      throw NotificationPreferencesException(e.message);
    }
  }

  NotificationPreferences _mapRow(Map<String, dynamic> row) {
    return NotificationPreferences(
      pushEnabled: row['push_enabled'] as bool? ?? true,
      pushAnnouncements: row['push_announcements'] as bool? ?? true,
      pushContent: row['push_content'] as bool? ?? true,
      pushCompetitions: row['push_competitions'] as bool? ?? true,
      pushUrgent: row['push_urgent'] as bool? ?? true,
    );
  }
}

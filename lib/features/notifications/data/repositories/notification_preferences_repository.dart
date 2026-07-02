import 'package:flutter/material.dart';
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

    final withTimezone = preferences.withCurrentTimezoneOffset();

    try {
      await remote.upsert(
        profileId: profileId,
        pushEnabled: withTimezone.pushEnabled,
        pushAnnouncements: withTimezone.pushAnnouncements,
        pushContent: withTimezone.pushContent,
        pushCompetitions: withTimezone.pushCompetitions,
        pushUrgent: withTimezone.pushUrgent,
        quietHoursEnabled: withTimezone.quietHoursEnabled,
        quietHoursStart: _formatTime(withTimezone.quietHoursStart),
        quietHoursEnd: _formatTime(withTimezone.quietHoursEnd),
        timezoneOffsetMinutes: withTimezone.timezoneOffsetMinutes,
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
      quietHoursEnabled: row['quiet_hours_enabled'] as bool? ?? false,
      quietHoursStart: _parseTime(row['quiet_hours_start'] as String?),
      quietHoursEnd: _parseTime(row['quiet_hours_end'] as String?),
      timezoneOffsetMinutes: row['timezone_offset_minutes'] as int?,
    );
  }

  static String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00';
  }

  static TimeOfDay _parseTime(String? raw) {
    if (raw == null || raw.isEmpty) {
      return const TimeOfDay(hour: 22, minute: 0);
    }
    final parts = raw.split(':');
    if (parts.length < 2) {
      return const TimeOfDay(hour: 22, minute: 0);
    }
    final hour = int.tryParse(parts[0]) ?? 22;
    final minute = int.tryParse(parts[1]) ?? 0;
    return TimeOfDay(hour: hour.clamp(0, 23), minute: minute.clamp(0, 59));
  }
}

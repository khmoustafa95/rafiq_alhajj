import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_preferences.freezed.dart';

/// Per-user push notification category preferences (stored in Supabase).
@freezed
abstract class NotificationPreferences with _$NotificationPreferences {
  const factory NotificationPreferences({
    @Default(true) bool pushEnabled,
    @Default(true) bool pushAnnouncements,
    @Default(true) bool pushContent,
    @Default(true) bool pushCompetitions,
    @Default(true) bool pushUrgent,
    @Default(false) bool quietHoursEnabled,
    @Default(TimeOfDay(hour: 22, minute: 0)) TimeOfDay quietHoursStart,
    @Default(TimeOfDay(hour: 7, minute: 0)) TimeOfDay quietHoursEnd,
    int? timezoneOffsetMinutes,
  }) = _NotificationPreferences;

  const NotificationPreferences._();

  factory NotificationPreferences.defaults() => const NotificationPreferences();

  /// Current device offset for quiet-hours evaluation on the server.
  NotificationPreferences withCurrentTimezoneOffset() {
    return copyWith(
      timezoneOffsetMinutes: DateTime.now().timeZoneOffset.inMinutes,
    );
  }
}

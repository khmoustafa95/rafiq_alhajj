import 'package:flutter/material.dart';

/// Per-user push notification category preferences (stored in Supabase).
class NotificationPreferences {
  const NotificationPreferences({
    required this.pushEnabled,
    required this.pushAnnouncements,
    required this.pushContent,
    required this.pushCompetitions,
    required this.pushUrgent,
    required this.quietHoursEnabled,
    required this.quietHoursStart,
    required this.quietHoursEnd,
    this.timezoneOffsetMinutes,
  });

  factory NotificationPreferences.defaults() {
    return const NotificationPreferences(
      pushEnabled: true,
      pushAnnouncements: true,
      pushContent: true,
      pushCompetitions: true,
      pushUrgent: true,
      quietHoursEnabled: false,
      quietHoursStart: TimeOfDay(hour: 22, minute: 0),
      quietHoursEnd: TimeOfDay(hour: 7, minute: 0),
    );
  }

  final bool pushEnabled;
  final bool pushAnnouncements;
  final bool pushContent;
  final bool pushCompetitions;
  final bool pushUrgent;
  final bool quietHoursEnabled;
  final TimeOfDay quietHoursStart;
  final TimeOfDay quietHoursEnd;
  final int? timezoneOffsetMinutes;

  NotificationPreferences copyWith({
    bool? pushEnabled,
    bool? pushAnnouncements,
    bool? pushContent,
    bool? pushCompetitions,
    bool? pushUrgent,
    bool? quietHoursEnabled,
    TimeOfDay? quietHoursStart,
    TimeOfDay? quietHoursEnd,
    int? timezoneOffsetMinutes,
  }) {
    return NotificationPreferences(
      pushEnabled: pushEnabled ?? this.pushEnabled,
      pushAnnouncements: pushAnnouncements ?? this.pushAnnouncements,
      pushContent: pushContent ?? this.pushContent,
      pushCompetitions: pushCompetitions ?? this.pushCompetitions,
      pushUrgent: pushUrgent ?? this.pushUrgent,
      quietHoursEnabled: quietHoursEnabled ?? this.quietHoursEnabled,
      quietHoursStart: quietHoursStart ?? this.quietHoursStart,
      quietHoursEnd: quietHoursEnd ?? this.quietHoursEnd,
      timezoneOffsetMinutes:
          timezoneOffsetMinutes ?? this.timezoneOffsetMinutes,
    );
  }

  /// Current device offset for quiet-hours evaluation on the server.
  NotificationPreferences withCurrentTimezoneOffset() {
    return copyWith(
      timezoneOffsetMinutes: DateTime.now().timeZoneOffset.inMinutes,
    );
  }
}

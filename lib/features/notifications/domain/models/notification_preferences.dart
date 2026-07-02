/// Per-user push notification category preferences (stored in Supabase).
class NotificationPreferences {
  const NotificationPreferences({
    required this.pushEnabled,
    required this.pushAnnouncements,
    required this.pushContent,
    required this.pushCompetitions,
    required this.pushUrgent,
  });

  factory NotificationPreferences.defaults() {
    return const NotificationPreferences(
      pushEnabled: true,
      pushAnnouncements: true,
      pushContent: true,
      pushCompetitions: true,
      pushUrgent: true,
    );
  }

  final bool pushEnabled;
  final bool pushAnnouncements;
  final bool pushContent;
  final bool pushCompetitions;
  final bool pushUrgent;

  NotificationPreferences copyWith({
    bool? pushEnabled,
    bool? pushAnnouncements,
    bool? pushContent,
    bool? pushCompetitions,
    bool? pushUrgent,
  }) {
    return NotificationPreferences(
      pushEnabled: pushEnabled ?? this.pushEnabled,
      pushAnnouncements: pushAnnouncements ?? this.pushAnnouncements,
      pushContent: pushContent ?? this.pushContent,
      pushCompetitions: pushCompetitions ?? this.pushCompetitions,
      pushUrgent: pushUrgent ?? this.pushUrgent,
    );
  }
}

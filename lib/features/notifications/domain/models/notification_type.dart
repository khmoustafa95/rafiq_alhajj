enum InboxNotificationType {
  announcement,
  contentPublished,
  competition,
  ritualUpdate,
  system;

  static InboxNotificationType fromDatabase(String value) {
    return switch (value) {
      'announcement' => InboxNotificationType.announcement,
      'content_published' => InboxNotificationType.contentPublished,
      'competition' => InboxNotificationType.competition,
      'ritual_update' => InboxNotificationType.ritualUpdate,
      _ => InboxNotificationType.system,
    };
  }

  String get databaseValue => switch (this) {
        InboxNotificationType.announcement => 'announcement',
        InboxNotificationType.contentPublished => 'content_published',
        InboxNotificationType.competition => 'competition',
        InboxNotificationType.ritualUpdate => 'ritual_update',
        InboxNotificationType.system => 'system',
      };
}

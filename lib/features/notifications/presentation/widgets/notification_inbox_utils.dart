import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_type.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

Color notificationAccentForType(InboxNotificationType type) {
  return switch (type) {
    InboxNotificationType.announcement => AppColors.accentRed,
    InboxNotificationType.contentPublished => AppColors.accentTeal,
    InboxNotificationType.competition => AppColors.secondary,
    InboxNotificationType.ritualUpdate => AppColors.success,
    InboxNotificationType.system => AppColors.accentPurple,
  };
}

IconData notificationIconForType(InboxNotificationType type) {
  return switch (type) {
    InboxNotificationType.contentPublished => Icons.article_outlined,
    InboxNotificationType.competition => Icons.emoji_events_outlined,
    InboxNotificationType.ritualUpdate => Icons.check_circle_outline,
    InboxNotificationType.announcement => Icons.campaign_outlined,
    InboxNotificationType.system => Icons.directions_bus_outlined,
  };
}

String notificationLabelForType(
  InboxNotificationType type,
  AppLocalizations l10n,
) {
  return switch (type) {
    InboxNotificationType.announcement => l10n.notificationsFilterGeneral,
    InboxNotificationType.contentPublished => l10n.notificationsFilterGeneral,
    InboxNotificationType.competition => l10n.notificationsFilterGeneral,
    InboxNotificationType.ritualUpdate => l10n.notificationsFilterUrgent,
    InboxNotificationType.system => l10n.notificationsFilterUrgent,
  };
}

String notificationShortTime(
  DateTime date,
  AppLocalizations l10n,
  String locale,
) {
  final diff = DateTime.now().difference(date.toLocal());
  if (diff.inMinutes < 1) {
    return l10n.notificationsJustNow;
  }
  if (diff.inMinutes < 60) {
    return l10n.notificationsMinutesAgoShort(diff.inMinutes);
  }
  if (diff.inHours < 24) {
    return l10n.notificationsHoursAgoShort(diff.inHours);
  }
  if (diff.inDays == 1) {
    return l10n.notificationsGroupYesterday;
  }
  return DateFormat.MMMd(locale).format(date.toLocal());
}

List<InboxNotification> filterNotificationsBySegment(
  List<InboxNotification> items,
  int filterIndex,
) {
  if (filterIndex == 1) {
    return items
        .where((n) => n.type == InboxNotificationType.announcement)
        .toList();
  }
  if (filterIndex == 2) {
    return items
        .where(
          (n) =>
              n.type == InboxNotificationType.system ||
              n.type == InboxNotificationType.ritualUpdate,
        )
        .toList();
  }
  return items;
}

List<({String label, List<InboxNotification> items})> groupNotificationsByDay(
  List<InboxNotification> items,
  AppLocalizations l10n,
) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final todayItems = <InboxNotification>[];
  final yesterdayItems = <InboxNotification>[];
  final earlierItems = <InboxNotification>[];

  for (final n in items) {
    final d = n.createdAt.toLocal();
    final day = DateTime(d.year, d.month, d.day);
    if (!day.isBefore(today)) {
      todayItems.add(n);
    } else if (!day.isBefore(yesterday)) {
      yesterdayItems.add(n);
    } else {
      earlierItems.add(n);
    }
  }

  return [
    if (todayItems.isNotEmpty)
      (label: l10n.notificationsGroupToday, items: todayItems),
    if (yesterdayItems.isNotEmpty)
      (label: l10n.notificationsGroupYesterday, items: yesterdayItems),
    if (earlierItems.isNotEmpty)
      (label: l10n.notificationsGroupEarlier, items: earlierItems),
  ];
}

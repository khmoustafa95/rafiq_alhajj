import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/push_notification_channels.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

typedef NotificationChannelDescriptor = ({
  String id,
  String name,
  String description,
  Importance importance,
});

List<NotificationChannelDescriptor> notificationChannelDescriptors(
  AppLocalizations l10n,
) {
  return [
    (
      id: PushNotificationChannels.announcements,
      name: l10n.notificationChannelAnnouncementsName,
      description: l10n.notificationChannelAnnouncementsDescription,
      importance: Importance.defaultImportance,
    ),
    (
      id: PushNotificationChannels.content,
      name: l10n.notificationChannelContentName,
      description: l10n.notificationChannelContentDescription,
      importance: Importance.defaultImportance,
    ),
    (
      id: PushNotificationChannels.competitions,
      name: l10n.notificationChannelCompetitionsName,
      description: l10n.notificationChannelCompetitionsDescription,
      importance: Importance.defaultImportance,
    ),
    (
      id: PushNotificationChannels.urgent,
      name: l10n.notificationChannelUrgentName,
      description: l10n.notificationChannelUrgentDescription,
      importance: Importance.high,
    ),
  ];
}

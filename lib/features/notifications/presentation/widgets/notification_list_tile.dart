import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/core/widgets/staff_web_metrics.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_inbox_utils.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_type_chip.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({
    required this.notification,
    required this.locale,
    required this.onTap,
    super.key,
  });

  final InboxNotification notification;
  final String locale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final accent = notificationAccentForType(notification.type);
    final title = notification.titleForLocale(locale);
    final body = notification.bodyForLocale(locale);
    final isRead = notification.isRead;
    final radius = BorderRadius.circular(sr(AppDecorations.radiusLg));
    final unreadTint =
        isDark ? AppColors.notificationUnreadDark : AppColors.notificationUnread;

    return Semantics(
      label: title,
      hint: isRead ? null : l10n.notificationsNewBadge,
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Ink(
            decoration: BoxDecoration(
              color: isRead ? colorScheme.surface : unreadTint,
              borderRadius: radius,
              border: Border.all(
                color: isRead
                    ? colorScheme.outline
                    : AppColors.primary.withValues(alpha: 0.35),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(sw(14)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: sw(44),
                    height: sw(44),
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(sr(12)),
                    ),
                    child: Icon(
                      notificationIconForType(notification.type),
                      color: accent,
                      size: ss(22),
                    ),
                  ),
                  SizedBox(width: sw(12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  color: colorScheme.onSurface,
                                  fontWeight: isRead
                                      ? FontWeight.w500
                                      : FontWeight.w700,
                                  fontSize: ss(15),
                                  height: 1.3,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: sw(8)),
                            Text(
                              notificationShortTime(
                                notification.createdAt,
                                l10n,
                                locale,
                              ),
                              style: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                                fontSize: ss(11),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (!isRead) ...[
                              SizedBox(width: sw(6)),
                              Container(
                                margin: EdgeInsets.only(top: sh(5)),
                                width: sw(8),
                                height: sw(8),
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ],
                        ),
                        if (body != null && body.isNotEmpty) ...[
                          SizedBox(height: sh(4)),
                          Text(
                            body,
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: ss(13),
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        SizedBox(height: sh(8)),
                        NotificationTypeChip(
                          type: notification.type,
                          accent: accent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

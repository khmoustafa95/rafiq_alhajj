import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/notification_navigation.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_type.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class NotificationListScreen extends ConsumerWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final inboxAsync = ref.watch(notificationInboxProvider);
    final locale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notificationsTitle),
        actions: [
          inboxAsync.maybeWhen(
            data: (items) {
              final hasUnread = items.any((item) => !item.isRead);
              if (!hasUnread) {
                return const SizedBox.shrink();
              }
              return TextButton(
                onPressed: () => unawaited(
                  ref.read(notificationInboxProvider.notifier).markAllAsRead(),
                ),
                child: Text(l10n.notificationsMarkAllRead),
              );
            },
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: inboxAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(l10n.notificationsLoadError)),
        data: (items) {
          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Text(
                  l10n.notificationsEmpty,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(notificationInboxProvider.notifier).refresh(),
            child: ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: items.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = items[index];
                return _NotificationTile(
                  notification: item,
                  locale: locale,
                  onTap: () => _onTap(context, ref, item),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> _onTap(
    BuildContext context,
    WidgetRef ref,
    InboxNotification notification,
  ) async {
    if (!notification.isRead) {
      await ref
          .read(notificationInboxProvider.notifier)
          .markAsRead(notification.id);
    }
    if (!context.mounted) {
      return;
    }
    navigateFromNotification(context, notification);
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({
    required this.notification,
    required this.locale,
    required this.onTap,
  });

  final InboxNotification notification;
  final String locale;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final title = notification.titleForLocale(locale);
    final body = notification.bodyForLocale(locale);
    final timeLabel = DateFormat.yMMMd(locale).add_Hm().format(
          notification.createdAt.toLocal(),
        );

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: notification.isRead
            ? colorScheme.surfaceContainerHighest
            : colorScheme.primaryContainer,
        child: Icon(
          _iconForType(notification.type),
          color: notification.isRead
              ? colorScheme.onSurfaceVariant
              : colorScheme.onPrimaryContainer,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight:
              notification.isRead ? FontWeight.normal : FontWeight.w600,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (body != null) ...[
            SizedBox(height: 4.h),
            Text(body, maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
          SizedBox(height: 4.h),
          Text(
            timeLabel,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
      trailing: notification.isRead
          ? null
          : Icon(Icons.circle, size: 10, color: colorScheme.primary),
    );
  }

  IconData _iconForType(InboxNotificationType type) {
    return switch (type) {
      InboxNotificationType.contentPublished => Icons.article_outlined,
      InboxNotificationType.competition => Icons.emoji_events_outlined,
      InboxNotificationType.ritualUpdate => Icons.check_circle_outline,
      InboxNotificationType.announcement => Icons.campaign_outlined,
      InboxNotificationType.system => Icons.info_outline,
    };
  }
}

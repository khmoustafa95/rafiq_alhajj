import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/notification_navigation.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_providers.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_inbox_body.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_inbox_empty_state.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_inbox_error_state.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/widgets/notification_inbox_header.dart';

/// Notification inbox — a responsive notification center (mobile + staff web).
///
/// Layout is inspired by mainstream notification centers (Gmail/iOS/Slack):
/// a compact header with an unread summary, a segmented filter, and items
/// grouped by day (Today / Yesterday / Earlier) with a clear unread emphasis.
class NotificationListScreen extends ConsumerStatefulWidget {
  const NotificationListScreen({super.key});

  @override
  ConsumerState<NotificationListScreen> createState() =>
      _NotificationListScreenState();
}

class _NotificationListScreenState
    extends ConsumerState<NotificationListScreen> {
  int _filterIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _markGuestSeen());
  }

  /// Guests have no server-side read state; opening the inbox clears the badge
  /// by recording the last-seen time locally (`GuestNotificationsSeenStore`).
  Future<void> _markGuestSeen() async {
    if (!mounted) {
      return;
    }
    final isGuest = ref.read(authAccessModeProvider) == AppAccessMode.guest;
    if (!isGuest) {
      return;
    }
    await ref.read(guestNotificationsSeenStoreProvider).markSeen();
    if (!mounted) {
      return;
    }
    ref.invalidate(unreadNotificationCountProvider);
  }

  Future<void> _onTap(
    BuildContext context,
    InboxNotification notification,
  ) async {
    final isGuest = ref.read(authAccessModeProvider) == AppAccessMode.guest;
    if (!isGuest && !notification.isRead) {
      await ref
          .read(notificationInboxProvider.notifier)
          .markAsRead(notification.id);
    }
    if (!context.mounted) {
      return;
    }
    navigateFromNotification(context, notification);
  }

  Future<void> _refresh() =>
      ref.read(notificationInboxProvider.notifier).refresh();

  @override
  Widget build(BuildContext context) {
    final inboxAsync = ref.watch(notificationInboxProvider);
    final locale = Localizations.localeOf(context).languageCode;

    final items = inboxAsync.value ?? const <InboxNotification>[];
    final unreadCount = items.where((n) => !n.isRead).length;
    final isGuest =
        ref.watch(authAccessModeProvider) == AppAccessMode.guest;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        top: !AppPlatform.isWeb,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NotificationInboxHeader(
              unreadCount: unreadCount,
              canMarkAll: !isGuest && unreadCount > 0,
              onMarkAll: () => unawaited(
                ref.read(notificationInboxProvider.notifier).markAllAsRead(),
              ),
              onRefresh: () => unawaited(_refresh()),
            ),
            Divider(height: 1, color: Theme.of(context).dividerColor),
            Expanded(
              child: inboxAsync.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (_, _) => NotificationInboxErrorState(
                  onRetry: () => unawaited(_refresh()),
                ),
                data: (data) {
                  if (data.isEmpty) {
                    return const NotificationInboxEmptyState();
                  }
                  return NotificationInboxBody(
                    items: data,
                    filterIndex: _filterIndex,
                    onFilterChanged: (index) =>
                        setState(() => _filterIndex = index),
                    locale: locale,
                    onTap: (n) => _onTap(context, n),
                    onRefresh: _refresh,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

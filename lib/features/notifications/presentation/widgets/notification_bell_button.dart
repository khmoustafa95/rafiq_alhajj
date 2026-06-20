import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// App bar action: opens the notification inbox with an unread badge.
class NotificationBellButton extends ConsumerWidget {
  const NotificationBellButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const _NotificationBellWithBadge();
  }
}

class _NotificationBellWithBadge extends ConsumerWidget {
  const _NotificationBellWithBadge();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final unreadAsync = ref.watch(unreadNotificationCountProvider);

    return unreadAsync.when(
      data: (count) => _BellIcon(
        unreadCount: count,
        tooltip: l10n.notificationsOpenInbox,
        onPressed: () => context.go(AppRoutes.notifications),
      ),
      loading: () => _BellIcon(
        unreadCount: 0,
        tooltip: l10n.notificationsOpenInbox,
        onPressed: () => context.go(AppRoutes.notifications),
      ),
      error: (_, _) => _BellIcon(
        unreadCount: 0,
        tooltip: l10n.notificationsOpenInbox,
        onPressed: () => context.go(AppRoutes.notifications),
      ),
    );
  }
}

class _BellIcon extends StatelessWidget {
  const _BellIcon({
    required this.unreadCount,
    required this.tooltip,
    required this.onPressed,
  });

  final int unreadCount;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Badge(
        isLabelVisible: unreadCount > 0,
        label: Text(unreadCount > 99 ? '99+' : '$unreadCount'),
        child: const Icon(Icons.notifications_outlined),
      ),
    );
  }
}

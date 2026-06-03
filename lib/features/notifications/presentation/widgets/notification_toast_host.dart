import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/notification_navigation.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_providers.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Shows an in-app [SnackBar] when a new unread notification arrives (Realtime).
class NotificationToastHost extends ConsumerWidget {
  const NotificationToastHost({required this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<InboxNotification>>(
      notificationToastEventsProvider,
      (previous, next) {
        next.whenData((notification) {
          _showToast(context, notification);
        });
      },
    );

    return child ?? const SizedBox.shrink();
  }

  void _showToast(BuildContext context, InboxNotification notification) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) {
      return;
    }

    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final title = notification.titleForLocale(locale);

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(title),
        action: SnackBarAction(
          label: l10n.notificationsOpenInbox,
          onPressed: () {
            if (!context.mounted) {
              return;
            }
            final router = GoRouter.of(context);
            final onNotifications =
                router.state.matchedLocation == AppRoutes.notifications;
            if (onNotifications) {
              navigateFromNotification(context, notification);
            } else {
              unawaited(context.push(AppRoutes.notifications));
            }
          },
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}

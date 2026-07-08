import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/push_navigation_resolver.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';

export 'package:rafiq_alhajj/features/notifications/application/utils/push_navigation_resolver.dart'
    show resolveSosRoute;

/// Opens the screen referenced by [notification.payload], when supported.
void navigateFromNotification(BuildContext context, InboxNotification notification) {
  final target = tryResolvePushNavigationTarget(notification.payload);
  if (target == null) {
    return;
  }

  executePushNavigationTarget(context, target);
}

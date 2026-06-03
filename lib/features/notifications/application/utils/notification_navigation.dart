import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';

/// Opens the screen referenced by [notification.payload], when supported.
void navigateFromNotification(BuildContext context, InboxNotification notification) {
  final route = notification.payload['route'] as String?;
  final id = notification.payload['id'] as String?;

  switch (route) {
    case 'content':
      if (id != null && id.isNotEmpty) {
        unawaited(context.push(AppRoutes.contentDetailPath(id)));
      }
    case 'competition':
      if (id != null && id.isNotEmpty) {
        unawaited(context.push(AppRoutes.competitionDetailPath(id)));
      }
    case 'pilgrim':
      unawaited(context.push(AppRoutes.pilgrimDashboard));
    case 'competitions':
      unawaited(context.push(AppRoutes.competitions));
    case 'home':
      context.go(AppRoutes.home);
    default:
      break;
  }
}

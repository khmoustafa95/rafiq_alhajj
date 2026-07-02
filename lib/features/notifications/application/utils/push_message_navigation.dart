import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/root_navigator_key.dart';
import 'package:rafiq_alhajj/features/notifications/application/services/push_open_handler.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/notification_navigation.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/pending_push_navigation.dart';

/// Navigates from FCM [data] payload (`route`, `id`).
///
/// When the navigator is not ready yet (cold start), the payload is queued in
/// [PendingPushNavigation] and flushed via [flushPendingPushNavigation].
void navigateFromPushData(Map<String, dynamic> data) {
  final context = rootNavigatorKey.currentContext;
  if (context == null) {
    PendingPushNavigation.setPending(data);
    return;
  }

  _navigateWithContext(context, data);
}

/// Attempts to navigate a previously queued push payload. Safe to call every
/// frame until the router is ready (see [maxAttempts]).
void flushPendingPushNavigation({int maxAttempts = 1}) {
  if (!PendingPushNavigation.hasPending) {
    return;
  }

  for (var attempt = 0; attempt < maxAttempts; attempt++) {
    final pending = PendingPushNavigation.takePending();
    if (pending == null) {
      return;
    }

    final context = rootNavigatorKey.currentContext;
    if (context == null) {
      PendingPushNavigation.setPending(pending);
      return;
    }

    _navigateWithContext(context, pending);
  }
}

void _navigateWithContext(BuildContext context, Map<String, dynamic> data) {
  unawaited(PushOpenHandler.handleOpen(data));

  final route = data['route'] as String?;
  final id = data['id'] as String?;

  switch (route) {
    case 'content':
      if (id != null && id.isNotEmpty) {
        unawaited(context.push(AppRoutes.contentDetailPath(id)));
      }
    case 'contentTopic':
      if (id != null && id.isNotEmpty) {
        unawaited(context.push(AppRoutes.contentTopicDetailPath(id)));
      }
    case 'competition':
      if (id != null && id.isNotEmpty) {
        unawaited(context.push(AppRoutes.competitionDetailPath(id)));
      }
    case 'pilgrim':
      unawaited(context.push(AppRoutes.pilgrimDashboard));
    case 'competitions':
      unawaited(context.push(AppRoutes.competitions));
    case 'sos':
      context.go(resolveSosRoute(context));
    case 'home':
      context.go(AppRoutes.home);
    case 'notifications':
      context.go(AppRoutes.notifications);
    default:
      context.go(AppRoutes.notifications);
  }
}

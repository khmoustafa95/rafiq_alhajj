import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/core/routing/root_navigator_key.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/notification_navigation.dart';

/// Navigates from FCM [data] payload (`route`, `id`).
void navigateFromPushData(Map<String, dynamic> data) {
  final context = rootNavigatorKey.currentContext;
  if (context == null) {
    return;
  }

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

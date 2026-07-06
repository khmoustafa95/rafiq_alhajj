import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';

enum PushNavigationKind { go, push, sos }

class PushNavigationTarget {
  const PushNavigationTarget({
    required this.kind,
    this.path,
  });

  const PushNavigationTarget.go(String path)
      : this(kind: PushNavigationKind.go, path: path);

  const PushNavigationTarget.push(String path)
      : this(kind: PushNavigationKind.push, path: path);

  const PushNavigationTarget.sos() : this(kind: PushNavigationKind.sos);

  final PushNavigationKind kind;
  final String? path;
}

/// Resolves a push/inbox payload when [route] is recognized.
///
/// Returns `null` for missing/unknown routes or routes that require an [id]
/// but do not have one — used by inbox taps where no navigation is desired.
PushNavigationTarget? tryResolvePushNavigationTarget(
  Map<String, dynamic> data,
) {
  final route = data['route'] as String?;
  if (route == null || route.isEmpty) {
    return null;
  }

  final id = data['id'] as String?;

  switch (route) {
    case 'content':
      if (id != null && id.isNotEmpty) {
        return PushNavigationTarget.push(AppRoutes.contentDetailPath(id));
      }
      return null;
    case 'contentTopic':
      if (id != null && id.isNotEmpty) {
        return PushNavigationTarget.push(AppRoutes.contentTopicDetailPath(id));
      }
      return null;
    case 'competition':
      if (id != null && id.isNotEmpty) {
        return PushNavigationTarget.push(AppRoutes.competitionDetailPath(id));
      }
      return null;
    case 'pilgrim':
      return const PushNavigationTarget.push(AppRoutes.pilgrimDashboard);
    case 'competitions':
      return const PushNavigationTarget.push(AppRoutes.competitions);
    case 'sos':
      return const PushNavigationTarget.sos();
    case 'home':
      return const PushNavigationTarget.go(AppRoutes.home);
    case 'notifications':
      return const PushNavigationTarget.go(AppRoutes.notifications);
    default:
      return null;
  }
}

/// Resolves a push `data` payload to a navigation target without needing
/// [BuildContext]. Unknown routes fall back to the notifications inbox.
PushNavigationTarget resolvePushNavigationTarget(Map<String, dynamic> data) {
  return tryResolvePushNavigationTarget(data) ??
      const PushNavigationTarget.go(AppRoutes.notifications);
}

/// Picks the SOS monitor route that matches the current staff context.
String resolveSosRoute(BuildContext context) {
  final location =
      GoRouter.of(context).routerDelegate.currentConfiguration.uri.path;
  return location.startsWith('/operator/field')
      ? AppRoutes.fieldOperatorSos
      : AppRoutes.adminSos;
}

/// Executes a resolved navigation target on [context].
void executePushNavigationTarget(
  BuildContext context,
  PushNavigationTarget target,
) {
  switch (target.kind) {
    case PushNavigationKind.push:
      if (target.path != null) {
        unawaited(context.push(target.path!));
      }
    case PushNavigationKind.go:
      if (target.path != null) {
        context.go(target.path!);
      }
    case PushNavigationKind.sos:
      context.go(resolveSosRoute(context));
  }
}

/// Stable id for deduplicating opened push messages across cold-start paths.
String? pushOpenDedupeKey({
  String? messageId,
  Map<String, dynamic>? data,
}) {
  return messageId ??
      data?['notification_id'] as String? ??
      data?['id'] as String?;
}

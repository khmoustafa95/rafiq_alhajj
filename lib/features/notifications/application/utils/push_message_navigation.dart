import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:rafiq_alhajj/core/routing/root_navigator_key.dart';
import 'package:rafiq_alhajj/features/notifications/application/services/push_open_handler.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/pending_push_navigation.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/push_navigation_resolver.dart';

export 'package:rafiq_alhajj/features/notifications/application/utils/push_navigation_resolver.dart';

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
  executePushNavigationTarget(context, resolvePushNavigationTarget(data));
}

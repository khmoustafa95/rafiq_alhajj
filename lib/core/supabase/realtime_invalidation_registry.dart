import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Keys for shared Supabase realtime subscription groups.
abstract final class RealtimeSyncKeys {
  static const contentFeed = 'content_feed';
  static const pilgrimRegistry = 'pilgrim_registry';
  static const pilgrimDashboard = 'pilgrim_dashboard';
  static const adminAnalytics = 'admin_analytics';
  static const competitions = 'competitions';
  static const systemSettings = 'system_settings';
  static const adminOperators = 'admin_operators';
  static const adminGroups = 'admin_groups';
  static const supportContacts = 'support_contacts';
  static const sosAlerts = 'sos_alerts';
}

/// Handlers registered by features; fired by [realtimeSyncProviders].
abstract final class RealtimeInvalidationRegistry {
  static final Map<String, List<void Function(Ref ref)>> _handlers = {};
  static final Map<String, Set<String>> _handlerIds = {};

  static void register(
    String key,
    String handlerId,
    void Function(Ref ref) handler,
  ) {
    final ids = _handlerIds.putIfAbsent(key, () => {});
    if (!ids.add(handlerId)) {
      return;
    }
    _handlers.putIfAbsent(key, () => []).add(handler);
  }

  static void fire(Ref ref, String key) {
    final handlers = _handlers[key];
    if (handlers == null) {
      return;
    }
    for (final handler in handlers) {
      // Defer past the current build/microtask chain so invalidation never
      // runs while a dependent provider (e.g. hajjJourneyState) is still
      // awaiting this one's future — avoids CircularDependencyError.
      unawaited(
        Future<void>.delayed(Duration.zero, () => handler(ref)),
      );
    }
  }

  /// Schedules provider invalidation on the next event-loop turn.
  static void safeInvalidate(Ref ref, void Function(Ref ref) invalidate) {
    unawaited(
      Future<void>.delayed(Duration.zero, () => invalidate(ref)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/pending_push_navigation.dart';
import 'package:rafiq_alhajj/features/notifications/application/utils/push_message_navigation.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/push_notification_providers.dart';

/// Starts FCM binding without rebuilding [MaterialApp].
///
/// The binding (Firebase init, local-notification setup, OS permission request,
/// `getInitialMessage`) is deferred to *after* the first frame is rendered.
/// Triggering it during the initial build makes the platform-channel calls and
/// the permission dialog contend with the most expensive frame of a debug cold
/// start, which can stall the main thread long enough to drop the Dart VM
/// Service connection ("Lost connection to device").
class PushNotificationStarter extends ConsumerStatefulWidget {
  const PushNotificationStarter({required this.child, super.key});

  final Widget? child;

  @override
  ConsumerState<PushNotificationStarter> createState() =>
      _PushNotificationStarterState();
}

class _PushNotificationStarterState
    extends ConsumerState<PushNotificationStarter> {
  static const _maxFlushFrames = 30;
  var _flushFrames = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      // Instantiating the keepAlive binding provider kicks off FCM init and the
      // auth-scoped token sync; reading it once is enough to keep it alive.
      ref.read(pushNotificationBindingProvider);
      _schedulePendingNavigationFlush();
    });
  }

  void _schedulePendingNavigationFlush() {
    if (!PendingPushNavigation.hasPending ||
        _flushFrames >= _maxFlushFrames) {
      return;
    }

    _flushFrames++;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      flushPendingPushNavigation();
      if (PendingPushNavigation.hasPending) {
        _schedulePendingNavigationFlush();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox.shrink();
  }
}

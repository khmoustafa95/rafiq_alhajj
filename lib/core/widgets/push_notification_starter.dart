import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/push_notification_providers.dart';

/// Starts FCM binding without rebuilding [MaterialApp].
class PushNotificationStarter extends ConsumerWidget {
  const PushNotificationStarter({required this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(pushNotificationBindingProvider);
    return child ?? const SizedBox.shrink();
  }
}

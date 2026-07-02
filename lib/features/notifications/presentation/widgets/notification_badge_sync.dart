import 'dart:async';

import 'package:app_badge_plus/app_badge_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_providers.dart';

/// Syncs the unread inbox count to the OS home-screen app icon badge (iOS /
/// supported Android launchers). In-app bell badge is separate.
class NotificationBadgeSync extends ConsumerWidget {
  const NotificationBadgeSync({required this.child, super.key});

  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!AppPlatform.isWeb) {
      ref.listen<AsyncValue<int>>(unreadNotificationCountProvider, (_, next) {
        next.whenData((count) {
          unawaited(_syncBadge(count));
        });
      });
    }

    return child ?? const SizedBox.shrink();
  }

  Future<void> _syncBadge(int count) async {
    try {
      final supported = await AppBadgePlus.isSupported();
      if (!supported) {
        return;
      }

      if (count <= 0) {
        await AppBadgePlus.updateBadge(0);
      } else {
        await AppBadgePlus.updateBadge(count > 99 ? 99 : count);
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('App badge sync failed: $e');
      }
    }
  }
}

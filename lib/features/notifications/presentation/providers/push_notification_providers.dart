import 'dart:async';

import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/l10n/locale_controller.dart';
import 'package:rafiq_alhajj/core/platform/app_platform.dart';
import 'package:rafiq_alhajj/features/admin_settings/presentation/providers/system_settings_providers.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/notifications/application/services/push_notification_service.dart';
import 'package:rafiq_alhajj/features/notifications/application/services/push_open_handler.dart';
import 'package:rafiq_alhajj/features/notifications/application/services/web_push_bridge.dart';
import 'package:rafiq_alhajj/features/notifications/data/repositories/device_token_repository.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/notification_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'push_notification_providers.g.dart';

@Riverpod(keepAlive: true)
DeviceTokenRepository deviceTokenRepository(Ref ref) {
  return DeviceTokenRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
PushNotificationService pushNotificationService(Ref ref) {
  final service = PushNotificationService(
    ref.watch(deviceTokenRepositoryProvider),
  );
  ref.onDispose(service.dispose);
  return service;
}

@riverpod
Future<void> pushNotificationInit(Ref ref) async {
  await ref.read(pushNotificationServiceProvider).initialize();
}

/// Initializes FCM and syncs tokens with the signed-in user.
@Riverpod(keepAlive: true)
void pushNotificationBinding(Ref ref) {
  ref.watch(pushNotificationInitProvider);

  PushOpenHandler.onOpen = (data) async {
    final notificationId = data['notification_id'] as String?;
    if (notificationId == null || notificationId.isEmpty) {
      return;
    }
    await ref.read(notificationInboxProvider.notifier).markAsRead(notificationId);
    ref.invalidate(unreadNotificationCountProvider);
  };

  if (AppPlatform.isWeb) {
    startWebPushClickListener();
    consumeWebPushLaunchParams();
  }

  ref.listen(authProfileIdProvider, (previous, next) {
    if (previous == next) {
      return;
    }

    unawaited(_syncPushBinding(ref, previous, next));
  }, fireImmediately: true);

  ref.listen(systemSettingsProvider, (previous, next) {
    final profileId = ref.read(authProfileIdProvider);
    if (profileId == null) {
      return;
    }
    final prevEnabled = previous?.value?.enablePushNotifications ?? true;
    final nextEnabled = next.value?.enablePushNotifications ?? true;
    if (prevEnabled != nextEnabled) {
      unawaited(_syncPushBinding(ref, profileId, profileId));
    }
  });

  ref.listen(localeControllerProvider, (previous, next) {
    if (previous?.languageCode == next.languageCode) {
      return;
    }
    unawaited(
      ref.read(pushNotificationServiceProvider).syncNotificationChannels(next),
    );
  });
}

Future<void> _syncPushBinding(
  Ref ref,
  String? previousProfileId,
  String? nextProfileId,
) async {
  final service = ref.read(pushNotificationServiceProvider);

  if (previousProfileId != null &&
      nextProfileId == null &&
      previousProfileId != nextProfileId) {
    await service.unregisterCurrentUser();
    return;
  }

  if (nextProfileId == null) {
    return;
  }

  final settings = await ref.read(systemSettingsProvider.future);
  if (!settings.enablePushNotifications) {
    await service.unregisterCurrentUser();
    return;
  }

  await service.bindUser(nextProfileId);
}

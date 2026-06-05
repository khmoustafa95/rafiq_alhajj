import 'dart:async';

import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/notifications/application/services/push_notification_service.dart';
import 'package:rafiq_alhajj/features/notifications/data/repositories/device_token_repository.dart';
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

  ref.listen(authProfileIdProvider, (previous, next) {
    if (previous == next) {
      return;
    }
    unawaited(
      ref.read(pushNotificationServiceProvider).bindUser(next),
    );
  }, fireImmediately: true);
}

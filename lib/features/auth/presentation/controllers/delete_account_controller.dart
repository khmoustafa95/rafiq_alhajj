import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rafiq_alhajj/core/routing/app_routes.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_service_provider.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/push_notification_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_account_controller.g.dart';

@Riverpod(keepAlive: true)
class DeleteAccountController extends _$DeleteAccountController {
  @override
  FutureOr<void> build() {}

  Future<bool> deleteAccount(BuildContext context) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await _wipeLocalData();
      await ref.read(pushNotificationServiceProvider).unregisterCurrentUser();
      await ref.read(authServiceProvider).deleteMyAccount();
    });

    if (!ref.mounted) {
      return false;
    }

    state = result;

    if (result.hasError) {
      return false;
    }

    if (context.mounted) {
      context.go(AppRoutes.home);
    }
    return true;
  }

  Future<void> _wipeLocalData() async {
    try {
      final cache = await ref.read(contentMediaCacheServiceProvider.future);
      await cache.clearAll();
      await ref.read(mediaEncryptionServiceProvider).wipeKey();
    } catch (_) {
      // Best-effort: never block deletion on cache cleanup.
    }
  }
}

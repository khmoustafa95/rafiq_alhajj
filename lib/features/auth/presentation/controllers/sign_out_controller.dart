import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_service_provider.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:rafiq_alhajj/features/notifications/presentation/providers/push_notification_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_out_controller.g.dart';

@Riverpod(keepAlive: true)
class SignOutController extends _$SignOutController {
  @override
  FutureOr<void> build() {}

  Future<void> signOut() async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      // Privacy: wipe only plaintext decrypt-temp files. Encrypted blobs and
      // per-profile manifests are kept so pilgrims can resume offline content
      // after signing back in on the same device.
      await _wipeDecryptTemp();
      await ref.read(pushNotificationServiceProvider).unregisterCurrentUser();
      await ref.read(authServiceProvider).signOut();
    });
    if (!ref.mounted) {
      return;
    }
    state = result;
  }

  Future<void> _wipeDecryptTemp() async {
    try {
      final cache = await ref.read(contentMediaCacheServiceProvider.future);
      await cache.wipeDecryptTemp();
    } catch (_) {
      // Best-effort: never block sign-out on cache cleanup.
    }
  }
}

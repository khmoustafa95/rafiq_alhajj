import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_service_provider.dart';
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
      await ref.read(pushNotificationServiceProvider).unregisterCurrentUser();
      await ref.read(authServiceProvider).signOut();
    });
    if (!ref.mounted) {
      return;
    }
    state = result;
  }
}

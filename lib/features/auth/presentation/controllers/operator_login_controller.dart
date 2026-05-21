import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'operator_login_controller.g.dart';

@riverpod
class OperatorLoginController extends _$OperatorLoginController {
  @override
  FutureOr<void> build() {}

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authServiceProvider).signInStaff(
            email: email,
            password: password,
          );
    });
    return !state.hasError;
  }
}

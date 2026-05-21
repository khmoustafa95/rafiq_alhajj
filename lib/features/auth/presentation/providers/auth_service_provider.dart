import 'package:rafiq_alhajj/features/auth/application/services/auth_service.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service_provider.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) {
  return AuthService(ref.watch(authRepositoryProvider));
}

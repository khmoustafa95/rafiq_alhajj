import 'package:rafiq_alhajj/features/auth/domain/models/auth_session_state.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<AuthSessionState> authSession(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.watchSessionState();
}

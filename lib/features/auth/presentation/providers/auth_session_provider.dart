import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/auth_session_state.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_session_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<AuthSessionState> authSession(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.watchSessionState();
}

/// Redirect-relevant access mode; downstream rebuilds only when the value changes.
@Riverpod(keepAlive: true)
AppAccessMode authAccessMode(Ref ref) {
  final session = ref.watch(authSessionProvider);
  return session.value?.accessMode ?? AppAccessMode.guest;
}

/// Signed-in profile id; downstream rebuilds only when sign-in/out changes id.
@Riverpod(keepAlive: true)
String? authProfileId(Ref ref) {
  final session = ref.watch(authSessionProvider);
  return session.value?.profileOrNull?.id;
}

/// Pilgrim display name; isolated from unrelated auth token refreshes when unchanged.
@Riverpod(keepAlive: true)
String? authProfileFullName(Ref ref) {
  final session = ref.watch(authSessionProvider);
  return session.value?.profileOrNull?.fullName;
}

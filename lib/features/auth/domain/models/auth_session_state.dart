import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/user_profile.dart';

part 'auth_session_state.freezed.dart';

@freezed
abstract class AuthSessionState with _$AuthSessionState {
  const AuthSessionState._();

  const factory AuthSessionState.guest() = GuestAuthSession;

  const factory AuthSessionState.authenticated({
    required UserProfile profile,
  }) = AuthenticatedAuthSession;

  AppAccessMode get accessMode => when(
        guest: () => AppAccessMode.guest,
        authenticated: (profile) => switch (profile.role) {
          AppUserRole.pilgrim => AppAccessMode.pilgrim,
          AppUserRole.operator => AppAccessMode.operator,
          AppUserRole.admin => AppAccessMode.admin,
        },
      );

  UserProfile? get profileOrNull => when(
        guest: () => null,
        authenticated: (profile) => profile,
      );
}

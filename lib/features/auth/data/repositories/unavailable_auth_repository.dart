import 'package:rafiq_alhajj/features/auth/data/repositories/auth_repository.dart';
import 'package:rafiq_alhajj/features/auth/data/repositories/supabase_auth_repository.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/auth_session_state.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/user_profile.dart';

/// Used when Supabase is not configured (no dart-defines).
class UnavailableAuthRepository implements AuthRepository {
  const UnavailableAuthRepository();

  @override
  Stream<AuthSessionState> watchSessionState() =>
      Stream.value(const AuthSessionState.guest());

  @override
  Future<AuthSessionState> getCurrentSessionState() async =>
      const AuthSessionState.guest();

  @override
  Future<UserProfile> signInWithPassword({
    required String email,
    required String password,
  }) async {
    throw const PilgrimAuthException(PilgrimAuthErrorCode.configMissing);
  }

  @override
  Future<UserProfile> signInStaff({
    required String email,
    required String password,
  }) async {
    throw const PilgrimAuthException(PilgrimAuthErrorCode.configMissing);
  }

  @override
  Future<UserProfile> signInAdmin({
    required String email,
    required String password,
  }) async {
    throw const PilgrimAuthException(PilgrimAuthErrorCode.configMissing);
  }

  @override
  Future<void> signOut() async {}
}

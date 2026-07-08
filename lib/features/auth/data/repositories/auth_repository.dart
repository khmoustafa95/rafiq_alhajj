import 'package:rafiq_alhajj/features/auth/domain/models/auth_session_state.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/user_profile.dart';

/// Contract for pilgrim authentication (Supabase Auth + profiles).
abstract class AuthRepository {
  Stream<AuthSessionState> watchSessionState();

  Future<AuthSessionState> getCurrentSessionState();

  Future<UserProfile> signInWithPassword({
    required String email,
    required String password,
  });

  Future<UserProfile> signInStaff({
    required String email,
    required String password,
  });

  Future<UserProfile> signInAdmin({
    required String email,
    required String password,
  });

  Future<void> signOut();

  /// Permanently deletes the signed-in pilgrim account and associated data.
  Future<void> deleteMyAccount();
}

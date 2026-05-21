import 'package:rafiq_alhajj/features/auth/data/dtos/profile_dto.dart';
import 'package:rafiq_alhajj/features/auth/data/repositories/auth_repository.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/auth_session_state.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PilgrimAuthException implements Exception {
  const PilgrimAuthException(this.code);

  final PilgrimAuthErrorCode code;

  @override
  String toString() => 'PilgrimAuthException($code)';
}

enum PilgrimAuthErrorCode {
  invalidCredentials,
  emailNotConfirmed,
  notPilgrimRole,
  notStaffRole,
  notAdminRole,
  profileNotFound,
  network,
  unknown,
}

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._client);

  final SupabaseClient _client;

  @override
  Stream<AuthSessionState> watchSessionState() async* {
    yield await getCurrentSessionState();
    await for (final _ in _client.auth.onAuthStateChange) {
      yield await getCurrentSessionState();
    }
  }

  @override
  Future<AuthSessionState> getCurrentSessionState() async {
    final session = _client.auth.currentSession;
    if (session == null) {
      return const AuthSessionState.guest();
    }

    final profile = await _fetchProfile(session.user.id);
    if (profile == null) {
      return const AuthSessionState.guest();
    }

    return AuthSessionState.authenticated(profile: profile);
  }

  @override
  Future<UserProfile> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw const PilgrimAuthException(PilgrimAuthErrorCode.invalidCredentials);
      }

      final profile = await _fetchProfile(user.id);
      if (profile == null) {
        await _client.auth.signOut();
        throw const PilgrimAuthException(PilgrimAuthErrorCode.profileNotFound);
      }

      if (profile.role != AppUserRole.pilgrim) {
        await _client.auth.signOut();
        throw const PilgrimAuthException(PilgrimAuthErrorCode.notPilgrimRole);
      }

      return profile;
    } on AuthException catch (e) {
      throw PilgrimAuthException(_mapAuthException(e));
    } on PostgrestException {
      throw const PilgrimAuthException(PilgrimAuthErrorCode.network);
    }
  }

  @override
  Future<UserProfile> signInStaff({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw const PilgrimAuthException(PilgrimAuthErrorCode.invalidCredentials);
      }

      final profile = await _fetchProfile(user.id);
      if (profile == null) {
        await _client.auth.signOut();
        throw const PilgrimAuthException(PilgrimAuthErrorCode.profileNotFound);
      }

      if (profile.role != AppUserRole.operator) {
        await _client.auth.signOut();
        throw const PilgrimAuthException(PilgrimAuthErrorCode.notStaffRole);
      }

      return profile;
    } on AuthException catch (e) {
      throw PilgrimAuthException(_mapAuthException(e));
    } on PostgrestException {
      throw const PilgrimAuthException(PilgrimAuthErrorCode.network);
    }
  }

  @override
  Future<UserProfile> signInAdmin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw const PilgrimAuthException(PilgrimAuthErrorCode.invalidCredentials);
      }

      final profile = await _fetchProfile(user.id);
      if (profile == null) {
        await _client.auth.signOut();
        throw const PilgrimAuthException(PilgrimAuthErrorCode.profileNotFound);
      }

      if (profile.role != AppUserRole.admin) {
        await _client.auth.signOut();
        throw const PilgrimAuthException(PilgrimAuthErrorCode.notAdminRole);
      }

      return profile;
    } on AuthException catch (e) {
      throw PilgrimAuthException(_mapAuthException(e));
    } on PostgrestException {
      throw const PilgrimAuthException(PilgrimAuthErrorCode.network);
    }
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<UserProfile?> _fetchProfile(String userId) async {
    final data = await _client
        .from('profiles')
        .select('id, full_name, role')
        .eq('id', userId)
        .maybeSingle();

    if (data == null) {
      return null;
    }

    return ProfileDto.fromJson(Map<String, dynamic>.from(data)).toDomain();
  }

  PilgrimAuthErrorCode _mapAuthException(AuthException e) {
    final message = e.message.toLowerCase();
    if (message.contains('invalid') || message.contains('credentials')) {
      return PilgrimAuthErrorCode.invalidCredentials;
    }
    if (message.contains('confirm') || message.contains('verified')) {
      return PilgrimAuthErrorCode.emailNotConfirmed;
    }
    return PilgrimAuthErrorCode.unknown;
  }
}

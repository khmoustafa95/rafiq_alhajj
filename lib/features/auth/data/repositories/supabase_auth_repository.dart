import 'dart:async';
import 'dart:io';

import 'package:rafiq_alhajj/features/auth/data/data_sources/auth_remote_data_source.dart';
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
  configMissing,
  unknown,
}

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(SupabaseClient client)
      : _remote = AuthRemoteDataSource(client);

  final AuthRemoteDataSource _remote;
  static const Duration _requestTimeout = Duration(seconds: 15);

  @override
  Stream<AuthSessionState> watchSessionState() async* {
    yield await _safeCurrentSessionState();
    await for (final _ in _remote.authStateChanges()) {
      yield await _safeCurrentSessionState();
    }
  }

  Future<AuthSessionState> _safeCurrentSessionState() async {
    try {
      return await getCurrentSessionState().timeout(_requestTimeout);
    } on TimeoutException {
      return const AuthSessionState.guest();
    } on PostgrestException {
      return const AuthSessionState.guest();
    } on SocketException {
      return const AuthSessionState.guest();
    }
  }

  @override
  Future<AuthSessionState> getCurrentSessionState() async {
    final userId = _remote.currentUserId;
    if (userId == null) {
      return const AuthSessionState.guest();
    }

    final profile = await _fetchProfile(userId);
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
      final user = await _remote
          .signInWithPassword(email: email.trim(), password: password)
          .timeout(_requestTimeout);

      if (user == null) {
        throw const PilgrimAuthException(PilgrimAuthErrorCode.invalidCredentials);
      }

      final profile = await _fetchProfile(user.id);
      if (profile == null) {
        await _remote.signOut();
        throw const PilgrimAuthException(PilgrimAuthErrorCode.profileNotFound);
      }

      if (profile.role != AppUserRole.pilgrim) {
        await _remote.signOut();
        throw const PilgrimAuthException(PilgrimAuthErrorCode.notPilgrimRole);
      }

      return profile;
    } on AuthException catch (e) {
      throw PilgrimAuthException(_mapAuthException(e));
    } on PostgrestException {
      throw const PilgrimAuthException(PilgrimAuthErrorCode.network);
    } on SocketException {
      throw const PilgrimAuthException(PilgrimAuthErrorCode.network);
    } on TimeoutException {
      throw const PilgrimAuthException(PilgrimAuthErrorCode.network);
    }
  }

  @override
  Future<UserProfile> signInStaff({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _remote
          .signInWithPassword(email: email.trim(), password: password)
          .timeout(_requestTimeout);

      if (user == null) {
        throw const PilgrimAuthException(PilgrimAuthErrorCode.invalidCredentials);
      }

      final profile = await _fetchProfile(user.id);
      if (profile == null) {
        await _remote.signOut();
        throw const PilgrimAuthException(PilgrimAuthErrorCode.profileNotFound);
      }

      if (profile.role != AppUserRole.operator) {
        await _remote.signOut();
        throw const PilgrimAuthException(PilgrimAuthErrorCode.notStaffRole);
      }

      return profile;
    } on AuthException catch (e) {
      throw PilgrimAuthException(_mapAuthException(e));
    } on PostgrestException {
      throw const PilgrimAuthException(PilgrimAuthErrorCode.network);
    } on SocketException {
      throw const PilgrimAuthException(PilgrimAuthErrorCode.network);
    } on TimeoutException {
      throw const PilgrimAuthException(PilgrimAuthErrorCode.network);
    }
  }

  @override
  Future<UserProfile> signInAdmin({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _remote
          .signInWithPassword(email: email.trim(), password: password)
          .timeout(_requestTimeout);

      if (user == null) {
        throw const PilgrimAuthException(PilgrimAuthErrorCode.invalidCredentials);
      }

      final profile = await _fetchProfile(user.id);
      if (profile == null) {
        await _remote.signOut();
        throw const PilgrimAuthException(PilgrimAuthErrorCode.profileNotFound);
      }

      if (profile.role != AppUserRole.admin) {
        await _remote.signOut();
        throw const PilgrimAuthException(PilgrimAuthErrorCode.notAdminRole);
      }

      return profile;
    } on AuthException catch (e) {
      throw PilgrimAuthException(_mapAuthException(e));
    } on PostgrestException {
      throw const PilgrimAuthException(PilgrimAuthErrorCode.network);
    } on SocketException {
      throw const PilgrimAuthException(PilgrimAuthErrorCode.network);
    } on TimeoutException {
      throw const PilgrimAuthException(PilgrimAuthErrorCode.network);
    }
  }

  @override
  Future<void> signOut() async {
    await _remote.signOut();
  }

  @override
  Future<void> deleteMyAccount() async {
    try {
      await _remote.invokeDeleteMyAccount().timeout(_requestTimeout);
      await _remote.signOut();
    } on FunctionException catch (e) {
      if (e.status == 403) {
        throw const PilgrimAuthException(PilgrimAuthErrorCode.notPilgrimRole);
      }
      throw const PilgrimAuthException(PilgrimAuthErrorCode.unknown);
    } on PostgrestException {
      throw const PilgrimAuthException(PilgrimAuthErrorCode.network);
    } on SocketException {
      throw const PilgrimAuthException(PilgrimAuthErrorCode.network);
    } on TimeoutException {
      throw const PilgrimAuthException(PilgrimAuthErrorCode.network);
    }
  }

  Future<UserProfile?> _fetchProfile(String userId) async {
    final data = await _remote.fetchProfile(userId).timeout(_requestTimeout);

    if (data == null) {
      return null;
    }

    return ProfileDto.fromJson(data).toDomain();
  }

  PilgrimAuthErrorCode _mapAuthException(AuthException e) {
    final message = e.message.toLowerCase();
    if (message.contains('invalid') || message.contains('credentials')) {
      return PilgrimAuthErrorCode.invalidCredentials;
    }
    if (message.contains('confirm') || message.contains('verified')) {
      return PilgrimAuthErrorCode.emailNotConfirmed;
    }
    if (message.contains('network') ||
        message.contains('connection') ||
        message.contains('socket') ||
        message.contains('failed host lookup')) {
      return PilgrimAuthErrorCode.network;
    }
    return PilgrimAuthErrorCode.unknown;
  }
}

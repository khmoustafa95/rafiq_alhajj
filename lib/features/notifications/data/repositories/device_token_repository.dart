import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/notifications/data/data_sources/device_token_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeviceTokenException implements Exception {
  const DeviceTokenException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Device token request failed';
}

class DeviceTokenRepository {
  DeviceTokenRepository([SupabaseClient? client])
      : _remote = (AppConfig.hasSupabase && client != null)
            ? DeviceTokenRemoteDataSource(client)
            : null;

  final DeviceTokenRemoteDataSource? _remote;

  bool get isAvailable => _remote != null;

  Future<void> upsertToken({
    required String profileId,
    required String token,
    required String platform,
  }) async {
    final remote = _remote;
    if (remote == null) {
      return;
    }

    try {
      await remote.upsertToken(
        profileId: profileId,
        token: token,
        platform: platform,
      );
    } on PostgrestException catch (e) {
      throw DeviceTokenException(e.message);
    }
  }

  Future<void> deleteToken({
    required String profileId,
    required String token,
  }) async {
    final remote = _remote;
    if (remote == null) {
      return;
    }

    try {
      await remote.deleteToken(profileId: profileId, token: token);
    } on PostgrestException catch (e) {
      throw DeviceTokenException(e.message);
    }
  }

  Future<void> deleteAllForProfile(String profileId) async {
    final remote = _remote;
    if (remote == null) {
      return;
    }

    try {
      await remote.deleteAllForProfile(profileId);
    } on PostgrestException catch (e) {
      throw DeviceTokenException(e.message);
    }
  }
}

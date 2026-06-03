import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeviceTokenException implements Exception {
  const DeviceTokenException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Device token request failed';
}

class DeviceTokenRepository {
  DeviceTokenRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  Future<void> upsertToken({
    required String profileId,
    required String token,
    required String platform,
  }) async {
    if (!isAvailable) {
      return;
    }

    try {
      await _client!.from('device_tokens').upsert(
        {
          'profile_id': profileId,
          'token': token,
          'platform': platform,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        },
        onConflict: 'profile_id,token',
      );
    } on PostgrestException catch (e) {
      throw DeviceTokenException(e.message);
    }
  }

  Future<void> deleteToken({
    required String profileId,
    required String token,
  }) async {
    if (!isAvailable) {
      return;
    }

    try {
      await _client!
          .from('device_tokens')
          .delete()
          .eq('profile_id', profileId)
          .eq('token', token);
    } on PostgrestException catch (e) {
      throw DeviceTokenException(e.message);
    }
  }

  Future<void> deleteAllForProfile(String profileId) async {
    if (!isAvailable) {
      return;
    }

    try {
      await _client!
          .from('device_tokens')
          .delete()
          .eq('profile_id', profileId);
    } on PostgrestException catch (e) {
      throw DeviceTokenException(e.message);
    }
  }
}

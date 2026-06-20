import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for the `device_tokens` table (FCM registration).
class DeviceTokenRemoteDataSource {
  const DeviceTokenRemoteDataSource(this._client);

  final SupabaseClient _client;

  Future<void> upsertToken({
    required String profileId,
    required String token,
    required String platform,
  }) async {
    await _client.from('device_tokens').upsert(
      {
        'profile_id': profileId,
        'token': token,
        'platform': platform,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      },
      onConflict: 'profile_id,token',
    );
  }

  Future<void> deleteToken({
    required String profileId,
    required String token,
  }) async {
    await _client
        .from('device_tokens')
        .delete()
        .eq('profile_id', profileId)
        .eq('token', token);
  }

  Future<void> deleteAllForProfile(String profileId) async {
    await _client.from('device_tokens').delete().eq('profile_id', profileId);
  }
}

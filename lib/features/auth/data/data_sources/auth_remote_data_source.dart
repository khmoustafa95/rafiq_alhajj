import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for authentication and the `profiles` table.
///
/// Data sources own all [SupabaseClient] calls (including `auth`) and return
/// raw data. Error mapping to domain exceptions is the repository's
/// responsibility.
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const profileColumns = 'id, full_name, role, can_manage_admins';

  Stream<AuthState> authStateChanges() => _client.auth.onAuthStateChange;

  String? get currentUserId => _client.auth.currentSession?.user.id;

  Future<User?> signInWithPassword({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response.user;
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<void> invokeDeleteMyAccount() async {
    await _client.functions.invoke('delete-my-account');
  }

  Future<Map<String, dynamic>?> fetchProfile(String userId) async {
    final data = await _client
        .from('profiles')
        .select(profileColumns)
        .eq('id', userId)
        .maybeSingle();
    if (data == null) {
      return null;
    }
    return Map<String, dynamic>.from(data);
  }
}

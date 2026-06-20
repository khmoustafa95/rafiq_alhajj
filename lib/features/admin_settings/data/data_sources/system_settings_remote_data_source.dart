import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for the singleton `system_settings` row.
class SystemSettingsRemoteDataSource {
  const SystemSettingsRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const globalId = 'global';

  static const columns =
      'organization_name, support_email, support_phone, hajj_season_label, '
      'registration_open, maintenance_mode, maintenance_message, '
      'require_documents_on_intake, auto_generate_pilgrim_password, '
      'allow_operator_self_registration, enable_public_content_feed, '
      'enable_competitions, enable_push_notifications, enable_in_app_notifications, '
      'pilgrim_ritual_tracking_enabled, max_pilgrims_per_group, updated_at';

  String? get currentUserId => _client.auth.currentUser?.id;

  Future<Map<String, dynamic>?> fetch() async {
    final row = await _client
        .from('system_settings')
        .select(columns)
        .eq('id', globalId)
        .maybeSingle();
    return row == null ? null : Map<String, dynamic>.from(row);
  }

  Future<Map<String, dynamic>> update(Map<String, dynamic> payload) async {
    final row = await _client
        .from('system_settings')
        .update(payload)
        .eq('id', globalId)
        .select(columns)
        .single();
    return Map<String, dynamic>.from(row);
  }
}

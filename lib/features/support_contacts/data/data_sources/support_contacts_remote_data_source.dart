import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for the `support_contacts` table.
class SupportContactsRemoteDataSource {
  const SupportContactsRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const columns =
      'id, label_ar, label_en, description_ar, description_en, '
      'phone_number, whatsapp_number, scope, group_id, is_active, sort_order, '
      'groups(name)';

  String? get currentUserId => _client.auth.currentUser?.id;

  /// Visible-to-caller contacts (RLS filters by scope/group); active only.
  Future<List<Map<String, dynamic>>> fetchVisible() async {
    final rows = await _client
        .from('support_contacts')
        .select(columns)
        .eq('is_active', true)
        .order('sort_order')
        .order('label_ar');
    return _asMaps(rows);
  }

  /// Every contact (admin view).
  Future<List<Map<String, dynamic>>> fetchAll() async {
    final rows = await _client
        .from('support_contacts')
        .select(columns)
        .order('scope')
        .order('sort_order')
        .order('label_ar');
    return _asMaps(rows);
  }

  Future<void> insert(Map<String, dynamic> payload) async {
    await _client.from('support_contacts').insert(payload);
  }

  Future<void> update(String id, Map<String, dynamic> payload) async {
    await _client.from('support_contacts').update(payload).eq('id', id);
  }

  Future<void> delete(String id) async {
    await _client.from('support_contacts').delete().eq('id', id);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

import 'dart:typed_data';

import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/utils/postgrest_search_sanitize.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for group management (`groups`,
/// `group_administration_members`, and the `group-assets` storage bucket).
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Mapping to
/// domain models is the repository's responsibility (see
/// `AdminGroupsRepository`).
class AdminGroupsRemoteDataSource {
  const AdminGroupsRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const groupSelect =
      'id, name, code, logo_url, president_name, president_phone, '
      'created_at, updated_at, '
      'group_administration_members(id, name, position, contact, photo_url, sort_order)';

  Future<({List<Map<String, dynamic>> rows, int count})> fetchPage(
    StaffTableQuery query,
  ) async {
    var request = _client.from('groups').select(groupSelect);

    final search = query.search.trim();
    if (search.isNotEmpty) {
      final term = sanitizePostgrestSearchTerm(search);
      request = request.or(
        'name.ilike.%$term%,president_name.ilike.%$term%,code.ilike.%$term%',
      );
    }

    final sortColumn = switch (query.sortColumnId) {
      'president_name' => 'president_name',
      'code' => 'code',
      'created_at' => 'created_at',
      _ => 'name',
    };

    final response = await request
        .order(sortColumn, ascending: query.sortAscending)
        .range(query.from, query.to)
        .count(CountOption.exact);

    return (rows: _asMaps(response.data), count: response.count);
  }

  Future<Map<String, dynamic>> fetchById(String id) async {
    final row = await _client
        .from('groups')
        .select(groupSelect)
        .eq('id', id)
        .single();
    return Map<String, dynamic>.from(row);
  }

  Future<void> updateGroup(String id, Map<String, dynamic> payload) async {
    await _client.from('groups').update(payload).eq('id', id);
  }

  Future<Map<String, dynamic>> insertGroup(Map<String, dynamic> payload) async {
    final row =
        await _client.from('groups').insert(payload).select('id').single();
    return Map<String, dynamic>.from(row);
  }

  Future<Map<String, dynamic>?> findGroupByCode(String code) async {
    final row = await _client
        .from('groups')
        .select('id')
        .eq('code', code)
        .maybeSingle();
    return row == null ? null : Map<String, dynamic>.from(row);
  }

  Future<void> delete(String id) async {
    await _client.from('groups').delete().eq('id', id);
  }

  Future<void> deleteAdministrationMembers(String groupId) async {
    await _client
        .from('group_administration_members')
        .delete()
        .eq('group_id', groupId);
  }

  Future<void> insertAdministrationMembers(
    List<Map<String, dynamic>> rows,
  ) async {
    await _client.from('group_administration_members').insert(rows);
  }

  Future<String> uploadAsset({
    required String groupId,
    required String folder,
    required String fileName,
    required Uint8List bytes,
  }) async {
    final safeName = fileName.replaceAll(RegExp(r'[^\w.\-]'), '_');
    final path =
        '$groupId/$folder/${DateTime.now().millisecondsSinceEpoch}_$safeName';

    await _client.storage.from('group-assets').uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(upsert: true),
        );

    return _client.storage.from('group-assets').getPublicUrl(path);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/utils/postgrest_search_sanitize.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for operator account management (`profiles`,
/// `operator_group_access`, and the `manage-operator` edge function).
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Mapping to
/// domain models is the repository's responsibility (see
/// `AdminOperatorsRepository`).
class AdminOperatorsRemoteDataSource {
  const AdminOperatorsRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const operatorSelect =
      'id, full_name, email, is_active, operator_permissions, updated_at';

  Future<({List<Map<String, dynamic>> rows, int count})> fetchOperatorsPage(
    StaffTableQuery query,
  ) async {
    var request = _client
        .from('profiles')
        .select(operatorSelect)
        .eq('role', 'operator');

    final search = query.search.trim();
    if (search.isNotEmpty) {
      final term = sanitizePostgrestSearchTerm(search);
      request = request.or('full_name.ilike.%$term%,email.ilike.%$term%');
    }

    final status = query.filters['status'];
    if (status == 'active') {
      request = request.eq('is_active', true);
    } else if (status == 'inactive') {
      request = request.eq('is_active', false);
    }

    final sortColumn = switch (query.sortColumnId) {
      'email' => 'email',
      'is_active' => 'is_active',
      'updated_at' => 'updated_at',
      _ => 'full_name',
    };

    final response = await request
        .order(sortColumn, ascending: query.sortAscending)
        .range(query.from, query.to)
        .count(CountOption.exact);

    return (rows: _asMaps(response.data), count: response.count);
  }

  Future<Map<String, dynamic>> fetchOperator(String id) async {
    final row = await _client
        .from('profiles')
        .select(operatorSelect)
        .eq('id', id)
        .eq('role', 'operator')
        .single();
    return Map<String, dynamic>.from(row);
  }

  Future<List<Map<String, dynamic>>> fetchGroupGrants(String operatorId) async {
    final rows = await _client
        .from('operator_group_access')
        .select('group_id, can_write')
        .eq('operator_id', operatorId);
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchGroupOptions() async {
    final rows = await _client.from('groups').select('id, name').order('name');
    return _asMaps(rows);
  }

  Future<void> deleteGroupAccess(String operatorId) async {
    await _client
        .from('operator_group_access')
        .delete()
        .eq('operator_id', operatorId);
  }

  Future<void> insertGroupAccess(List<Map<String, dynamic>> rows) async {
    await _client.from('operator_group_access').insert(rows);
  }

  Future<FunctionResponse> invokeManageOperator(
    Map<String, dynamic> body,
  ) async {
    return _client.functions.invoke('manage-operator', body: body);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

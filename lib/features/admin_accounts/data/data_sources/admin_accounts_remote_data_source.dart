import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/utils/postgrest_search_sanitize.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for admin account listing and promotion.
class AdminAccountsRemoteDataSource {
  const AdminAccountsRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const adminSelect =
      'id, full_name, email, can_manage_admins, is_active, updated_at';

  Future<({List<Map<String, dynamic>> rows, int count})> fetchAdminsPage(
    StaffTableQuery query,
  ) async {
    var request = _client
        .from('profiles')
        .select(adminSelect)
        .eq('role', 'admin');

    final search = query.search.trim();
    if (search.isNotEmpty) {
      final term = sanitizePostgrestSearchTerm(search);
      request = request.or('full_name.ilike.%$term%,email.ilike.%$term%');
    }

    final sortColumn = switch (query.sortColumnId) {
      'email' => 'email',
      'can_manage_admins' => 'can_manage_admins',
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

  Future<FunctionResponse> invokePromoteToAdmin(String profileId) async {
    return _client.functions.invoke(
      'promote-to-admin',
      body: {'profile_id': profileId},
    );
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

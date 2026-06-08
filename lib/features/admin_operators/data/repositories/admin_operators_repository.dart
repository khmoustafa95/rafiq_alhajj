import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/utils/postgrest_search_sanitize.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/created_operator_account.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_account.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_editor_input.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_permissions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminOperatorsException implements Exception {
  const AdminOperatorsException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Operator management request failed';
}

class AdminOperatorsRepository {
  AdminOperatorsRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  static const _operatorSelect =
      'id, full_name, email, is_active, operator_permissions, updated_at';

  Future<List<OperatorAccount>> fetchOperators() async {
    final page = await fetchOperatorsPage(
      const StaffTableQuery(pageSize: 1000),
    );
    return page.items;
  }

  Future<PaginatedResult<OperatorAccount>> fetchOperatorsPage(
    StaffTableQuery query,
  ) async {
    if (!isAvailable) {
      throw const AdminOperatorsException('Supabase is not configured');
    }

    try {
      var request = _client!
          .from('profiles')
          .select(_operatorSelect)
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

      final rows = response.data as List<dynamic>;
      return PaginatedResult(
        items: rows.map(_rowToAccount).toList(),
        totalCount: response.count,
        pageSize: query.pageSize,
      );
    } on PostgrestException catch (e) {
      throw AdminOperatorsException(e.message);
    }
  }

  Future<OperatorAccount> fetchOperator(String id) async {
    if (!isAvailable) {
      throw const AdminOperatorsException('Supabase is not configured');
    }

    try {
      final row = await _client!
          .from('profiles')
          .select(_operatorSelect)
          .eq('id', id)
          .eq('role', 'operator')
          .single();

      return _rowToAccount(row);
    } on PostgrestException catch (e) {
      throw AdminOperatorsException(e.message);
    }
  }

  Future<CreatedOperatorAccount> createOperator(
    OperatorEditorInput input,
  ) async {
    if (!isAvailable) {
      throw const AdminOperatorsException('Supabase is not configured');
    }

    try {
      final response = await _client!.functions.invoke(
        'manage-operator',
        body: {
          'action': 'create',
          'email': input.email.trim(),
          'full_name': input.fullName.trim(),
          if (input.password?.trim().isNotEmpty ?? false)
            'password': input.password!.trim(),
          'is_active': input.isActive,
          'operator_permissions': input.permissions.toJson(),
        },
      );

      if (response.status != 200) {
        final error = response.data is Map
            ? (response.data as Map)['error']?.toString()
            : null;
        throw AdminOperatorsException(
          error ?? 'Failed to create operator account',
        );
      }

      final data = Map<String, dynamic>.from(response.data as Map);
      return CreatedOperatorAccount(
        profileId: data['profile_id'] as String,
        email: data['email'] as String,
        password: data['password'] as String,
      );
    } on AdminOperatorsException {
      rethrow;
    } on FunctionException catch (e) {
      throw AdminOperatorsException(e.reasonPhrase ?? 'Edge function error');
    }
  }

  Future<void> updateOperator(OperatorEditorInput input) async {
    if (!isAvailable) {
      throw const AdminOperatorsException('Supabase is not configured');
    }

    if (input.id == null) {
      throw const AdminOperatorsException('Operator id is required');
    }

    try {
      final body = <String, dynamic>{
        'action': 'update',
        'profile_id': input.id,
        'full_name': input.fullName.trim(),
        'email': input.email.trim(),
        'is_active': input.isActive,
        'operator_permissions': input.permissions.toJson(),
      };

      if (input.password?.trim().isNotEmpty ?? false) {
        body['password'] = input.password!.trim();
      }

      final response = await _client!.functions.invoke(
        'manage-operator',
        body: body,
      );

      if (response.status != 200) {
        final error = response.data is Map
            ? (response.data as Map)['error']?.toString()
            : null;
        throw AdminOperatorsException(
          error ?? 'Failed to update operator account',
        );
      }
    } on AdminOperatorsException {
      rethrow;
    } on FunctionException catch (e) {
      throw AdminOperatorsException(e.reasonPhrase ?? 'Edge function error');
    }
  }

  OperatorAccount _rowToAccount(dynamic row) {
    final map = Map<String, dynamic>.from(row as Map);
    final permsRaw = map['operator_permissions'];
    return OperatorAccount(
      id: map['id'] as String,
      fullName: map['full_name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      isActive: map['is_active'] as bool? ?? true,
      permissions: OperatorPermissions.fromJson(
        permsRaw is Map ? Map<String, dynamic>.from(permsRaw) : null,
      ),
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'] as String)
          : null,
    );
  }
}

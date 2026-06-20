import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/features/admin_operators/data/data_sources/admin_operators_remote_data_source.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/created_operator_account.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_account.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_editor_input.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_group_grant.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_permissions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminOperatorsException implements Exception {
  const AdminOperatorsException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Operator management request failed';
}

class AdminOperatorsRepository {
  AdminOperatorsRepository([SupabaseClient? client])
      : _remote =
            client == null ? null : AdminOperatorsRemoteDataSource(client);

  final AdminOperatorsRemoteDataSource? _remote;

  bool get isAvailable => AppConfig.hasSupabase && _remote != null;

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
    final remote = _remote!;
    try {
      final result = await remote.fetchOperatorsPage(query);
      return PaginatedResult(
        items: result.rows.map(_rowToAccount).toList(),
        totalCount: result.count,
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
    final remote = _remote!;
    try {
      final row = await remote.fetchOperator(id);

      final grants = await remote.fetchGroupGrants(id);
      final groupAccess = grants
          .map(
            (raw) => OperatorGroupGrant(
              groupId: raw['group_id'] as String,
              canWrite: raw['can_write'] as bool? ?? false,
            ),
          )
          .toList();

      return _rowToAccount(row, groupAccess: groupAccess);
    } on PostgrestException catch (e) {
      throw AdminOperatorsException(e.message);
    }
  }

  Future<List<OperatorGroupOption>> fetchGroupOptions() async {
    if (!isAvailable) {
      return const [];
    }
    final remote = _remote!;
    try {
      final rows = await remote.fetchGroupOptions();
      return rows
          .map(
            (raw) => OperatorGroupOption(
              id: raw['id'] as String,
              name: raw['name'] as String,
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw AdminOperatorsException(e.message);
    }
  }

  /// Replaces the operator's group grants with [grants].
  Future<void> _setGroupAccess(
    AdminOperatorsRemoteDataSource remote,
    String operatorId,
    List<OperatorGroupGrant> grants,
  ) async {
    await remote.deleteGroupAccess(operatorId);

    if (grants.isEmpty) {
      return;
    }

    await remote.insertGroupAccess([
      for (final grant in grants)
        {
          'operator_id': operatorId,
          'group_id': grant.groupId,
          'can_write': grant.canWrite,
        },
    ]);
  }

  Future<CreatedOperatorAccount> createOperator(
    OperatorEditorInput input,
  ) async {
    if (!isAvailable) {
      throw const AdminOperatorsException('Supabase is not configured');
    }
    final remote = _remote!;
    try {
      final response = await remote.invokeManageOperator({
        'action': 'create',
        'email': input.email.trim(),
        'full_name': input.fullName.trim(),
        if (input.password?.trim().isNotEmpty ?? false)
          'password': input.password!.trim(),
        'is_active': input.isActive,
        'operator_permissions': input.permissions.toJson(),
      });

      if (response.status != 200) {
        final error = response.data is Map
            ? (response.data as Map)['error']?.toString()
            : null;
        throw AdminOperatorsException(
          error ?? 'Failed to create operator account',
        );
      }

      final data = Map<String, dynamic>.from(response.data as Map);
      final profileId = data['profile_id'] as String;
      await _setGroupAccess(remote, profileId, input.groupAccess);
      return CreatedOperatorAccount(
        profileId: profileId,
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
    final remote = _remote!;
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

      final response = await remote.invokeManageOperator(body);

      if (response.status != 200) {
        final error = response.data is Map
            ? (response.data as Map)['error']?.toString()
            : null;
        throw AdminOperatorsException(
          error ?? 'Failed to update operator account',
        );
      }

      await _setGroupAccess(remote, input.id!, input.groupAccess);
    } on AdminOperatorsException {
      rethrow;
    } on FunctionException catch (e) {
      throw AdminOperatorsException(e.reasonPhrase ?? 'Edge function error');
    }
  }

  OperatorAccount _rowToAccount(
    dynamic row, {
    List<OperatorGroupGrant> groupAccess = const [],
  }) {
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
      groupAccess: groupAccess,
    );
  }
}

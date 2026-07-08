import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/features/admin_accounts/data/data_sources/admin_accounts_remote_data_source.dart';
import 'package:rafiq_alhajj/features/admin_accounts/domain/models/admin_account.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminAccountsException implements Exception {
  const AdminAccountsException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Admin account request failed';
}

class AdminAccountsRepository {
  AdminAccountsRepository([SupabaseClient? client])
      : _remote =
            client == null ? null : AdminAccountsRemoteDataSource(client);

  final AdminAccountsRemoteDataSource? _remote;

  bool get isAvailable => AppConfig.hasSupabase && _remote != null;

  Future<PaginatedResult<AdminAccount>> fetchAdminsPage(
    StaffTableQuery query,
  ) async {
    if (!isAvailable) {
      throw const AdminAccountsException('Supabase is not configured');
    }
    final remote = _remote!;
    try {
      final result = await remote.fetchAdminsPage(query);
      return PaginatedResult(
        items: result.rows.map(_rowToAccount).toList(),
        totalCount: result.count,
        pageSize: query.pageSize,
      );
    } on PostgrestException catch (e) {
      throw AdminAccountsException(e.message);
    }
  }

  Future<void> promoteOperator(String profileId) async {
    if (!isAvailable) {
      throw const AdminAccountsException('Supabase is not configured');
    }
    final remote = _remote!;
    try {
      final response = await remote.invokePromoteToAdmin(profileId);
      if (response.status != 200) {
        final error = response.data is Map
            ? (response.data as Map)['error']?.toString()
            : null;
        throw AdminAccountsException(
          error ?? 'Failed to promote operator to admin',
        );
      }
    } on AdminAccountsException {
      rethrow;
    } on FunctionException catch (e) {
      throw AdminAccountsException(e.reasonPhrase ?? 'Edge function error');
    }
  }

  AdminAccount _rowToAccount(dynamic row) {
    final map = Map<String, dynamic>.from(row as Map);
    return AdminAccount(
      id: map['id'] as String,
      fullName: map['full_name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      canManageAdmins: map['can_manage_admins'] as bool? ?? false,
      isActive: map['is_active'] as bool? ?? true,
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'] as String)
          : null,
    );
  }
}

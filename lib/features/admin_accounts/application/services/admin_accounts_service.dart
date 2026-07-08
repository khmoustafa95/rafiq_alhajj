import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/features/admin_accounts/data/repositories/admin_accounts_repository.dart';
import 'package:rafiq_alhajj/features/admin_accounts/domain/models/admin_account.dart';

class AdminAccountsService {
  AdminAccountsService(this._repository);

  final AdminAccountsRepository _repository;

  Future<PaginatedResult<AdminAccount>> listPage(StaffTableQuery query) =>
      _repository.fetchAdminsPage(query);

  Future<void> promoteOperator(String profileId) =>
      _repository.promoteOperator(profileId);
}

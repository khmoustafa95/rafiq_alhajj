import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/features/admin_operators/data/repositories/admin_operators_repository.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/created_operator_account.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_account.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_editor_input.dart';
import 'package:rafiq_alhajj/features/admin_operators/domain/models/operator_group_grant.dart';

class AdminOperatorsService {
  AdminOperatorsService(this._repository);

  final AdminOperatorsRepository _repository;

  Future<List<OperatorAccount>> listOperators() =>
      _repository.fetchOperators();

  Future<List<OperatorGroupOption>> listGroupOptions() =>
      _repository.fetchGroupOptions();

  Future<PaginatedResult<OperatorAccount>> listPage(StaffTableQuery query) =>
      _repository.fetchOperatorsPage(query);

  Future<OperatorAccount> getOperator(String id) =>
      _repository.fetchOperator(id);

  Future<CreatedOperatorAccount> create(OperatorEditorInput input) =>
      _repository.createOperator(input);

  Future<void> update(OperatorEditorInput input) =>
      _repository.updateOperator(input);
}

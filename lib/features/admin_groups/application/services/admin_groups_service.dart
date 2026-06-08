import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/features/admin_groups/data/repositories/admin_groups_repository.dart';
import 'package:rafiq_alhajj/features/admin_groups/domain/models/group_editor_input.dart';
import 'package:rafiq_alhajj/features/admin_groups/domain/models/hajj_group.dart';

class AdminGroupsService {
  AdminGroupsService(this._repository);

  final AdminGroupsRepository _repository;

  Future<PaginatedResult<HajjGroup>> listPage(StaffTableQuery query) =>
      _repository.fetchPage(query);

  Future<HajjGroup> getGroup(String id) => _repository.fetchById(id);

  Future<HajjGroup> save(GroupEditorInput input) => _repository.save(input);

  Future<bool> remove(String id) => _repository.delete(id);
}

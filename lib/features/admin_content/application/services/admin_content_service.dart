import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/features/admin_content/data/repositories/admin_content_repository.dart';
import 'package:rafiq_alhajj/features/admin_content/domain/models/content_editor_input.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';

class AdminContentService {
  const AdminContentService(this._repository);

  final AdminContentRepository _repository;

  Future<PaginatedResult<ContentItem>> listPage(StaffTableQuery query) =>
      _repository.fetchPage(query);

  Future<ContentItem?> getById(String id) => _repository.fetchById(id);

  Future<ContentItem> save(ContentEditorInput input) =>
      _repository.upsert(input);

  Future<void> remove(String id) => _repository.delete(id);
}

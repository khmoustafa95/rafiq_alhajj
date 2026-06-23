import 'package:rafiq_alhajj/features/support_contacts/data/repositories/support_contacts_repository.dart';
import 'package:rafiq_alhajj/features/support_contacts/domain/models/support_contact.dart';
import 'package:rafiq_alhajj/features/support_contacts/domain/models/support_contact_input.dart';

class SupportContactsService {
  SupportContactsService(this._repository);

  final SupportContactsRepository _repository;

  Future<List<SupportContact>> loadVisible() => _repository.fetchVisible();

  Future<List<SupportContact>> loadAll() => _repository.fetchAll();

  Future<void> save(SupportContactInput input) => _repository.save(input);

  Future<void> remove(String id) => _repository.remove(id);
}

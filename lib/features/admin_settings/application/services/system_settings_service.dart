import 'package:rafiq_alhajj/features/admin_settings/data/repositories/system_settings_repository.dart';
import 'package:rafiq_alhajj/features/admin_settings/domain/models/system_settings.dart';
import 'package:rafiq_alhajj/features/admin_settings/domain/models/system_settings_input.dart';

class SystemSettingsService {
  SystemSettingsService(this._repository);

  final SystemSettingsRepository _repository;

  Future<SystemSettings> load() => _repository.fetch();

  Future<SystemSettings> save(SystemSettingsInput input) =>
      _repository.save(input);
}

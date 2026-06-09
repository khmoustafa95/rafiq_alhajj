import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_attach.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_providers.dart';
import 'package:rafiq_alhajj/features/admin_settings/application/services/system_settings_service.dart';
import 'package:rafiq_alhajj/features/admin_settings/data/repositories/system_settings_repository.dart';
import 'package:rafiq_alhajj/features/admin_settings/domain/models/system_settings.dart';
import 'package:rafiq_alhajj/features/admin_settings/domain/models/system_settings_input.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'system_settings_providers.g.dart';

@Riverpod(keepAlive: true)
SystemSettingsRepository systemSettingsRepository(Ref ref) {
  return SystemSettingsRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
SystemSettingsService systemSettingsService(Ref ref) {
  return SystemSettingsService(ref.watch(systemSettingsRepositoryProvider));
}

@riverpod
Future<SystemSettings> systemSettings(Ref ref) async {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.systemSettings,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncSystemSettingsProvider),
    handlerId: 'system_settings',
    onInvalidate: (ref) => ref.invalidate(systemSettingsProvider),
  );

  return ref.read(systemSettingsServiceProvider).load();
}

@riverpod
class SystemSettingsSave extends _$SystemSettingsSave {
  @override
  FutureOr<void> build() {}

  Future<bool> save(SystemSettingsInput input) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(systemSettingsServiceProvider).save(input);
      ref.invalidate(systemSettingsProvider);
    });
    return !state.hasError;
  }
}

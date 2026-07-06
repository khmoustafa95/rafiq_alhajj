import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_attach.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_providers.dart';
import 'package:rafiq_alhajj/features/app_version/application/services/app_version_service.dart';
import 'package:rafiq_alhajj/features/app_version/application/services/optional_update_dismiss_store.dart';
import 'package:rafiq_alhajj/features/app_version/data/repositories/app_version_repository.dart';
import 'package:rafiq_alhajj/features/app_version/domain/models/app_version_policy.dart';
import 'package:rafiq_alhajj/features/app_version/domain/models/app_version_policy_input.dart';
import 'package:rafiq_alhajj/features/app_version/domain/models/version_check_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'app_version_providers.g.dart';

@Riverpod(keepAlive: true)
AppVersionRepository appVersionRepository(Ref ref) {
  return AppVersionRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
AppVersionService appVersionService(Ref ref) {
  return AppVersionService(
    ref.watch(appVersionRepositoryProvider),
    const OptionalUpdateDismissStore(),
  );
}

@riverpod
Future<VersionCheckResult> appVersionCheck(Ref ref) async {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.appVersion,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncAppVersionProvider),
    handlerId: 'app_version_check',
    onInvalidate: (ref) => ref.invalidate(appVersionCheckProvider),
  );

  return ref.read(appVersionServiceProvider).checkForUpdates();
}

@riverpod
Future<List<AppVersionPolicy>> appVersionPolicies(Ref ref) async {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.appVersion,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncAppVersionProvider),
    handlerId: 'app_version_policies',
    onInvalidate: (ref) => ref.invalidate(appVersionPoliciesProvider),
  );

  return ref.read(appVersionRepositoryProvider).fetchAll();
}

@riverpod
Future<String> appCurrentVersion(Ref ref) {
  return ref.read(appVersionServiceProvider).readCurrentVersion();
}

@riverpod
class AppVersionPolicySave extends _$AppVersionPolicySave {
  @override
  FutureOr<void> build() {}

  Future<bool> save(AppVersionPolicyInput input) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(appVersionRepositoryProvider).save(input);
      ref.invalidate(appVersionPoliciesProvider);
      ref.invalidate(appVersionCheckProvider);
    });
    return !state.hasError;
  }
}

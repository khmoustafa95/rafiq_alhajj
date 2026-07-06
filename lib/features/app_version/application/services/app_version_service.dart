import 'package:package_info_plus/package_info_plus.dart';
import 'package:rafiq_alhajj/core/platform/app_runtime_platform.dart';
import 'package:rafiq_alhajj/core/utils/semantic_version.dart';
import 'package:rafiq_alhajj/features/app_version/application/services/optional_update_dismiss_store.dart';
import 'package:rafiq_alhajj/features/app_version/data/repositories/app_version_repository.dart';
import 'package:rafiq_alhajj/features/app_version/domain/models/app_version_policy.dart';
import 'package:rafiq_alhajj/features/app_version/domain/models/version_check_result.dart';

class AppVersionService {
  const AppVersionService(this._repository, [this._dismissStore]);

  final AppVersionRepository _repository;
  final OptionalUpdateDismissStore? _dismissStore;

  Future<String> readCurrentVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
  }

  Future<VersionCheckResult> checkForUpdates() async {
    final currentVersion = await readCurrentVersion();
    final platform = AppRuntimePlatform.current.storageKey;

    if (!_repository.isAvailable) {
      return VersionCheckResult.upToDate(currentVersion: currentVersion);
    }

    final policy = await _repository.fetchForPlatform(platform);
    if (policy == null) {
      return VersionCheckResult.upToDate(currentVersion: currentVersion);
    }

    if (!SemanticVersion.isValid(policy.minVersion) ||
        !SemanticVersion.isValid(policy.latestVersion)) {
      return VersionCheckResult.upToDate(currentVersion: currentVersion);
    }

    if (SemanticVersion.compare(currentVersion, policy.minVersion) < 0) {
      return VersionCheckResult(
        kind: VersionUpdateKind.forceRequired,
        currentVersion: currentVersion,
        policy: policy,
      );
    }

    if (SemanticVersion.compare(currentVersion, policy.latestVersion) < 0) {
      final store = _dismissStore;
      if (store != null) {
        final dismissed = await store.wasDismissed(
          platform,
          policy.latestVersion,
        );
        if (dismissed) {
          return VersionCheckResult.upToDate(currentVersion: currentVersion);
        }
      }
      return VersionCheckResult(
        kind: VersionUpdateKind.optional,
        currentVersion: currentVersion,
        policy: policy,
      );
    }

    return VersionCheckResult.upToDate(currentVersion: currentVersion);
  }

  Future<void> dismissOptionalUpdate(AppVersionPolicy policy) async {
    final store = _dismissStore;
    if (store == null) {
      return;
    }
    await store.dismiss(policy.platform, policy.latestVersion);
  }
}

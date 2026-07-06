import 'package:rafiq_alhajj/features/app_version/domain/models/app_version_policy.dart';

enum VersionUpdateKind {
  upToDate,
  optional,
  forceRequired,
}

class VersionCheckResult {
  const VersionCheckResult({
    required this.kind,
    required this.currentVersion,
    this.policy,
  });

  const VersionCheckResult.upToDate({required this.currentVersion})
      : kind = VersionUpdateKind.upToDate,
        policy = null;

  final VersionUpdateKind kind;
  final String currentVersion;
  final AppVersionPolicy? policy;

  bool get requiresForceUpdate => kind == VersionUpdateKind.forceRequired;

  bool get hasOptionalUpdate => kind == VersionUpdateKind.optional;
}

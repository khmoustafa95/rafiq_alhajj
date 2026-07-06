class AppVersionPolicyInput {
  const AppVersionPolicyInput({
    required this.platform,
    required this.minVersion,
    required this.latestVersion,
    this.storeUrl,
    this.releaseNotesAr,
    this.releaseNotesEn,
  });

  final String platform;
  final String minVersion;
  final String latestVersion;
  final String? storeUrl;
  final String? releaseNotesAr;
  final String? releaseNotesEn;
}

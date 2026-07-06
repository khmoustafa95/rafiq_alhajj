class AppVersionPolicy {
  const AppVersionPolicy({
    required this.platform,
    required this.minVersion,
    required this.latestVersion,
    this.storeUrl,
    this.releaseNotesAr,
    this.releaseNotesEn,
    this.updatedAt,
  });

  final String platform;
  final String minVersion;
  final String latestVersion;
  final String? storeUrl;
  final String? releaseNotesAr;
  final String? releaseNotesEn;
  final DateTime? updatedAt;
}

class SystemSettingsInput {
  const SystemSettingsInput({
    required this.organizationName,
    this.supportEmail,
    this.supportPhone,
    this.hajjSeasonLabel,
    required this.registrationOpen,
    required this.maintenanceMode,
    this.maintenanceMessage,
    required this.requireDocumentsOnIntake,
    required this.autoGeneratePilgrimPassword,
    required this.allowOperatorSelfRegistration,
    required this.enablePublicContentFeed,
    required this.enableCompetitions,
    required this.enablePushNotifications,
    required this.enableInAppNotifications,
    required this.pilgrimRitualTrackingEnabled,
    this.maxPilgrimsPerGroup,
  });

  final String organizationName;
  final String? supportEmail;
  final String? supportPhone;
  final String? hajjSeasonLabel;
  final bool registrationOpen;
  final bool maintenanceMode;
  final String? maintenanceMessage;
  final bool requireDocumentsOnIntake;
  final bool autoGeneratePilgrimPassword;
  final bool allowOperatorSelfRegistration;
  final bool enablePublicContentFeed;
  final bool enableCompetitions;
  final bool enablePushNotifications;
  final bool enableInAppNotifications;
  final bool pilgrimRitualTrackingEnabled;
  final int? maxPilgrimsPerGroup;
}

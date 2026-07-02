enum ContentPublicationStatus {
  draft,
  published;

  String get databaseValue => name;

  static ContentPublicationStatus fromDatabase(String value) {
    return ContentPublicationStatus.values.firstWhere(
      (s) => s.name == value,
      orElse: () => ContentPublicationStatus.published,
    );
  }
}

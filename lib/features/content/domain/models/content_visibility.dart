enum ContentVisibility {
  public,
  pilgrimOnly;

  static ContentVisibility fromDatabase(String value) {
    return value == 'pilgrim_only'
        ? ContentVisibility.pilgrimOnly
        : ContentVisibility.public;
  }

  String get databaseValue =>
      this == ContentVisibility.pilgrimOnly ? 'pilgrim_only' : 'public';
}

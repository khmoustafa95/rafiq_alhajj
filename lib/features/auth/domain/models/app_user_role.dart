/// Backend role stored on [UserProfile].
enum AppUserRole {
  pilgrim,
  operator,
  admin;

  static AppUserRole fromDatabase(String value) {
    return switch (value) {
      'operator' => AppUserRole.operator,
      'admin' => AppUserRole.admin,
      _ => AppUserRole.pilgrim,
    };
  }

  String get databaseValue => name;
}

/// UI access mode across mobile (guest/pilgrim), web (operator/admin), field (operator).
enum AppAccessMode {
  guest,
  pilgrim,
  operator,
  admin,
}

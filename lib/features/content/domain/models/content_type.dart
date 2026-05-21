enum ContentType {
  video,
  news,
  announcement;

  static ContentType fromDatabase(String value) {
    return switch (value) {
      'news' => ContentType.news,
      'announcement' => ContentType.announcement,
      _ => ContentType.video,
    };
  }

  String get databaseValue => name;
}

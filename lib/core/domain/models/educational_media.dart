enum EducationalMediaType {
  video,
  audio,
  image,
  pdf;

  static EducationalMediaType typeFromKey(String value) {
    return switch (value) {
      'video' => EducationalMediaType.video,
      'audio' => EducationalMediaType.audio,
      'image' => EducationalMediaType.image,
      'pdf' => EducationalMediaType.pdf,
      _ => EducationalMediaType.image,
    };
  }
}

class EducationalMediaItem {
  const EducationalMediaItem({
    required this.id,
    required this.mediaType,
    required this.url,
    this.title,
    this.sortOrder = 0,
  });

  final String id;
  final EducationalMediaType mediaType;
  final String? title;
  final String url;
  final int sortOrder;

  static EducationalMediaType typeFromKey(String value) {
    return switch (value) {
      'video' => EducationalMediaType.video,
      'audio' => EducationalMediaType.audio,
      'image' => EducationalMediaType.image,
      'pdf' => EducationalMediaType.pdf,
      _ => EducationalMediaType.image,
    };
  }

  String get typeKey => switch (mediaType) {
        EducationalMediaType.video => 'video',
        EducationalMediaType.audio => 'audio',
        EducationalMediaType.image => 'image',
        EducationalMediaType.pdf => 'pdf',
      };
}

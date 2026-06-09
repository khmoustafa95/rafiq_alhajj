enum HajjMediaType {
  video,
  audio,
  image,
}

class HajjJourneyMedia {
  const HajjJourneyMedia({
    required this.id,
    required this.mediaType,
    required this.url,
    this.title,
    this.sortOrder = 0,
  });

  final String id;
  final HajjMediaType mediaType;
  final String? title;
  final String url;
  final int sortOrder;

  static HajjMediaType mediaTypeFromString(String value) {
    return switch (value) {
      'video' => HajjMediaType.video,
      'audio' => HajjMediaType.audio,
      'image' => HajjMediaType.image,
      _ => HajjMediaType.image,
    };
  }

  String get mediaTypeKey => switch (mediaType) {
        HajjMediaType.video => 'video',
        HajjMediaType.audio => 'audio',
        HajjMediaType.image => 'image',
      };
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'hajj_journey_media.freezed.dart';

enum HajjMediaType {
  video,
  audio,
  image,
}

@freezed
abstract class HajjJourneyMedia with _$HajjJourneyMedia {
  const factory HajjJourneyMedia({
    required String id,
    required HajjMediaType mediaType,
    required String url,
    String? title,
    @Default(0) int sortOrder,
  }) = _HajjJourneyMedia;

  const HajjJourneyMedia._();

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

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';

part 'content_topic.freezed.dart';

@freezed
abstract class ContentTopicMedia with _$ContentTopicMedia {
  const factory ContentTopicMedia({
    required String id,
    required EducationalMediaType mediaType,
    required String url,
    String? title,
    @Default(0) int sortOrder,
  }) = _ContentTopicMedia;

  const ContentTopicMedia._();

  EducationalMediaItem toEducationalMedia() => EducationalMediaItem(
        id: id,
        mediaType: mediaType,
        title: title,
        url: url,
        sortOrder: sortOrder,
      );
}

@freezed
abstract class ContentTopic with _$ContentTopic {
  const factory ContentTopic({
    required String id,
    required String title,
    String? description,
    String? coverImageUrl,
    required ContentVisibility visibility,
    @Default(0) int sortOrder,
    @Default(true) bool isActive,
    @Default([]) List<ContentTopicMedia> media,
    required DateTime createdAt,
  }) = _ContentTopic;

  const ContentTopic._();

  int get videoCount =>
      media.where((m) => m.mediaType == EducationalMediaType.video).length;

  int get audioCount =>
      media.where((m) => m.mediaType == EducationalMediaType.audio).length;

  int get imageCount =>
      media.where((m) => m.mediaType == EducationalMediaType.image).length;

  List<EducationalMediaItem> get educationalMedia =>
      media.map((m) => m.toEducationalMedia()).toList();
}

@freezed
abstract class ContentTopicEditorInput with _$ContentTopicEditorInput {
  const factory ContentTopicEditorInput({
    required String title,
    String? description,
    String? coverImageUrl,
    required ContentVisibility visibility,
    @Default(0) int sortOrder,
    @Default(true) bool isActive,
  }) = _ContentTopicEditorInput;
}

@freezed
abstract class ContentTopicMediaInput with _$ContentTopicMediaInput {
  const factory ContentTopicMediaInput({
    required EducationalMediaType mediaType,
    required String url,
    String? title,
    @Default(0) int sortOrder,
  }) = _ContentTopicMediaInput;

  const ContentTopicMediaInput._();

  String get mediaTypeKey => switch (mediaType) {
        EducationalMediaType.video => 'video',
        EducationalMediaType.audio => 'audio',
        EducationalMediaType.image => 'image',
        EducationalMediaType.pdf => 'pdf',
      };
}

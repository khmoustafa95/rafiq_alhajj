import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';

class ContentTopicMedia {
  const ContentTopicMedia({
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

  EducationalMediaItem toEducationalMedia() => EducationalMediaItem(
        id: id,
        mediaType: mediaType,
        title: title,
        url: url,
        sortOrder: sortOrder,
      );
}

class ContentTopic {
  const ContentTopic({
    required this.id,
    required this.title,
    this.description,
    this.coverImageUrl,
    required this.visibility,
    this.sortOrder = 0,
    this.isActive = true,
    this.media = const [],
    required this.createdAt,
  });

  final String id;
  final String title;
  final String? description;
  final String? coverImageUrl;
  final ContentVisibility visibility;
  final int sortOrder;
  final bool isActive;
  final List<ContentTopicMedia> media;
  final DateTime createdAt;

  int get videoCount =>
      media.where((m) => m.mediaType == EducationalMediaType.video).length;

  int get audioCount =>
      media.where((m) => m.mediaType == EducationalMediaType.audio).length;

  int get imageCount =>
      media.where((m) => m.mediaType == EducationalMediaType.image).length;

  List<EducationalMediaItem> get educationalMedia =>
      media.map((m) => m.toEducationalMedia()).toList();
}

class ContentTopicEditorInput {
  const ContentTopicEditorInput({
    required this.title,
    this.description,
    this.coverImageUrl,
    required this.visibility,
    this.sortOrder = 0,
    this.isActive = true,
  });

  final String title;
  final String? description;
  final String? coverImageUrl;
  final ContentVisibility visibility;
  final int sortOrder;
  final bool isActive;
}

class ContentTopicMediaInput {
  const ContentTopicMediaInput({
    required this.mediaType,
    required this.url,
    this.title,
    this.sortOrder = 0,
  });

  final EducationalMediaType mediaType;
  final String? title;
  final String url;
  final int sortOrder;

  String get mediaTypeKey => switch (mediaType) {
        EducationalMediaType.video => 'video',
        EducationalMediaType.audio => 'audio',
        EducationalMediaType.image => 'image',
      };
}

import 'package:rafiq_alhajj/core/domain/models/educational_media.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_localization.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_publication_status.dart';
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
    required this.titleAr,
    this.titleEn,
    this.descriptionAr,
    this.descriptionEn,
    this.coverImageUrl,
    required this.visibility,
    this.sortOrder = 0,
    this.isActive = true,
    this.publicationStatus = ContentPublicationStatus.published,
    this.publishedAt,
    this.media = const [],
    required this.createdAt,
  });

  final String id;
  final String titleAr;
  final String? titleEn;
  final String? descriptionAr;
  final String? descriptionEn;
  final String? coverImageUrl;
  final ContentVisibility visibility;
  final int sortOrder;
  final bool isActive;
  final ContentPublicationStatus publicationStatus;
  final DateTime? publishedAt;
  final List<ContentTopicMedia> media;
  final DateTime createdAt;

  String localizedTitle(String languageCode) => localizedBilingualText(
        languageCode: languageCode,
        primaryAr: titleAr,
        primaryEn: titleEn,
      );

  String? localizedDescription(String languageCode) {
    final ar = descriptionAr;
    final en = descriptionEn;
    if ((ar == null || ar.isEmpty) && (en == null || en.isEmpty)) {
      return null;
    }
    return localizedBilingualText(
      languageCode: languageCode,
      primaryAr: ar ?? '',
      primaryEn: en,
    );
  }

  /// Backward-compatible aliases.
  String get title => titleAr;
  String? get description => descriptionAr;

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
    required this.titleAr,
    this.titleEn,
    this.descriptionAr,
    this.descriptionEn,
    this.coverImageUrl,
    required this.visibility,
    this.sortOrder = 0,
    this.isActive = true,
    this.publicationStatus = ContentPublicationStatus.published,
    this.publishedAt,
  });

  final String titleAr;
  final String? titleEn;
  final String? descriptionAr;
  final String? descriptionEn;
  final String? coverImageUrl;
  final ContentVisibility visibility;
  final int sortOrder;
  final bool isActive;
  final ContentPublicationStatus publicationStatus;
  final DateTime? publishedAt;
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
        EducationalMediaType.pdf => 'pdf',
      };
}

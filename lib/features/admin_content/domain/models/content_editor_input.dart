import 'package:rafiq_alhajj/features/content/domain/models/content_publication_status.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';

/// Payload for creating or updating [content_library] rows (admin CMS).
class ContentEditorInput {
  const ContentEditorInput({
    this.id,
    required this.titleAr,
    this.titleEn,
    this.descriptionAr,
    this.descriptionEn,
    this.mediaUrl,
    required this.type,
    required this.visibility,
    this.publicationStatus = ContentPublicationStatus.published,
    this.publishedAt,
  });

  final String? id;
  final String titleAr;
  final String? titleEn;
  final String? descriptionAr;
  final String? descriptionEn;
  final String? mediaUrl;
  final ContentType type;
  final ContentVisibility visibility;
  final ContentPublicationStatus publicationStatus;
  final DateTime? publishedAt;

  Map<String, dynamic> toDatabasePayload() {
    final publishedAtValue = publicationStatus == ContentPublicationStatus.published
        ? (publishedAt ?? DateTime.now().toUtc()).toIso8601String()
        : null;

    return {
      'title': titleAr.trim(),
      'title_ar': titleAr.trim(),
      'title_en': _emptyToNull(titleEn),
      'description_ar': _emptyToNull(descriptionAr),
      'description_en': _emptyToNull(descriptionEn),
      'description': _emptyToNull(descriptionAr),
      'media_url': _emptyToNull(mediaUrl),
      'type': type.databaseValue,
      'visibility': visibility.databaseValue,
      'publication_status': publicationStatus.databaseValue,
      'published_at': publishedAtValue,
    };
  }

  static String? _emptyToNull(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}

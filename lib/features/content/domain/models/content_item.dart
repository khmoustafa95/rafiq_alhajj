import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_localization.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_publication_status.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';

part 'content_item.freezed.dart';

@freezed
abstract class ContentItem with _$ContentItem {
  const factory ContentItem({
    required String id,
    required String titleAr,
    String? titleEn,
    String? descriptionAr,
    String? descriptionEn,
    required String? mediaUrl,
    required ContentType type,
    required ContentVisibility visibility,
    @Default(ContentPublicationStatus.published)
    ContentPublicationStatus publicationStatus,
    DateTime? publishedAt,
    required DateTime createdAt,
  }) = _ContentItem;

  const ContentItem._();

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

  /// Backward-compatible aliases for admin tables and legacy cache rows.
  String get title => titleAr;
  String? get description => descriptionAr;
}

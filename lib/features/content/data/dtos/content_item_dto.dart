import 'package:json_annotation/json_annotation.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_publication_status.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';

part 'content_item_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ContentItemDto {
  const ContentItemDto({
    required this.id,
    required this.title,
    this.titleAr,
    this.titleEn,
    this.description,
    this.descriptionAr,
    this.descriptionEn,
    required this.mediaUrl,
    required this.type,
    required this.visibility,
    this.publicationStatus,
    this.publishedAt,
    required this.createdAt,
  });

  factory ContentItemDto.fromJson(Map<String, dynamic> json) =>
      _$ContentItemDtoFromJson(json);

  final String id;
  final String title;
  final String? titleAr;
  final String? titleEn;
  final String? description;
  final String? descriptionAr;
  final String? descriptionEn;
  final String? mediaUrl;
  final String type;
  final String visibility;
  final String? publicationStatus;
  final DateTime? publishedAt;
  final DateTime createdAt;

  ContentItem toDomain() {
    return ContentItem(
      id: id,
      titleAr: titleAr ?? title,
      titleEn: titleEn,
      descriptionAr: descriptionAr ?? description,
      descriptionEn: descriptionEn,
      mediaUrl: mediaUrl,
      type: ContentType.fromDatabase(type),
      visibility: ContentVisibility.fromDatabase(visibility),
      publicationStatus: publicationStatus != null
          ? ContentPublicationStatus.fromDatabase(publicationStatus!)
          : ContentPublicationStatus.published,
      publishedAt: publishedAt,
      createdAt: createdAt,
    );
  }
}

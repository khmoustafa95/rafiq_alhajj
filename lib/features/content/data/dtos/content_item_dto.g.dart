// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentItemDto _$ContentItemDtoFromJson(Map<String, dynamic> json) =>
    ContentItemDto(
      id: json['id'] as String,
      title: json['title'] as String,
      titleAr: json['title_ar'] as String?,
      titleEn: json['title_en'] as String?,
      description: json['description'] as String?,
      descriptionAr: json['description_ar'] as String?,
      descriptionEn: json['description_en'] as String?,
      mediaUrl: json['media_url'] as String?,
      type: json['type'] as String,
      visibility: json['visibility'] as String,
      publicationStatus: json['publication_status'] as String?,
      publishedAt: json['published_at'] == null
          ? null
          : DateTime.parse(json['published_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ContentItemDtoToJson(ContentItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'title_ar': instance.titleAr,
      'title_en': instance.titleEn,
      'description': instance.description,
      'description_ar': instance.descriptionAr,
      'description_en': instance.descriptionEn,
      'media_url': instance.mediaUrl,
      'type': instance.type,
      'visibility': instance.visibility,
      'publication_status': instance.publicationStatus,
      'published_at': instance.publishedAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentItemDto _$ContentItemDtoFromJson(Map<String, dynamic> json) =>
    ContentItemDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      mediaUrl: json['media_url'] as String?,
      type: json['type'] as String,
      visibility: json['visibility'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ContentItemDtoToJson(ContentItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'media_url': instance.mediaUrl,
      'type': instance.type,
      'visibility': instance.visibility,
      'created_at': instance.createdAt.toIso8601String(),
    };

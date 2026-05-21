import 'package:json_annotation/json_annotation.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';

part 'content_item_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ContentItemDto {
  const ContentItemDto({
    required this.id,
    required this.title,
    required this.description,
    required this.mediaUrl,
    required this.type,
    required this.visibility,
    required this.createdAt,
  });

  factory ContentItemDto.fromJson(Map<String, dynamic> json) =>
      _$ContentItemDtoFromJson(json);

  final String id;
  final String title;
  final String? description;
  final String? mediaUrl;
  final String type;
  final String visibility;
  final DateTime createdAt;

  ContentItem toDomain() {
    return ContentItem(
      id: id,
      title: title,
      description: description,
      mediaUrl: mediaUrl,
      type: ContentType.fromDatabase(type),
      visibility: ContentVisibility.fromDatabase(visibility),
      createdAt: createdAt,
    );
  }
}

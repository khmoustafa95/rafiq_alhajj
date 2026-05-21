import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';

part 'content_item.freezed.dart';

@freezed
abstract class ContentItem with _$ContentItem {
  const factory ContentItem({
    required String id,
    required String title,
    required String? description,
    required String? mediaUrl,
    required ContentType type,
    required ContentVisibility visibility,
    required DateTime createdAt,
  }) = _ContentItem;
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';

part 'public_content_feed.freezed.dart';

@freezed
abstract class PublicContentFeed with _$PublicContentFeed {
  const factory PublicContentFeed({
    required List<ContentItem> videos,
    required List<ContentItem> newsAndAnnouncements,
  }) = _PublicContentFeed;
}

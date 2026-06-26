import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';

part 'public_content_feed.freezed.dart';

@freezed
abstract class PublicContentFeed with _$PublicContentFeed {
  const factory PublicContentFeed({
    required List<ContentItem> announcements,
    required List<ContentItem> news,
    required List<ContentTopic> topics,
  }) = _PublicContentFeed;

  const PublicContentFeed._();

  /// Announcements + news combined (most recent first), for screens that show a
  /// single mixed feed list.
  List<ContentItem> get newsAndAnnouncements {
    final combined = [...announcements, ...news]
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return combined;
  }
}

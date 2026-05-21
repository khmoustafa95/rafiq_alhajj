import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/public_content_feed.dart';

abstract class ContentRepository {
  Future<PublicContentFeed> fetchBrowsableFeed({required bool includePilgrimOnly});
  Future<ContentItem?> fetchById(String id);
}

import 'package:rafiq_alhajj/features/content/data/repositories/content_repository.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/public_content_feed.dart';

class UnavailableContentRepository implements ContentRepository {
  const UnavailableContentRepository();

  @override
  Future<PublicContentFeed> fetchBrowsableFeed({
    required bool includePilgrimOnly,
  }) async {
    return const PublicContentFeed(
      topics: [],
      newsAndAnnouncements: [],
    );
  }

  @override
  Future<ContentItem?> fetchById(String id) async => null;
}

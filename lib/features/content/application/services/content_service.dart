import 'package:rafiq_alhajj/features/content/data/repositories/content_repository.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/public_content_feed.dart';

class ContentService {
  const ContentService(this._repository);

  final ContentRepository _repository;

  Future<PublicContentFeed> loadHomeFeed({required bool isPilgrim}) {
    return _repository.fetchBrowsableFeed(includePilgrimOnly: isPilgrim);
  }

  Future<ContentItem?> loadContentDetail(String id) {
    return _repository.fetchById(id);
  }
}

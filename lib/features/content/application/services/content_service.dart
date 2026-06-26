import 'package:rafiq_alhajj/features/content/data/repositories/content_repository.dart';
import 'package:rafiq_alhajj/features/content/data/repositories/content_topics_repository.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/domain/models/public_content_feed.dart';

class ContentService {
  const ContentService(this._repository, this._topicsRepository);

  final ContentRepository _repository;
  final ContentTopicsRepository _topicsRepository;

  Future<PublicContentFeed> loadHomeFeed({required bool isPilgrim}) async {
    final feed = await _repository.fetchBrowsableFeed(
      includePilgrimOnly: isPilgrim,
    );

    List<ContentTopic> topics;
    try {
      topics = await _topicsRepository.fetchActive(
        includePilgrimOnly: isPilgrim,
      );
    } catch (_) {
      topics = const [];
    }

    return PublicContentFeed(
      announcements: feed.announcements,
      news: feed.news,
      topics: topics,
    );
  }

  Future<List<ContentTopic>> loadTopics({required bool isPilgrim}) {
    return _topicsRepository.fetchActive(includePilgrimOnly: isPilgrim);
  }

  Future<ContentItem?> loadContentDetail(String id) {
    return _repository.fetchById(id);
  }
}

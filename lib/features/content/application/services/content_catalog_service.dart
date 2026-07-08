import 'package:rafiq_alhajj/features/content/data/local/content_catalog_cache.dart';
import 'package:rafiq_alhajj/features/content/data/repositories/content_repository.dart';
import 'package:rafiq_alhajj/features/content/data/repositories/content_topics_repository.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/domain/models/public_content_feed.dart';

/// Loads content catalog with local cache fallback (offline-first metadata).
class ContentCatalogService {
  const ContentCatalogService(
    this._cache,
    this._repository,
    this._topicsRepository,
  );

  final ContentCatalogCache _cache;
  final ContentRepository _repository;
  final ContentTopicsRepository _topicsRepository;

  String _scope({required bool isPilgrim, String? profileId}) =>
      ContentCatalogCache.scopeKey(isPilgrim: isPilgrim, profileId: profileId);

  PublicContentFeed? readCachedFeed({
    required bool isPilgrim,
    String? profileId,
  }) {
    return _cache.readFeed(_scope(isPilgrim: isPilgrim, profileId: profileId));
  }

  Future<PublicContentFeed> loadHomeFeed({
    required bool isPilgrim,
    String? profileId,
  }) async {
    final scope = _scope(isPilgrim: isPilgrim, profileId: profileId);
    final cached = _cache.readFeed(scope);

    try {
      final feed = await _repository.fetchBrowsableFeed(
        includePilgrimOnly: isPilgrim,
      );

      List<ContentTopic> topics;
      try {
        topics = await _topicsRepository.fetchActive(
          includePilgrimOnly: isPilgrim,
        );
      } catch (_) {
        topics = cached?.topics ?? const [];
      }

      final result = PublicContentFeed(
        announcements: feed.announcements,
        news: feed.news,
        topics: topics,
      );
      await _cache.writeFeed(scope, result);
      return result;
    } catch (_) {
      if (cached != null) {
        return cached;
      }
      rethrow;
    }
  }

  Future<List<ContentTopic>> loadTopics({
    required bool isPilgrim,
    String? profileId,
  }) async {
    final scope = _scope(isPilgrim: isPilgrim, profileId: profileId);
    final cached = _cache.readTopicsList(scope) ?? _cache.readFeed(scope)?.topics;

    try {
      final topics = await _topicsRepository.fetchActive(
        includePilgrimOnly: isPilgrim,
      );
      await _cache.writeTopicsList(scope, topics);
      for (final topic in topics) {
        await _cache.writeTopic(topic);
      }
      return topics;
    } catch (_) {
      if (cached != null) {
        return cached;
      }
      rethrow;
    }
  }

  Future<ContentItem?> loadContentDetail(
    String id, {
    required bool isPilgrim,
  }) async {
    final cached = _cache.readItem(id);
    if (cached != null && !_cache.canReadItem(cached, isPilgrim: isPilgrim)) {
      return null;
    }

    try {
      final item = await _repository.fetchById(id);
      if (item != null) {
        await _cache.writeItem(item);
      }
      return item;
    } catch (_) {
      return cached;
    }
  }

  Future<ContentTopic?> loadTopicDetail(
    String id, {
    required bool isPilgrim,
  }) async {
    final cached = _cache.readTopic(id);
    if (cached != null && !_cache.canReadTopic(cached, isPilgrim: isPilgrim)) {
      return null;
    }

    try {
      final topic = await _topicsRepository.fetchById(id);
      if (topic != null) {
        await _cache.writeTopic(topic);
      }
      return topic;
    } catch (_) {
      return cached;
    }
  }

  /// Background refresh of catalog metadata (home feed + topics list).
  ///
  /// Intended for Wi-Fi prefetch after sign-in; failures are swallowed so the
  /// caller never blocks UI.
  Future<void> refreshCatalog({
    required bool isPilgrim,
    String? profileId,
  }) async {
    try {
      await loadHomeFeed(isPilgrim: isPilgrim, profileId: profileId);
      await loadTopics(isPilgrim: isPilgrim, profileId: profileId);
    } catch (_) {
      // Prefetch is best-effort; cached snapshots remain available.
    }
  }
}

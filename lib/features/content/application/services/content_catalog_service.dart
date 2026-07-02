import 'package:rafiq_alhajj/features/content/data/local/content_catalog_cache.dart';
import 'package:rafiq_alhajj/features/content/data/repositories/content_repository.dart';
import 'package:rafiq_alhajj/features/content/data/repositories/content_topics_repository.dart';
import 'package:rafiq_alhajj/features/content/domain/models/catalog_snapshot.dart';
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

  CatalogSnapshot<PublicContentFeed>? readCachedFeedSnapshot({
    required bool isPilgrim,
    String? profileId,
  }) {
    final entry = _cache.readFeedEntry(
      _scope(isPilgrim: isPilgrim, profileId: profileId),
    );
    if (entry == null) {
      return null;
    }
    return CatalogSnapshot(
      data: entry.feed,
      cachedAt: entry.cachedAt,
      isFromCache: true,
    );
  }

  PublicContentFeed? readCachedFeed({
    required bool isPilgrim,
    String? profileId,
  }) {
    return readCachedFeedSnapshot(
      isPilgrim: isPilgrim,
      profileId: profileId,
    )?.data;
  }

  Future<CatalogSnapshot<PublicContentFeed>> loadHomeFeedWithSwr({
    required bool isPilgrim,
    String? profileId,
    void Function(CatalogSnapshot<PublicContentFeed>)? onRefresh,
  }) async {
    final scope = _scope(isPilgrim: isPilgrim, profileId: profileId);
    final cached = readCachedFeedSnapshot(
      isPilgrim: isPilgrim,
      profileId: profileId,
    );

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
        topics = cached?.data.topics ?? const [];
      }

      final result = PublicContentFeed(
        announcements: feed.announcements,
        news: feed.news,
        topics: topics,
      );
      await _cache.writeFeed(scope, result);
      final snapshot = CatalogSnapshot(
        data: result,
        cachedAt: DateTime.now(),
      );
      onRefresh?.call(snapshot);
      return snapshot;
    } catch (_) {
      if (cached != null) {
        onRefresh?.call(cached);
        return cached;
      }
      rethrow;
    }
  }

  Future<PublicContentFeed> loadHomeFeed({
    required bool isPilgrim,
    String? profileId,
  }) async {
    final snapshot = await loadHomeFeedWithSwr(
      isPilgrim: isPilgrim,
      profileId: profileId,
    );
    return snapshot.data;
  }

  CatalogSnapshot<List<ContentTopic>>? readCachedTopicsSnapshot({
    required bool isPilgrim,
    String? profileId,
  }) {
    final scope = _scope(isPilgrim: isPilgrim, profileId: profileId);
    final feedEntry = _cache.readFeedEntry(scope);
    final listCached = _cache.readTopicsList(scope);
    final topics = listCached ?? feedEntry?.feed.topics;
    final cachedAt = feedEntry?.cachedAt;
    if (topics == null || cachedAt == null) {
      return null;
    }
    return CatalogSnapshot(
      data: topics,
      cachedAt: cachedAt,
      isFromCache: true,
    );
  }

  Future<CatalogSnapshot<List<ContentTopic>>> loadTopicsWithSwr({
    required bool isPilgrim,
    String? profileId,
    void Function(CatalogSnapshot<List<ContentTopic>>)? onRefresh,
  }) async {
    final scope = _scope(isPilgrim: isPilgrim, profileId: profileId);
    final cached = readCachedTopicsSnapshot(
      isPilgrim: isPilgrim,
      profileId: profileId,
    );

    try {
      final topics = await _topicsRepository.fetchActive(
        includePilgrimOnly: isPilgrim,
      );
      await _cache.writeTopicsList(scope, topics);
      for (final topic in topics) {
        await _cache.writeTopic(topic);
      }
      final snapshot = CatalogSnapshot(
        data: topics,
        cachedAt: DateTime.now(),
      );
      onRefresh?.call(snapshot);
      return snapshot;
    } catch (_) {
      if (cached != null) {
        onRefresh?.call(cached);
        return cached;
      }
      rethrow;
    }
  }

  Future<List<ContentTopic>> loadTopics({
    required bool isPilgrim,
    String? profileId,
  }) async {
    final snapshot = await loadTopicsWithSwr(
      isPilgrim: isPilgrim,
      profileId: profileId,
    );
    return snapshot.data;
  }

  List<CatalogSearchHit> searchCached({
    required String query,
    required bool isPilgrim,
  }) {
    return _cache.searchLocal(query, isPilgrim: isPilgrim);
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
}

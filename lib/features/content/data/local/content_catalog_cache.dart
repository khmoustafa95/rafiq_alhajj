import 'dart:convert';

import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_catalog_codec.dart';
import 'package:rafiq_alhajj/features/content/domain/models/catalog_snapshot.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/features/content/domain/models/public_content_feed.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local JSON cache for content catalog metadata (stale-while-revalidate).
class ContentCatalogCache {
  ContentCatalogCache(this._prefs);

  static const _feedPrefix = 'content_catalog_feed_v1_';
  static const _itemPrefix = 'content_catalog_item_v1_';
  static const _topicPrefix = 'content_catalog_topic_v1_';
  static const _topicsListPrefix = 'content_catalog_topics_v1_';
  static const _journeyKey = 'content_catalog_journey_v1';
  static const _quizPrefix = 'content_catalog_quiz_v1_';

  final SharedPreferences _prefs;

  static String scopeKey({required bool isPilgrim, String? profileId}) {
    if (isPilgrim && profileId != null) {
      return 'pilgrim_$profileId';
    }
    return isPilgrim ? 'pilgrim' : 'guest';
  }

  /// Feed plus cache timestamp for stale-while-revalidate.
  ({PublicContentFeed feed, DateTime cachedAt})? readFeedEntry(String scope) {
    final raw = _prefs.getString('$_feedPrefix$scope');
    if (raw == null) {
      return null;
    }
    try {
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final feed = ContentCatalogCodec.feedFromJson(json);
      if (feed == null) {
        return null;
      }
      final cachedAt = _parseCachedAt(json['cachedAt'] as String?);
      return (feed: feed, cachedAt: cachedAt);
    } catch (_) {
      return null;
    }
  }

  PublicContentFeed? readFeed(String scope) => readFeedEntry(scope)?.feed;

  bool isFeedExpired(String scope) {
    final entry = readFeedEntry(scope);
    if (entry == null) {
      return true;
    }
    return DateTime.now().difference(entry.cachedAt) >
        ContentCatalogTtl.defaultDuration;
  }

  Future<void> invalidateFeed(String scope) async {
    await _prefs.remove('$_feedPrefix$scope');
    await _prefs.remove('$_topicsListPrefix$scope');
  }

  List<CatalogSearchHit> searchLocal(
    String query, {
    required bool isPilgrim,
  }) {
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      return const [];
    }

    final hits = <CatalogSearchHit>[];
    final seen = <String>{};

    void addHit(CatalogSearchHit hit) {
      if (seen.add(hit.id)) {
        hits.add(hit);
      }
    }

    for (final key in _prefs.getKeys()) {
      if (key.startsWith(_itemPrefix)) {
        final raw = _prefs.getString(key);
        if (raw == null) {
          continue;
        }
        try {
          final item = ContentCatalogCodec.itemFromJson(
            jsonDecode(raw) as Map<String, dynamic>,
          );
          if (item == null || !canReadItem(item, isPilgrim: isPilgrim)) {
            continue;
          }
          if (_matches(normalized, item.title, item.description)) {
            addHit(
              CatalogSearchHit(
                id: item.id,
                title: item.title,
                subtitle: item.description,
                kind: item.type == ContentType.news ? 'news' : 'announcement',
              ),
            );
          }
        } catch (_) {
          // skip corrupt entry
        }
      } else if (key.startsWith(_topicPrefix)) {
        final raw = _prefs.getString(key);
        if (raw == null) {
          continue;
        }
        try {
          final topic = ContentCatalogCodec.topicFromJson(
            jsonDecode(raw) as Map<String, dynamic>,
          );
          if (topic == null || !canReadTopic(topic, isPilgrim: isPilgrim)) {
            continue;
          }
          if (_matches(normalized, topic.title, topic.description)) {
            addHit(
              CatalogSearchHit(
                id: topic.id,
                title: topic.title,
                subtitle: topic.description,
                kind: 'topic',
              ),
            );
          }
        } catch (_) {
          // skip corrupt entry
        }
      }
    }

    return hits;
  }

  static bool _matches(String query, String title, String? subtitle) {
    if (title.toLowerCase().contains(query)) {
      return true;
    }
    return subtitle?.toLowerCase().contains(query) ?? false;
  }

  static DateTime _parseCachedAt(String? raw) {
    if (raw == null) {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }
    return DateTime.tryParse(raw) ?? DateTime.fromMillisecondsSinceEpoch(0);
  }

  Future<void> writeFeed(String scope, PublicContentFeed feed) async {
    await _prefs.setString(
      '$_feedPrefix$scope',
      jsonEncode(ContentCatalogCodec.feedToJson(feed)),
    );
    for (final item in [...feed.announcements, ...feed.news]) {
      await writeItem(item);
    }
    for (final topic in feed.topics) {
      await writeTopic(topic);
    }
  }

  ContentItem? readItem(String id) {
    final raw = _prefs.getString('$_itemPrefix$id');
    if (raw == null) {
      return null;
    }
    try {
      return ContentCatalogCodec.itemFromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> writeItem(ContentItem item) => _prefs.setString(
        '$_itemPrefix${item.id}',
        jsonEncode(ContentCatalogCodec.itemToJson(item)),
      );

  ContentTopic? readTopic(String id) {
    final raw = _prefs.getString('$_topicPrefix$id');
    if (raw == null) {
      return null;
    }
    try {
      return ContentCatalogCodec.topicFromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> writeTopic(ContentTopic topic) => _prefs.setString(
        '$_topicPrefix${topic.id}',
        jsonEncode(ContentCatalogCodec.topicToJson(topic)),
      );

  List<ContentTopic>? readTopicsList(String scope) {
    final raw = _prefs.getString('$_topicsListPrefix$scope');
    if (raw == null) {
      return null;
    }
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map(
            (e) => ContentCatalogCodec.topicFromJson(
              Map<String, dynamic>.from(e as Map),
            ),
          )
          .whereType<ContentTopic>()
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> writeTopicsList(String scope, List<ContentTopic> topics) =>
      _prefs.setString(
        '$_topicsListPrefix$scope',
        jsonEncode(topics.map(ContentCatalogCodec.topicToJson).toList()),
      );

  List<HajjJourneyStep>? readJourneySteps() {
    final raw = _prefs.getString(_journeyKey);
    if (raw == null) {
      return null;
    }
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map(
            (e) => ContentCatalogCodec.journeyStepFromJson(
              Map<String, dynamic>.from(e as Map),
            ),
          )
          .whereType<HajjJourneyStep>()
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> writeJourneySteps(List<HajjJourneyStep> steps) => _prefs.setString(
        _journeyKey,
        jsonEncode(steps.map(ContentCatalogCodec.journeyStepToJson).toList()),
      );

  CompetitionQuizProgress? readQuizProgress({
    required String competitionId,
    required String profileId,
  }) {
    final raw = _prefs.getString('$_quizPrefix${profileId}_$competitionId');
    if (raw == null) {
      return null;
    }
    try {
      return ContentCatalogCodec.quizProgressFromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> writeQuizProgress({
    required String competitionId,
    required String profileId,
    required CompetitionQuizProgress progress,
  }) =>
      _prefs.setString(
        '$_quizPrefix${profileId}_$competitionId',
        jsonEncode(ContentCatalogCodec.quizProgressToJson(progress)),
      );

  bool canReadTopic(ContentTopic topic, {required bool isPilgrim}) {
    if (topic.visibility == ContentVisibility.public) {
      return true;
    }
    return isPilgrim && topic.visibility == ContentVisibility.pilgrimOnly;
  }

  bool canReadItem(ContentItem item, {required bool isPilgrim}) {
    if (item.visibility == ContentVisibility.public) {
      return true;
    }
    return isPilgrim && item.visibility == ContentVisibility.pilgrimOnly;
  }
}

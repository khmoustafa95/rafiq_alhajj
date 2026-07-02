import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rafiq_alhajj/features/competitions/data/local/pending_quiz_attempts_cache.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_catalog_cache.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_media_progress_cache.dart';
import 'package:rafiq_alhajj/features/content/domain/models/catalog_snapshot.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_type.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_media_progress.dart';
import 'package:rafiq_alhajj/features/content/domain/models/public_content_feed.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_media_cache_store.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_downloads_provider.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_search_provider.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_downloads_screen.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_search_screen.dart';
import 'package:rafiq_alhajj/features/content/presentation/widgets/content_stale_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/test_app_shell.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  group('CatalogSnapshot', () {
    test('isStale when served from cache', () {
      final snapshot = CatalogSnapshot(
        data: const PublicContentFeed(
          announcements: [],
          news: [],
          topics: [],
        ),
        cachedAt: DateTime.now(),
        isFromCache: true,
      );

      expect(snapshot.isStale, isTrue);
    });

    test('isStale when cachedAt exceeds TTL', () {
      final snapshot = CatalogSnapshot(
        data: const PublicContentFeed(
          announcements: [],
          news: [],
          topics: [],
        ),
        cachedAt: DateTime.now().subtract(const Duration(days: 8)),
      );

      expect(snapshot.isStale, isTrue);
    });

    test('is not stale for fresh network data', () {
      final snapshot = CatalogSnapshot(
        data: const PublicContentFeed(
          announcements: [],
          news: [],
          topics: [],
        ),
        cachedAt: DateTime.now(),
      );

      expect(snapshot.isStale, isFalse);
    });
  });

  group('ContentCatalogCache', () {
    late ContentCatalogCache cache;

    setUp(() async {
      final prefs = await SharedPreferences.getInstance();
      cache = ContentCatalogCache(prefs);
    });

    test('readFeedEntry returns feed and cachedAt', () async {
      const scope = 'guest';
      final feed = PublicContentFeed(
        announcements: const [],
        news: [
          ContentItem(
            id: 'news-1',
            titleAr: 'Hajj update',
            descriptionAr: 'Logistics news',
            mediaUrl: null,
            type: ContentType.news,
            visibility: ContentVisibility.public,
            createdAt: DateTime(2026, 1, 1),
          ),
        ],
        topics: const [],
      );
      await cache.writeFeed(scope, feed);

      final entry = cache.readFeedEntry(scope);
      expect(entry, isNotNull);
      expect(entry!.feed.news, hasLength(1));
      expect(entry.cachedAt, isNot(DateTime.fromMillisecondsSinceEpoch(0)));
    });

    test('searchLocal finds topics and news for guests', () async {
      await cache.writeItem(
        ContentItem(
          id: 'ann-1',
          titleAr: 'Important announcement',
          descriptionAr: 'Group meeting tonight',
          mediaUrl: null,
          type: ContentType.announcement,
          visibility: ContentVisibility.public,
          createdAt: DateTime(2026, 1, 1),
        ),
      );
      await cache.writeTopic(
        ContentTopic(
          id: 'topic-1',
          titleAr: 'Tawaf guide',
          descriptionAr: 'Step by step tawaf',
          visibility: ContentVisibility.public,
          createdAt: DateTime(2026, 1, 1),
        ),
      );

      final hits = cache.searchLocal('tawaf', isPilgrim: false);
      expect(hits, hasLength(1));
      expect(hits.first.kind, 'topic');
      expect(hits.first.id, 'topic-1');
    });

    test('searchLocal hides pilgrim-only content from guests', () async {
      await cache.writeTopic(
        ContentTopic(
          id: 'topic-private',
          titleAr: 'Private tawaf notes',
          visibility: ContentVisibility.pilgrimOnly,
          createdAt: DateTime(2026, 1, 1),
        ),
      );

      final guestHits = cache.searchLocal('tawaf', isPilgrim: false);
      final pilgrimHits = cache.searchLocal('tawaf', isPilgrim: true);

      expect(guestHits, isEmpty);
      expect(pilgrimHits, hasLength(1));
    });

    test('isFeedExpired is true when feed missing', () {
      expect(cache.isFeedExpired('missing'), isTrue);
    });
  });

  group('PendingQuizAttemptsCache', () {
    const profileId = 'profile-1';

    test('enqueue replaces attempt for same question', () async {
      await PendingQuizAttemptsCache.enqueue(
        profileId,
        PendingQuizAttempt(
          competitionId: 'comp-1',
          questionId: 'q-1',
          optionId: 'opt-a',
          createdAt: DateTime(2026, 1, 1),
        ),
      );
      await PendingQuizAttemptsCache.enqueue(
        profileId,
        PendingQuizAttempt(
          competitionId: 'comp-1',
          questionId: 'q-1',
          optionId: 'opt-b',
          createdAt: DateTime(2026, 1, 2),
        ),
      );

      final all = await PendingQuizAttemptsCache.readAll(profileId);
      expect(all, hasLength(1));
      expect(all.first.optionId, 'opt-b');
    });

    test('remove deletes queued attempt', () async {
      await PendingQuizAttemptsCache.enqueue(
        profileId,
        PendingQuizAttempt(
          competitionId: 'comp-1',
          questionId: 'q-2',
          optionId: 'opt-a',
          createdAt: DateTime.now(),
        ),
      );

      await PendingQuizAttemptsCache.remove(profileId, 'q-2');
      final all = await PendingQuizAttemptsCache.readAll(profileId);
      expect(all, isEmpty);
    });
  });

  group('ContentMediaProgressCache', () {
    const profileKey = 'pilgrim-1';

    test('readForMedia returns in-progress position', () async {
      await ContentMediaProgressCache.save(
        profileKey,
        ContentMediaProgress(
          topicId: 'topic-1',
          mediaId: 'media-1',
          topicTitle: 'Topic',
          positionMs: 42_000,
          updatedAt: DateTime.now(),
        ),
      );

      final progress =
          await ContentMediaProgressCache.readForMedia(profileKey, 'media-1');
      expect(progress?.positionMs, 42_000);
    });

    test('readForMedia ignores completed progress', () async {
      await ContentMediaProgressCache.save(
        profileKey,
        ContentMediaProgress(
          topicId: 'topic-1',
          mediaId: 'media-2',
          topicTitle: 'Topic',
          positionMs: 10_000,
          completed: true,
          updatedAt: DateTime.now(),
        ),
      );

      final progress =
          await ContentMediaProgressCache.readForMedia(profileKey, 'media-2');
      expect(progress, isNull);
    });
  });

  group('ContentStaleIndicator widget', () {
    testWidgets('shows cached label when snapshot is from cache', (tester) async {
      await tester.pumpWidget(
        wrapTestApp(
          ContentStaleIndicator(
            snapshot: CatalogSnapshot(
              data: const PublicContentFeed(
                announcements: [],
                news: [],
                topics: [],
              ),
              cachedAt: DateTime.now(),
              isFromCache: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('saved catalog'), findsOneWidget);
      expect(find.byIcon(Icons.history_outlined), findsOneWidget);
    });

    testWidgets('shows refreshing spinner when revalidating', (tester) async {
      await tester.pumpWidget(
        wrapTestApp(
          ContentStaleIndicator(
            snapshot: CatalogSnapshot(
              data: const PublicContentFeed(
                announcements: [],
                news: [],
                topics: [],
              ),
              cachedAt: DateTime.now(),
              isFromCache: true,
              isRefreshing: true,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('hides for fresh network snapshot', (tester) async {
      await tester.pumpWidget(
        wrapTestApp(
          ContentStaleIndicator(
            snapshot: CatalogSnapshot(
              data: const PublicContentFeed(
                announcements: [],
                news: [],
                topics: [],
              ),
              cachedAt: DateTime.now(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ContentStaleIndicator), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byIcon(Icons.history_outlined), findsNothing);
    });
  });

  group('ContentSearchScreen widget', () {
    testWidgets('shows prompt then search results', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            contentLocalSearchProvider('hajj').overrideWith(
              (ref) async => const [
                CatalogSearchHit(
                  id: 'topic-1',
                  title: 'Hajj guide',
                  subtitle: 'Steps',
                  kind: 'topic',
                ),
              ],
            ),
          ],
          child: wrapTestApp(const ContentSearchScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('Search your saved catalog'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'hajj');
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pumpAndSettle();

      expect(find.text('Hajj guide'), findsOneWidget);
    });
  });

  group('ContentDownloadsScreen widget', () {
    testWidgets('shows empty state when no downloads', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            contentDownloadsByTopicProvider.overrideWith(
              (ref) async => const {},
            ),
          ],
          child: wrapTestApp(const ContentDownloadsScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining('No downloaded content'), findsOneWidget);
    });

    testWidgets('lists grouped topic downloads', (tester) async {
      const entry = CachedContentMediaEntry(
        mediaId: 'media-1',
        remoteRef: 'https://example.com/a.mp3',
        encryptedPath: '/tmp/a.enc',
        nonce: 'nonce',
        topicId: 'topic-1',
        mediaType: 'audio',
        bytes: 1024,
        lastAccessMs: 0,
        updatedAtMs: 0,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            contentDownloadsByTopicProvider.overrideWith(
              (ref) async => {'topic-1': [entry]},
            ),
          ],
          child: wrapTestApp(const ContentDownloadsScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('topic-1'), findsOneWidget);
      expect(find.byIcon(Icons.folder_outlined), findsOneWidget);
    });
  });
}

import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_attach.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_providers.dart';
import 'package:rafiq_alhajj/features/admin_content/data/repositories/admin_content_topics_repository.dart';
import 'package:rafiq_alhajj/features/content/data/storage/content_media_storage_service.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_visibility.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'admin_content_topics_providers.g.dart';

@Riverpod(keepAlive: true)
AdminContentTopicsRepository adminContentTopicsRepository(Ref ref) {
  return AdminContentTopicsRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@riverpod
Future<List<ContentTopic>> adminContentTopicsList(Ref ref) {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.contentFeed,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncContentFeedProvider),
    handlerId: 'admin_content_topics_list',
    onInvalidate: (ref) => ref.invalidate(adminContentTopicsListProvider),
  );

  return ref.read(adminContentTopicsRepositoryProvider).fetchAll();
}

@riverpod
Future<PaginatedResult<ContentTopic>> adminContentTopicsPage(
  Ref ref,
  StaffTableQuery query,
) async {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.contentFeed,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncContentFeedProvider),
    handlerId: 'admin_content_topics_page',
    onInvalidate: (ref) => ref.invalidate(adminContentTopicsPageProvider),
  );

  var topics = await ref.watch(adminContentTopicsListProvider.future);

  final search = query.search.trim().toLowerCase();
  if (search.isNotEmpty) {
    topics = topics
        .where(
          (t) =>
              t.titleAr.toLowerCase().contains(search) ||
              (t.titleEn?.toLowerCase().contains(search) ?? false) ||
              (t.descriptionAr?.toLowerCase().contains(search) ?? false),
        )
        .toList();
  }

  final visibility = query.filters['visibility'];
  if (visibility != null && visibility.isNotEmpty) {
    topics = topics.where((t) => t.visibility.name == visibility).toList();
  }

  final status = query.filters['publication_status'];
  if (status != null && status.isNotEmpty) {
    topics =
        topics.where((t) => t.publicationStatus.name == status).toList();
  }

  final sortColumn = query.sortColumnId;
  topics = [...topics]
    ..sort((a, b) {
      final cmp = switch (sortColumn) {
        'visibility' => a.visibility.name.compareTo(b.visibility.name),
        'publication_status' =>
          a.publicationStatus.name.compareTo(b.publicationStatus.name),
        'sort_order' => a.sortOrder.compareTo(b.sortOrder),
        'created_at' => a.createdAt.compareTo(b.createdAt),
        _ => a.titleAr.compareTo(b.titleAr),
      };
      return query.sortAscending ? cmp : -cmp;
    });

  final total = topics.length;
  final pageItems = topics.skip(query.from).take(query.pageSize).toList();

  return PaginatedResult(
    items: pageItems,
    totalCount: total,
    pageSize: query.pageSize,
  );
}

@riverpod
Future<ContentTopic?> adminContentTopicDetail(Ref ref, String id) {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.contentFeed,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncContentFeedProvider),
    handlerId: 'admin_content_topic_detail_$id',
    onInvalidate: (ref) => ref.invalidate(adminContentTopicDetailProvider),
  );

  return ref.read(adminContentTopicsRepositoryProvider).fetchById(id);
}

@riverpod
class AdminContentTopicSave extends _$AdminContentTopicSave {
  @override
  FutureOr<void> build() {}

  /// Returns the saved topic id on success, or null on failure.
  Future<String?> save({
    String? id,
    required ContentTopicEditorInput input,
    required List<ContentTopicMediaInput> media,
  }) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final repo = ref.read(adminContentTopicsRepositoryProvider);
      final storage = ref.read(contentMediaStorageServiceProvider);
      final wantPrivate = input.visibility == ContentVisibility.pilgrimOnly;

      // Re-home cover + media across the public/private buckets so their storage
      // location matches the (possibly changed) topic visibility. Best-effort.
      final effectiveInput =
          await _rehomeCover(storage, input, wantPrivate, id);
      final effectiveMedia =
          await _rehomeMedia(storage, media, wantPrivate, id);

      final topicId = await repo.upsertTopic(id: id, input: effectiveInput);
      await repo.replaceMedia(topicId: topicId, media: effectiveMedia);
      ref.invalidate(adminContentTopicsListProvider);
      ref.invalidate(adminContentTopicDetailProvider(topicId));
      return topicId;
    });
    state = result.whenData((_) {});
    return result.whenOrNull(data: (topicId) => topicId);
  }

  Future<ContentTopicEditorInput> _rehomeCover(
    ContentMediaStorageService storage,
    ContentTopicEditorInput input,
    bool wantPrivate,
    String? topicId,
  ) async {
    final cover = input.coverImageUrl;
    if (cover == null || cover.trim().isEmpty) {
      return input;
    }
    final newCover = await storage.ensureBucketForRef(
      cover,
      wantPrivate: wantPrivate,
      topicId: topicId,
      folder: 'covers',
    );
    if (newCover == cover) {
      return input;
    }
    return ContentTopicEditorInput(
      titleAr: input.titleAr,
      titleEn: input.titleEn,
      descriptionAr: input.descriptionAr,
      descriptionEn: input.descriptionEn,
      coverImageUrl: newCover,
      visibility: input.visibility,
      sortOrder: input.sortOrder,
      isActive: input.isActive,
      publicationStatus: input.publicationStatus,
      publishedAt: input.publishedAt,
    );
  }

  Future<List<ContentTopicMediaInput>> _rehomeMedia(
    ContentMediaStorageService storage,
    List<ContentTopicMediaInput> media,
    bool wantPrivate,
    String? topicId,
  ) async {
    final result = <ContentTopicMediaInput>[];
    for (final item in media) {
      final newUrl = await storage.ensureBucketForRef(
        item.url,
        wantPrivate: wantPrivate,
        topicId: topicId,
      );
      result.add(
        newUrl == item.url
            ? item
            : ContentTopicMediaInput(
                mediaType: item.mediaType,
                url: newUrl,
                title: item.title,
                sortOrder: item.sortOrder,
              ),
      );
    }
    return result;
  }
}

@riverpod
class AdminContentTopicDelete extends _$AdminContentTopicDelete {
  @override
  FutureOr<void> build() {}

  Future<bool> deleteTopic(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final topic =
          await ref.read(adminContentTopicsRepositoryProvider).fetchById(id);
      await ref.read(adminContentTopicsRepositoryProvider).deleteTopic(id);

      if (topic != null) {
        final refs = <String>{
          if (topic.coverImageUrl != null && topic.coverImageUrl!.isNotEmpty)
            topic.coverImageUrl!,
          ...topic.media.map((m) => m.url),
        };
        if (refs.isNotEmpty) {
          await ref
              .read(contentMediaStorageServiceProvider)
              .removeStorageRefs(refs);
        }
        await ref
            .read(contentMediaDownloadControllerProvider.notifier)
            .removeTopicDownloads(id);
      }

      ref.invalidate(adminContentTopicsListProvider);
    });
    return !state.hasError;
  }
}

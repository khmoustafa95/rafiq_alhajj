import 'package:rafiq_alhajj/core/config/app_config.dart';
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

  Future<bool> save({
    String? id,
    required ContentTopicEditorInput input,
    required List<ContentTopicMediaInput> media,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
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
    });
    return !state.hasError;
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
      title: input.title,
      description: input.description,
      coverImageUrl: newCover,
      visibility: input.visibility,
      sortOrder: input.sortOrder,
      isActive: input.isActive,
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
      await ref.read(adminContentTopicsRepositoryProvider).deleteTopic(id);
      ref.invalidate(adminContentTopicsListProvider);
    });
    return !state.hasError;
  }
}

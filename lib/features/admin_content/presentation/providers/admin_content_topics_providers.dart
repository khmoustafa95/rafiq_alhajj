import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_attach.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_providers.dart';
import 'package:rafiq_alhajj/features/admin_content/data/repositories/admin_content_topics_repository.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
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
      final topicId = await repo.upsertTopic(id: id, input: input);
      await repo.replaceMedia(topicId: topicId, media: media);
      ref.invalidate(adminContentTopicsListProvider);
      ref.invalidate(adminContentTopicDetailProvider(topicId));
    });
    return !state.hasError;
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

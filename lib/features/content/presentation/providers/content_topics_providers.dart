import 'dart:async';

import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_attach.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_providers.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/content/domain/models/catalog_snapshot.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_topic.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_catalog_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_topics_providers.g.dart';

@riverpod
class ContentTopicsList extends _$ContentTopicsList {
  @override
  Future<CatalogSnapshot<List<ContentTopic>>> build(AppAccessMode accessMode) {
    attachRealtimeSync(
      ref,
      syncKey: RealtimeSyncKeys.contentFeed,
      ensureSyncActive: (ref) => ref.watch(realtimeSyncContentFeedProvider),
      handlerId: 'content_topics_list_${accessMode.name}',
      onInvalidate: (ref) => ref.invalidate(contentTopicsListProvider),
    );

    return _load(accessMode);
  }

  Future<CatalogSnapshot<List<ContentTopic>>> _load(
    AppAccessMode accessMode,
  ) async {
    final isPilgrim = accessMode == AppAccessMode.pilgrim;
    final profileId = ref.read(authProfileIdProvider);
    final service = await ref.read(contentCatalogServiceProvider.future);
    final cached = service.readCachedTopicsSnapshot(
      isPilgrim: isPilgrim,
      profileId: profileId,
    );

    if (cached != null) {
      unawaited(
        service
            .loadTopicsWithSwr(
              isPilgrim: isPilgrim,
              profileId: profileId,
              onRefresh: (fresh) {
                if (!ref.mounted) {
                  return;
                }
                state = AsyncData(fresh.copyWith(isRefreshing: false));
              },
            )
            .then((_) {})
            .catchError((_) {
              if (ref.mounted && state.hasValue) {
                state = AsyncData(
                  state.requireValue.copyWith(isRefreshing: false),
                );
              }
            }),
      );
      return cached.copyWith(isRefreshing: true);
    }

    return service.loadTopicsWithSwr(
      isPilgrim: isPilgrim,
      profileId: profileId,
    );
  }
}

@riverpod
Future<ContentTopic?> contentTopicDetail(Ref ref, String id) {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.contentFeed,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncContentFeedProvider),
    handlerId: 'content_topic_detail_$id',
    onInvalidate: (ref) => ref.invalidate(contentTopicDetailProvider),
  );

  final isPilgrim = ref.watch(authAccessModeProvider) == AppAccessMode.pilgrim;

  return ref.read(contentCatalogServiceProvider.future).then(
        (service) => service.loadTopicDetail(
          id,
          isPilgrim: isPilgrim,
        ),
      );
}

import 'dart:async';

import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_attach.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_providers.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/content/domain/models/catalog_snapshot.dart';
import 'package:rafiq_alhajj/features/content/domain/models/public_content_feed.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_catalog_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'public_content_feed_provider.g.dart';

@riverpod
class HomeContentFeed extends _$HomeContentFeed {
  @override
  Future<CatalogSnapshot<PublicContentFeed>> build(AppAccessMode accessMode) {
    attachRealtimeSync(
      ref,
      syncKey: RealtimeSyncKeys.contentFeed,
      ensureSyncActive: (ref) => ref.watch(realtimeSyncContentFeedProvider),
      handlerId: 'home_content_feed',
      onInvalidate: (ref) => ref.invalidate(homeContentFeedProvider),
    );

    return _load(accessMode);
  }

  Future<CatalogSnapshot<PublicContentFeed>> _load(
    AppAccessMode accessMode,
  ) async {
    final isPilgrim = accessMode == AppAccessMode.pilgrim;
    final profileId = ref.read(authProfileIdProvider);
    final service = await ref.read(contentCatalogServiceProvider.future);
    final cached = service.readCachedFeedSnapshot(
      isPilgrim: isPilgrim,
      profileId: profileId,
    );

    if (cached != null) {
      unawaited(
        service.loadHomeFeedWithSwr(
          isPilgrim: isPilgrim,
          profileId: profileId,
          onRefresh: (fresh) {
            if (!ref.mounted) {
              return;
            }
            state = AsyncData(
              fresh.copyWith(isRefreshing: false),
            );
          },
        ).then((_) {}).catchError((_) {
          if (ref.mounted && state.hasValue) {
            state = AsyncData(
              state.requireValue.copyWith(isRefreshing: false),
            );
          }
        }),
      );
      return cached.copyWith(isRefreshing: true);
    }

    return service.loadHomeFeedWithSwr(
      isPilgrim: isPilgrim,
      profileId: profileId,
    );
  }
}

import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_attach.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_providers.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/content/domain/models/public_content_feed.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'public_content_feed_provider.g.dart';

@riverpod
Future<PublicContentFeed> homeContentFeed(Ref ref, AppAccessMode accessMode) {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.contentFeed,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncContentFeedProvider),
    handlerId: 'home_content_feed',
    onInvalidate: (ref) => ref.invalidate(homeContentFeedProvider),
  );

  return ref.read(contentServiceProvider).loadHomeFeed(
        isPilgrim: accessMode == AppAccessMode.pilgrim,
      );
}

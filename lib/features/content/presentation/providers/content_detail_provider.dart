import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_attach.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_providers.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_catalog_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_detail_provider.g.dart';

@riverpod
Future<ContentItem?> contentDetail(Ref ref, String contentId) {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.contentFeed,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncContentFeedProvider),
    handlerId: 'content_detail_$contentId',
    onInvalidate: (ref) => ref.invalidate(contentDetailProvider),
  );

  final isPilgrim = ref.watch(authAccessModeProvider) == AppAccessMode.pilgrim;

  return ref.read(contentCatalogServiceProvider.future).then(
        (service) => service.loadContentDetail(
          contentId,
          isPilgrim: isPilgrim,
        ),
      );
}

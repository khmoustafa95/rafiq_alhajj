import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_catalog_providers.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_prefetch_providers.g.dart';

/// Prefetches catalog metadata (and optionally media) for push deep-links.
@Riverpod(keepAlive: true)
ContentPrefetchService contentPrefetchService(Ref ref) {
  return ContentPrefetchService(ref);
}

class ContentPrefetchService {
  ContentPrefetchService(this._ref);

  final Ref _ref;

  Future<void> prefetchContent(String contentId) async {
    final isPilgrim =
        _ref.read(authAccessModeProvider) == AppAccessMode.pilgrim;
    final service = await _ref.read(contentCatalogServiceProvider.future);
    await service.loadContentDetail(contentId, isPilgrim: isPilgrim);
  }

  Future<void> prefetchTopic(String topicId) async {
    final isPilgrim =
        _ref.read(authAccessModeProvider) == AppAccessMode.pilgrim;
    final service = await _ref.read(contentCatalogServiceProvider.future);
    final topic = await service.loadTopicDetail(
      topicId,
      isPilgrim: isPilgrim,
    );
    if (topic == null) {
      return;
    }

    final downloadState =
        _ref.read(contentMediaDownloadControllerProvider).asData?.value;
    if (downloadState?.offlineEnabled ?? false) {
      await _ref
          .read(contentMediaDownloadControllerProvider.notifier)
          .enqueueTopic(topic);
    }
  }
}

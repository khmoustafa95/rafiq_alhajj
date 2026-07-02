import 'package:rafiq_alhajj/features/content/data/local/content_media_cache_store.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_media_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_downloads_provider.g.dart';

@riverpod
Future<Map<String, List<CachedContentMediaEntry>>> contentDownloadsByTopic(
  Ref ref,
) async {
  final store = await ref.watch(contentMediaCacheStoreProvider.future);
  final grouped = <String, List<CachedContentMediaEntry>>{};
  for (final entry in store.readManifest().values) {
    grouped.putIfAbsent(entry.topicId, () => []).add(entry);
  }
  return grouped;
}

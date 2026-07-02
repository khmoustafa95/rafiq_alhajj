import 'package:rafiq_alhajj/features/content/application/services/content_catalog_service.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_catalog_cache.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_repository_provider.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_topics_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'content_catalog_providers.g.dart';

@Riverpod(keepAlive: true)
Future<ContentCatalogCache> contentCatalogCache(Ref ref) async {
  final prefs = await SharedPreferences.getInstance();
  return ContentCatalogCache(prefs);
}

@Riverpod(keepAlive: true)
Future<ContentCatalogService> contentCatalogService(Ref ref) async {
  final cache = await ref.watch(contentCatalogCacheProvider.future);
  return ContentCatalogService(
    cache,
    ref.watch(contentRepositoryProvider),
    ref.watch(contentTopicsRepositoryProvider),
  );
}

import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/content/domain/models/catalog_snapshot.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_catalog_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_search_provider.g.dart';

@riverpod
Future<List<CatalogSearchHit>> contentLocalSearch(
  Ref ref,
  String query,
) async {
  final trimmed = query.trim();
  if (trimmed.isEmpty) {
    return const [];
  }

  final isPilgrim = ref.watch(authAccessModeProvider) == AppAccessMode.pilgrim;
  final service = await ref.watch(contentCatalogServiceProvider.future);
  return service.searchCached(query: trimmed, isPilgrim: isPilgrim);
}

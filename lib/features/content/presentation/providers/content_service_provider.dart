import 'package:rafiq_alhajj/features/content/application/services/content_service.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_service_provider.g.dart';

@Riverpod(keepAlive: true)
ContentService contentService(Ref ref) {
  return ContentService(ref.watch(contentRepositoryProvider));
}

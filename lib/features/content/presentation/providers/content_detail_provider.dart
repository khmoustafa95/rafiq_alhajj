import 'package:rafiq_alhajj/features/content/domain/models/content_item.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'content_detail_provider.g.dart';

@riverpod
Future<ContentItem?> contentDetail(Ref ref, String contentId) {
  return ref.read(contentServiceProvider).loadContentDetail(contentId);
}

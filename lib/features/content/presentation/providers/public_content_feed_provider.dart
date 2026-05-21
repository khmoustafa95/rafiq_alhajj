import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/content/domain/models/public_content_feed.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'public_content_feed_provider.g.dart';

@riverpod
Future<PublicContentFeed> homeContentFeed(Ref ref, AppAccessMode accessMode) {
  return ref.read(contentServiceProvider).loadHomeFeed(
        isPilgrim: accessMode == AppAccessMode.pilgrim,
      );
}

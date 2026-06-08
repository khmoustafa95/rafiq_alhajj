import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_refresh.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_tables.dart';
import 'package:rafiq_alhajj/features/auth/domain/models/app_user_role.dart';
import 'package:rafiq_alhajj/features/content/domain/models/public_content_feed.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'public_content_feed_provider.g.dart';

@riverpod
Future<PublicContentFeed> homeContentFeed(Ref ref, AppAccessMode accessMode) {
  watchSupabaseTables(
    ref,
    client: AppConfig.hasSupabase ? Supabase.instance.client : null,
    tables: RealtimeTables.contentFeed,
  );

  return ref.read(contentServiceProvider).loadHomeFeed(
        isPilgrim: accessMode == AppAccessMode.pilgrim,
      );
}

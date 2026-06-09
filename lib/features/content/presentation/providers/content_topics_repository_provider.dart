import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/content/data/repositories/content_topics_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'content_topics_repository_provider.g.dart';

@Riverpod(keepAlive: true)
ContentTopicsRepository contentTopicsRepository(Ref ref) {
  return ContentTopicsRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

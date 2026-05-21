import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/content/data/repositories/content_repository.dart';
import 'package:rafiq_alhajj/features/content/data/repositories/supabase_content_repository.dart';
import 'package:rafiq_alhajj/features/content/data/repositories/unavailable_content_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'content_repository_provider.g.dart';

@Riverpod(keepAlive: true)
ContentRepository contentRepository(Ref ref) {
  if (!AppConfig.hasSupabase) {
    return const UnavailableContentRepository();
  }
  return SupabaseContentRepository(Supabase.instance.client);
}

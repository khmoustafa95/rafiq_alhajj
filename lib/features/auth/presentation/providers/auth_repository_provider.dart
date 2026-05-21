import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/auth/data/repositories/auth_repository.dart';
import 'package:rafiq_alhajj/features/auth/data/repositories/supabase_auth_repository.dart';
import 'package:rafiq_alhajj/features/auth/data/repositories/unavailable_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_repository_provider.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  if (!AppConfig.hasSupabase) {
    return const UnavailableAuthRepository();
  }
  return SupabaseAuthRepository(Supabase.instance.client);
}

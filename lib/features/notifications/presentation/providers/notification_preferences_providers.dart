import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/notifications/data/repositories/notification_preferences_repository.dart';
import 'package:rafiq_alhajj/features/notifications/data/repositories/push_dispatch_failure_repository.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_preferences.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/push_dispatch_failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'notification_preferences_providers.g.dart';

@Riverpod(keepAlive: true)
NotificationPreferencesRepository notificationPreferencesRepository(Ref ref) {
  return NotificationPreferencesRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
PushDispatchFailureRepository pushDispatchFailureRepository(Ref ref) {
  return PushDispatchFailureRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@riverpod
Future<NotificationPreferences> notificationPreferences(Ref ref) async {
  final profileId = ref.watch(authProfileIdProvider);
  if (profileId == null) {
    return NotificationPreferences.defaults();
  }

  return ref.read(notificationPreferencesRepositoryProvider).fetch(profileId);
}

@riverpod
class NotificationPreferencesSave extends _$NotificationPreferencesSave {
  @override
  FutureOr<void> build() {}

  Future<bool> save(NotificationPreferences preferences) async {
    final profileId = ref.read(authProfileIdProvider);
    if (profileId == null) {
      return false;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(notificationPreferencesRepositoryProvider).save(
            profileId: profileId,
            preferences: preferences,
          );
      ref.invalidate(notificationPreferencesProvider);
    });
    return !state.hasError;
  }
}

@riverpod
Future<List<PushDispatchFailure>> adminPushDispatchFailures(Ref ref) async {
  return ref.read(pushDispatchFailureRepositoryProvider).fetchRecent();
}

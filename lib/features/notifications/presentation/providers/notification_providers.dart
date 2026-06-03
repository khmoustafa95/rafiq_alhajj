import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/notifications/data/repositories/notification_repository.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'notification_providers.g.dart';

@Riverpod(keepAlive: true)
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@riverpod
Stream<int> unreadNotificationCount(Ref ref) async* {
  final profileId = ref.watch(authSessionProvider).value?.profileOrNull?.id;
  if (profileId == null) {
    yield 0;
    return;
  }

  final repository = ref.watch(notificationRepositoryProvider);

  try {
    yield await repository.countUnread(profileId);
  } on NotificationException {
    yield 0;
  }

  await for (final _ in repository.watchInboxChanges(profileId)) {
    try {
      yield await repository.countUnread(profileId);
    } on NotificationException {
      yield 0;
    }
  }
}

@riverpod
class NotificationInbox extends _$NotificationInbox {
  @override
  Future<List<InboxNotification>> build() {
    final profileId = ref.watch(authSessionProvider).value?.profileOrNull?.id;
    if (profileId == null) {
      return Future.value([]);
    }

    return ref.read(notificationRepositoryProvider).fetchInbox(
          recipientId: profileId,
        );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> markAsRead(String notificationId) async {
    final profileId = ref.read(authSessionProvider).value?.profileOrNull?.id;
    if (profileId == null) {
      return;
    }

    await ref.read(notificationRepositoryProvider).markAsRead(
          notificationId: notificationId,
          recipientId: profileId,
        );
    ref.invalidateSelf();
    await future;
  }

  Future<void> markAllAsRead() async {
    final profileId = ref.read(authSessionProvider).value?.profileOrNull?.id;
    if (profileId == null) {
      return;
    }

    await ref.read(notificationRepositoryProvider).markAllAsRead(profileId);
    ref.invalidateSelf();
    await future;
  }
}

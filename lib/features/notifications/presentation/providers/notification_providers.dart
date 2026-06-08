import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_refresh.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/notifications/data/repositories/notification_repository.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_audience.dart';
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
  final profileId = ref.watch(authProfileIdProvider);
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
    final profileId = ref.watch(authProfileIdProvider);
    if (profileId == null) {
      return Future.value([]);
    }

    watchSupabaseTable(
      ref,
      client: AppConfig.hasSupabase ? Supabase.instance.client : null,
      table: 'notifications',
      eqColumn: 'recipient_id',
      eqValue: profileId,
    );

    return ref.read(notificationRepositoryProvider).fetchInbox(
          recipientId: profileId,
        );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> markAsRead(String notificationId) async {
    final profileId = ref.read(authProfileIdProvider);
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
    final profileId = ref.read(authProfileIdProvider);
    if (profileId == null) {
      return;
    }

    await ref.read(notificationRepositoryProvider).markAllAsRead(profileId);
    ref.invalidateSelf();
    await future;
  }
}

@riverpod
Future<List<NotificationGroupOption>> notificationGroups(Ref ref) {
  return ref.read(notificationRepositoryProvider).fetchGroups();
}

@riverpod
Stream<InboxNotification> notificationToastEvents(Ref ref) async* {
  final profileId = ref.watch(authProfileIdProvider);
  if (profileId == null) {
    return;
  }

  final repository = ref.watch(notificationRepositoryProvider);
  var previousUnread = await repository.countUnread(profileId);
  var skipNext = true;

  await for (final _ in repository.watchInboxChanges(profileId)) {
    if (skipNext) {
      skipNext = false;
      previousUnread = await repository.countUnread(profileId);
      continue;
    }

    final unread = await repository.countUnread(profileId);
    if (unread <= previousUnread) {
      previousUnread = unread;
      continue;
    }

    final inbox = await repository.fetchInbox(
      recipientId: profileId,
      limit: 1,
    );
    previousUnread = unread;

    if (inbox.isEmpty || inbox.first.isRead) {
      continue;
    }

    yield inbox.first;
  }
}

@riverpod
class AdminNotificationBroadcast extends _$AdminNotificationBroadcast {
  @override
  FutureOr<void> build() {}

  Future<int?> send(NotificationBroadcastInput input) async {
    if (input.audience == NotificationAudience.groupPilgrims &&
        (input.groupId == null || input.groupId!.isEmpty)) {
      return null;
    }

    state = const AsyncLoading();
    int? recipientCount;
    state = await AsyncValue.guard(() async {
      recipientCount = await ref
          .read(notificationRepositoryProvider)
          .sendBroadcast(input: input);
    });

    if (state.hasError) {
      return null;
    }
    return recipientCount;
  }
}

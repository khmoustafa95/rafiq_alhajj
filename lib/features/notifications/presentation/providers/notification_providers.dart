import 'package:flutter/foundation.dart';
import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_refresh.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/notifications/application/services/guest_notifications_seen_store.dart';
import 'package:rafiq_alhajj/features/notifications/data/repositories/notification_repository.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_audience.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'notification_providers.g.dart';

void _logNotificationError(String where, Object error) {
  if (kDebugMode) {
    debugPrint('Notification error ($where): $error');
  }
}

@Riverpod(keepAlive: true)
NotificationRepository notificationRepository(Ref ref) {
  return NotificationRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
GuestNotificationsSeenStore guestNotificationsSeenStore(Ref ref) {
  return const GuestNotificationsSeenStore();
}

@riverpod
Stream<int> unreadNotificationCount(Ref ref) async* {
  final profileId = ref.watch(authProfileIdProvider);
  final repository = ref.watch(notificationRepositoryProvider);

  if (profileId == null) {
    final seenStore = ref.watch(guestNotificationsSeenStoreProvider);

    Future<int> guestUnread() async {
      final items = await repository.fetchGuestInbox();
      final lastSeen = await seenStore.lastSeen();
      if (lastSeen == null) {
        return items.length;
      }
      return items.where((n) => n.createdAt.isAfter(lastSeen)).length;
    }

    try {
      yield await guestUnread();
    } on NotificationException catch (e) {
      _logNotificationError('guest unread', e);
      yield 0;
    }

    await for (final _ in repository.watchGuestInboxChanges()) {
      try {
        yield await guestUnread();
      } on NotificationException catch (e) {
        _logNotificationError('guest unread', e);
        yield 0;
      }
    }
    return;
  }

  try {
    yield await repository.countUnread(profileId);
  } on NotificationException catch (e) {
    _logNotificationError('unread count', e);
    yield 0;
  }

  await for (final _ in repository.watchInboxChanges(profileId)) {
    try {
      yield await repository.countUnread(profileId);
    } on NotificationException catch (e) {
      _logNotificationError('unread count', e);
      yield 0;
    }
  }
}

@riverpod
class NotificationInbox extends _$NotificationInbox {
  @override
  Future<List<InboxNotification>> build() {
    final profileId = ref.watch(authProfileIdProvider);
    final repository = ref.read(notificationRepositoryProvider);

    if (profileId == null) {
      watchSupabaseTable(
        ref,
        client: AppConfig.hasSupabase ? Supabase.instance.client : null,
        table: 'public_announcements',
      );

      return repository.fetchGuestInbox();
    }

    watchSupabaseTable(
      ref,
      client: AppConfig.hasSupabase ? Supabase.instance.client : null,
      table: 'notifications',
      eqColumn: 'recipient_id',
      eqValue: profileId,
    );

    return repository.fetchInbox(
      recipientId: profileId,
    );
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<void> markAsRead(String notificationId) async {
    final profileId = ref.read(authProfileIdProvider);
    if (profileId == null || notificationId.startsWith('content-')) {
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
  // Only surface notifications created after the stream started, and never the
  // same one twice (id-based dedup avoids the races of count comparison and the
  // "single toast for a burst" problem).
  final startedAt = DateTime.now();
  String? lastEmittedId;

  await for (final _ in repository.watchInboxChanges(profileId)) {
    final List<InboxNotification> inbox;
    try {
      inbox = await repository.fetchInbox(recipientId: profileId, limit: 1);
    } on NotificationException catch (e) {
      _logNotificationError('toast fetch', e);
      continue;
    }

    if (inbox.isEmpty) {
      continue;
    }

    final latest = inbox.first;
    if (latest.isRead ||
        latest.id == lastEmittedId ||
        latest.createdAt.isBefore(startedAt)) {
      continue;
    }

    lastEmittedId = latest.id;
    yield latest;
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

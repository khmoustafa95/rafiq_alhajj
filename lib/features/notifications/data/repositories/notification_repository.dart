import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/notifications/data/data_sources/notification_remote_data_source.dart';
import 'package:rafiq_alhajj/features/notifications/data/dtos/inbox_notification_dto.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_audience.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/notification_type.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationException implements Exception {
  const NotificationException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Notification request failed';
}

class NotificationRepository {
  NotificationRepository([SupabaseClient? client])
      : _remote = AppConfig.hasSupabase && client != null
            ? NotificationRemoteDataSource(client)
            : null;

  final NotificationRemoteDataSource? _remote;

  bool get isAvailable => _remote != null;

  Future<List<InboxNotification>> fetchInbox({
    required String recipientId,
    int limit = 50,
  }) async {
    final remote = _remote;
    if (remote == null) {
      return [];
    }

    try {
      final rows = await remote.fetchInbox(
        recipientId: recipientId,
        limit: limit,
      );

      return _mapRows(rows);
    } on PostgrestException catch (e) {
      throw NotificationException(e.message);
    }
  }

  /// Guest inbox: public admin broadcasts + published news/announcements.
  Future<List<InboxNotification>> fetchGuestInbox({int limit = 50}) async {
    final remote = _remote;
    if (remote == null) {
      return [];
    }

    try {
      final announcementRows =
          await remote.fetchPublicAnnouncements(limit: limit);

      final contentRows = await remote.fetchPublicContent(limit: limit);

      final items = <InboxNotification>[
        ..._mapPublicAnnouncementRows(announcementRows),
        ..._mapPublicContentRows(contentRows),
      ]..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      if (items.length <= limit) {
        return items;
      }
      return items.take(limit).toList();
    } on PostgrestException catch (e) {
      throw NotificationException(e.message);
    }
  }

  Stream<void> watchGuestInboxChanges() {
    final remote = _remote;
    if (remote == null) {
      return const Stream.empty();
    }

    return remote.watchPublicAnnouncements().map((_) {});
  }

  Future<int> countUnread(String recipientId) async {
    final remote = _remote;
    if (remote == null) {
      return 0;
    }

    try {
      return await remote.countUnread(recipientId);
    } on PostgrestException catch (e) {
      throw NotificationException(e.message);
    }
  }

  Stream<void> watchInboxChanges(String recipientId) {
    final remote = _remote;
    if (remote == null) {
      return const Stream.empty();
    }

    return remote.watchInbox(recipientId).map((_) {});
  }

  Future<void> markAsRead({
    required String notificationId,
    required String recipientId,
  }) async {
    final remote = _remote;
    if (remote == null) {
      return;
    }

    try {
      await remote.markAsRead(
        notificationId: notificationId,
        recipientId: recipientId,
      );
    } on PostgrestException catch (e) {
      throw NotificationException(e.message);
    }
  }

  Future<List<NotificationGroupOption>> fetchGroups() async {
    final remote = _remote;
    if (remote == null) {
      return [];
    }

    try {
      final rows = await remote.fetchGroups();

      return rows
          .map(
            (map) => NotificationGroupOption(
              id: map['id'] as String,
              name: map['name'] as String,
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw NotificationException(e.message);
    }
  }

  Future<int> sendBroadcast({required NotificationBroadcastInput input}) async {
    final remote = _remote;
    if (remote == null) {
      throw const NotificationException('Supabase is not configured');
    }

    try {
      final result = await remote.sendBroadcast({
        'p_audience': input.audience.rpcValue,
        'p_title_ar': input.titleAr,
        'p_title_en': input.titleEn,
        'p_body_ar': input.bodyAr,
        'p_body_en': input.bodyEn,
        'p_payload': input.payload,
        'p_group_id': input.groupId,
      });

      return result.toInt();
    } on PostgrestException catch (e) {
      throw NotificationException(e.message);
    }
  }

  Future<void> markAllAsRead(String recipientId) async {
    final remote = _remote;
    if (remote == null) {
      return;
    }

    try {
      await remote.markAllAsRead(recipientId);
    } on PostgrestException catch (e) {
      throw NotificationException(e.message);
    }
  }

  List<InboxNotification> _mapRows(List<dynamic> rows) {
    return rows
        .map(
          (row) => InboxNotificationDto.fromJson(
            Map<String, dynamic>.from(row as Map),
          ).toDomain(),
        )
        .toList();
  }

  List<InboxNotification> _mapPublicAnnouncementRows(List<dynamic> rows) {
    return rows.map((row) {
      final map = Map<String, dynamic>.from(row as Map);
      return InboxNotification(
        id: map['id'] as String,
        recipientId: 'guest',
        senderId: null,
        type: InboxNotificationType.announcement,
        titleAr: map['title_ar'] as String,
        titleEn: map['title_en'] as String,
        bodyAr: map['body_ar'] as String?,
        bodyEn: map['body_en'] as String?,
        payload: Map<String, dynamic>.from(
          (map['payload'] as Map?) ?? const {},
        ),
        readAt: DateTime.now(),
        createdAt: DateTime.parse(map['created_at'] as String),
      );
    }).toList();
  }

  List<InboxNotification> _mapPublicContentRows(List<dynamic> rows) {
    return rows.map((row) {
      final map = Map<String, dynamic>.from(row as Map);
      final type = map['type'] as String;
      final notificationType = type == 'announcement'
          ? InboxNotificationType.announcement
          : InboxNotificationType.contentPublished;
      final title = map['title'] as String;
      final description = map['description'] as String?;

      return InboxNotification(
        id: 'content-${map['id']}',
        recipientId: 'guest',
        senderId: null,
        type: notificationType,
        titleAr: title,
        titleEn: title,
        bodyAr: description,
        bodyEn: description,
        payload: {'route': 'content', 'id': map['id'] as String},
        readAt: DateTime.now(),
        createdAt: DateTime.parse(map['created_at'] as String),
      );
    }).toList();
  }
}

import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/notifications/data/dtos/inbox_notification_dto.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/inbox_notification.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationException implements Exception {
  const NotificationException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Notification request failed';
}

class NotificationRepository {
  NotificationRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  static const _columns =
      'id, recipient_id, sender_id, type, title_ar, title_en, '
      'body_ar, body_en, payload, read_at, created_at';

  Future<List<InboxNotification>> fetchInbox({
    required String recipientId,
    int limit = 50,
  }) async {
    if (!isAvailable) {
      return [];
    }

    try {
      final rows = await _client!
          .from('notifications')
          .select(_columns)
          .eq('recipient_id', recipientId)
          .order('created_at', ascending: false)
          .limit(limit);

      return _mapRows(rows as List<dynamic>);
    } on PostgrestException catch (e) {
      throw NotificationException(e.message);
    }
  }

  Future<int> countUnread(String recipientId) async {
    if (!isAvailable) {
      return 0;
    }

    try {
      final count = await _client!
          .from('notifications')
          .count()
          .eq('recipient_id', recipientId)
          .filter('read_at', 'is', null);

      return count;
    } on PostgrestException catch (e) {
      throw NotificationException(e.message);
    }
  }

  Stream<void> watchInboxChanges(String recipientId) {
    if (!isAvailable) {
      return const Stream.empty();
    }

    return _client!
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('recipient_id', recipientId)
        .map((_) {});
  }

  Future<void> markAsRead({
    required String notificationId,
    required String recipientId,
  }) async {
    if (!isAvailable) {
      return;
    }

    try {
      await _client!
          .from('notifications')
          .update({'read_at': DateTime.now().toUtc().toIso8601String()})
          .eq('id', notificationId)
          .eq('recipient_id', recipientId)
          .filter('read_at', 'is', null);
    } on PostgrestException catch (e) {
      throw NotificationException(e.message);
    }
  }

  Future<void> markAllAsRead(String recipientId) async {
    if (!isAvailable) {
      return;
    }

    try {
      await _client!
          .from('notifications')
          .update({'read_at': DateTime.now().toUtc().toIso8601String()})
          .eq('recipient_id', recipientId)
          .filter('read_at', 'is', null);
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
}

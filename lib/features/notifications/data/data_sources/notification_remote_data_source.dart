import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for the `notifications` inbox, public broadcasts and
/// the `send_notification_broadcast` RPC.
///
/// Owns all [SupabaseClient] calls and returns raw rows/scalars/streams.
/// Mapping to domain models and payload building is the repository's
/// responsibility (see [NotificationRepository]).
class NotificationRemoteDataSource {
  const NotificationRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const columns =
      'id, recipient_id, sender_id, type, title_ar, title_en, '
      'body_ar, body_en, payload, read_at, created_at';

  Future<List<Map<String, dynamic>>> fetchInbox({
    required String recipientId,
    required int limit,
  }) async {
    final rows = await _client
        .from('notifications')
        .select(columns)
        .eq('recipient_id', recipientId)
        .order('created_at', ascending: false)
        .limit(limit);
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchPublicAnnouncements({
    required int limit,
  }) async {
    final rows = await _client
        .from('public_announcements')
        .select(
          'id, title_ar, title_en, body_ar, body_en, payload, created_at',
        )
        .order('created_at', ascending: false)
        .limit(limit);
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchPublicContent({
    required int limit,
  }) async {
    final rows = await _client
        .from('content_library')
        .select('id, title, description, type, created_at')
        .eq('visibility', 'public')
        .inFilter('type', ['news', 'announcement'])
        .order('created_at', ascending: false)
        .limit(limit);
    return _asMaps(rows);
  }

  Stream<List<Map<String, dynamic>>> watchPublicAnnouncements() {
    return _client.from('public_announcements').stream(primaryKey: ['id']);
  }

  Future<int> countUnread(String recipientId) async {
    final count = await _client
        .from('notifications')
        .count()
        .eq('recipient_id', recipientId)
        .filter('read_at', 'is', null);
    return count;
  }

  Stream<List<Map<String, dynamic>>> watchInbox(String recipientId) {
    return _client
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('recipient_id', recipientId);
  }

  Future<void> markAsRead({
    required String notificationId,
    required String recipientId,
  }) async {
    await _client
        .from('notifications')
        .update({'read_at': DateTime.now().toUtc().toIso8601String()})
        .eq('id', notificationId)
        .eq('recipient_id', recipientId)
        .filter('read_at', 'is', null);
  }

  Future<List<Map<String, dynamic>>> fetchGroups() async {
    final rows =
        await _client.from('groups').select('id, name').order('name');
    return _asMaps(rows);
  }

  Future<num> sendBroadcast(Map<String, dynamic> params) async {
    return _client.rpc<num>(
      'send_notification_broadcast',
      params: params,
    );
  }

  Future<void> markAllAsRead(String recipientId) async {
    await _client
        .from('notifications')
        .update({'read_at': DateTime.now().toUtc().toIso8601String()})
        .eq('recipient_id', recipientId)
        .filter('read_at', 'is', null);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

/// Admin read access to `push_dispatch_failures`.
class PushDispatchFailureRemoteDataSource {
  const PushDispatchFailureRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const _table = 'push_dispatch_failures';
  static const _columns =
      'id, notification_id, recipient_id, device_token, error, attempts, created_at';

  Future<List<Map<String, dynamic>>> fetchRecent({int limit = 50}) async {
    final rows = await _client
        .from(_table)
        .select(_columns)
        .order('created_at', ascending: false)
        .limit(limit);
    return _asMaps(rows);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    if (rows is List) {
      return rows.cast<Map<String, dynamic>>();
    }
    return const [];
  }

  Future<void> retryFailure(String failureId) async {
    await _client.rpc<void>(
      'admin_retry_push_failure',
      params: {'p_failure_id': failureId},
    );
  }
}

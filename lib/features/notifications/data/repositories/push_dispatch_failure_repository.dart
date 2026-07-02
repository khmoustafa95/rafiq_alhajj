import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/notifications/data/data_sources/push_dispatch_failure_remote_data_source.dart';
import 'package:rafiq_alhajj/features/notifications/domain/models/push_dispatch_failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PushDispatchFailureException implements Exception {
  const PushDispatchFailureException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Push dispatch failures request failed';
}

class PushDispatchFailureRepository {
  PushDispatchFailureRepository([SupabaseClient? client])
      : _remote = (AppConfig.hasSupabase && client != null)
            ? PushDispatchFailureRemoteDataSource(client)
            : null;

  final PushDispatchFailureRemoteDataSource? _remote;

  Future<List<PushDispatchFailure>> fetchRecent({int limit = 50}) async {
    final remote = _remote;
    if (remote == null) {
      return const [];
    }

    try {
      final rows = await remote.fetchRecent(limit: limit);
      return rows.map(_mapRow).toList(growable: false);
    } on PostgrestException catch (e) {
      throw PushDispatchFailureException(e.message);
    }
  }

  PushDispatchFailure _mapRow(Map<String, dynamic> row) {
    final token = row['device_token'] as String? ?? '';
    final preview = token.length <= 16 ? token : '${token.substring(0, 16)}…';

    return PushDispatchFailure(
      id: row['id'] as String,
      notificationId: row['notification_id'] as String,
      recipientId: row['recipient_id'] as String,
      deviceTokenPreview: preview,
      error: row['error'] as String? ?? '',
      attempts: row['attempts'] as int? ?? 1,
      createdAt: DateTime.parse(row['created_at'] as String),
    );
  }
}

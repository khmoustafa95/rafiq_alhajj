import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/pilgrim/data/data_sources/pilgrim_remote_data_source.dart';
import 'package:rafiq_alhajj/features/pilgrim/data/dtos/pilgrim_details_dto.dart';
import 'package:rafiq_alhajj/features/pilgrim/data/dtos/ritual_log_dto.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim_details.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/ritual_progress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PilgrimRemoteException implements Exception {
  const PilgrimRemoteException();
}

class PilgrimRemoteRepository {
  PilgrimRemoteRepository([SupabaseClient? client])
      : _remote = client == null ? null : PilgrimRemoteDataSource(client);

  final PilgrimRemoteDataSource? _remote;

  bool get isAvailable => AppConfig.hasSupabase && _remote != null;

  /// The pilgrim's active enrollment row from the flat view (prefers the
  /// enrollment on an active trip, otherwise the first one).
  Future<Map<String, dynamic>?> _activeEnrollmentRow(
    PilgrimRemoteDataSource remote,
    String profileId,
  ) async {
    final maps = await remote.fetchEnrollmentRows(profileId);
    if (maps.isEmpty) {
      return null;
    }

    return maps.firstWhere(
      (m) => m['trip_status'] == 'active',
      orElse: () => maps.first,
    );
  }

  Future<String?> fetchActiveEnrollmentId(String profileId) async {
    if (!isAvailable) {
      return null;
    }
    final remote = _remote!;
    try {
      final row = await _activeEnrollmentRow(remote, profileId);
      return row?['enrollment_id'] as String?;
    } on PostgrestException {
      throw const PilgrimRemoteException();
    }
  }

  Future<PilgrimDetails?> fetchDetails(String profileId) async {
    if (!isAvailable) {
      return null;
    }
    final remote = _remote!;
    try {
      final row = await _activeEnrollmentRow(remote, profileId);
      if (row == null) {
        return null;
      }
      return PilgrimDetailsDto.fromJson(row).toDomain();
    } on PostgrestException {
      throw const PilgrimRemoteException();
    }
  }

  Future<Map<String, RitualProgress>> fetchRitualLogs(
    String enrollmentId,
  ) async {
    if (!isAvailable) {
      return {};
    }
    final remote = _remote!;
    try {
      final rows = await remote.fetchRitualLogs(enrollmentId);

      final map = <String, RitualProgress>{};
      for (final row in rows) {
        final dto = RitualLogDto.fromJson(row);
        map[dto.ritualKey] = dto.toDomain();
      }
      return map;
    } on PostgrestException {
      throw const PilgrimRemoteException();
    }
  }

  Future<void> upsertRitualLog({
    required String enrollmentId,
    required RitualProgress progress,
  }) async {
    if (!isAvailable) {
      return;
    }
    final remote = _remote!;
    try {
      await remote.upsertRitualLog({
        'enrollment_id': enrollmentId,
        'ritual_key': progress.ritualKey,
        'is_completed': progress.isCompleted,
        'completed_at': progress.completedAt?.toUtc().toIso8601String(),
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      });
    } on PostgrestException {
      throw const PilgrimRemoteException();
    }
  }
}

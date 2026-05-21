import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/pilgrim/data/dtos/pilgrim_details_dto.dart';
import 'package:rafiq_alhajj/features/pilgrim/data/dtos/ritual_log_dto.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim_details.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/ritual_progress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PilgrimRemoteException implements Exception {
  const PilgrimRemoteException();
}

class PilgrimRemoteRepository {
  PilgrimRemoteRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  Future<PilgrimDetails?> fetchDetails(String profileId) async {
    if (!isAvailable) {
      return null;
    }

    try {
      final row = await _client!
          .from('pilgrim_details')
          .select(
            'passport_number, travel_permit_number, medical_test_status, '
            'travel_date, hotel_name, hotel_location_url, transportation_details',
          )
          .eq('profile_id', profileId)
          .maybeSingle();

      if (row == null) {
        return null;
      }

      return PilgrimDetailsDto.fromJson(
        Map<String, dynamic>.from(row),
      ).toDomain();
    } on PostgrestException {
      throw const PilgrimRemoteException();
    }
  }

  Future<Map<String, RitualProgress>> fetchRitualLogs(String pilgrimId) async {
    if (!isAvailable) {
      return {};
    }

    try {
      final rows = await _client!
          .from('ritual_logs')
          .select('ritual_key, is_completed, completed_at')
          .eq('pilgrim_id', pilgrimId);

      final map = <String, RitualProgress>{};
      for (final row in rows as List<dynamic>) {
        final dto = RitualLogDto.fromJson(Map<String, dynamic>.from(row as Map));
        map[dto.ritualKey] = dto.toDomain();
      }
      return map;
    } on PostgrestException {
      throw const PilgrimRemoteException();
    }
  }

  Future<void> upsertRitualLog({
    required String pilgrimId,
    required RitualProgress progress,
  }) async {
    if (!isAvailable) {
      return;
    }

    try {
      await _client!.from('ritual_logs').upsert(
        {
          'pilgrim_id': pilgrimId,
          'ritual_key': progress.ritualKey,
          'is_completed': progress.isCompleted,
          'completed_at': progress.completedAt?.toUtc().toIso8601String(),
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        },
        onConflict: 'pilgrim_id,ritual_key',
      );
    } on PostgrestException {
      throw const PilgrimRemoteException();
    }
  }
}

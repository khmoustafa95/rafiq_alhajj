import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/pilgrim/data/dtos/pilgrim_dto.dart';
import 'package:rafiq_alhajj/features/pilgrim/data/pilgrim_registry_columns.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PilgrimRegistryException implements Exception {
  const PilgrimRegistryException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Pilgrim registry request failed';
}

class PilgrimRegistryRepository {
  PilgrimRegistryRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  Future<List<Pilgrim>> fetchAllPilgrims() async {
    if (!isAvailable) {
      return [];
    }

    try {
      final rows = await _client!
          .from('profiles')
          .select(
            'id, full_name, pilgrim_details(${PilgrimRegistryColumns.detailsSelect})',
          )
          .eq('role', 'pilgrim')
          .order('full_name');

      return (rows as List<dynamic>)
          .map((row) => PilgrimDto.fromJoinedProfile(
                Map<String, dynamic>.from(row as Map),
              ))
          .toList(growable: false);
    } on PostgrestException catch (e) {
      throw PilgrimRegistryException(e.message);
    }
  }

  Future<Pilgrim?> fetchByProfileId(String profileId) async {
    if (!isAvailable) {
      return null;
    }

    try {
      final row = await _client!
          .from('profiles')
          .select(
            'id, full_name, pilgrim_details(${PilgrimRegistryColumns.detailsSelect})',
          )
          .eq('id', profileId)
          .eq('role', 'pilgrim')
          .maybeSingle();

      if (row == null) {
        return null;
      }

      return PilgrimDto.fromJoinedProfile(Map<String, dynamic>.from(row));
    } on PostgrestException catch (e) {
      throw PilgrimRegistryException(e.message);
    }
  }

  Future<Pilgrim?> fetchDetailsOnly(String profileId) async {
    if (!isAvailable) {
      return null;
    }

    try {
      final row = await _client!
          .from('pilgrim_details')
          .select(PilgrimRegistryColumns.detailsSelect)
          .eq('profile_id', profileId)
          .maybeSingle();

      if (row == null) {
        return null;
      }

      final dto = PilgrimDto.fromJson({
        ...Map<String, dynamic>.from(row),
        'profile_id': profileId,
      });
      return dto.toDomain();
    } on PostgrestException catch (e) {
      throw PilgrimRegistryException(e.message);
    }
  }

  Future<void> updateFieldStatus({
    required String profileId,
    required String? fieldStatus,
    required String? medicalTestStatus,
  }) async {
    if (!isAvailable) {
      throw const PilgrimRegistryException('Supabase is not configured');
    }

    try {
      await _client!.from('pilgrim_details').update({
        'field_status': fieldStatus,
        'medical_test_status': medicalTestStatus,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      }).eq('profile_id', profileId);
    } on PostgrestException catch (e) {
      throw PilgrimRegistryException(e.message);
    }
  }
}

import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/pilgrim_field_record.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/pilgrim_search_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FieldOperatorException implements Exception {
  const FieldOperatorException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Field operator request failed';
}

class FieldOperatorRepository {
  FieldOperatorRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  Future<List<PilgrimSearchItem>> fetchPilgrims() async {
    if (!isAvailable) {
      return [];
    }

    try {
      final rows = await _client!
          .from('profiles')
          .select(
            'id, full_name, '
            'pilgrim_details(passport_number, travel_permit_number, field_status, medical_test_status)',
          )
          .eq('role', 'pilgrim')
          .order('full_name');

      return _mapSearchRows(rows as List<dynamic>);
    } on PostgrestException catch (e) {
      throw FieldOperatorException(e.message);
    }
  }

  Future<PilgrimFieldRecord?> fetchPilgrim(String profileId) async {
    if (!isAvailable) {
      return null;
    }

    try {
      final row = await _client!
          .from('profiles')
          .select(
            'id, full_name, '
            'pilgrim_details(passport_number, travel_permit_number, field_status, '
            'medical_test_status, hotel_name, transportation_details)',
          )
          .eq('id', profileId)
          .eq('role', 'pilgrim')
          .maybeSingle();

      if (row == null) {
        return null;
      }

      return _mapFieldRecord(Map<String, dynamic>.from(row));
    } on PostgrestException catch (e) {
      throw FieldOperatorException(e.message);
    }
  }

  Future<void> updatePilgrimLogistics({
    required String profileId,
    required String? fieldStatus,
    required String? medicalTestStatus,
  }) async {
    if (!isAvailable) {
      throw const FieldOperatorException('Supabase is not configured');
    }

    try {
      await _client!.from('pilgrim_details').update({
        'field_status': fieldStatus,
        'medical_test_status': medicalTestStatus,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      }).eq('profile_id', profileId);
    } on PostgrestException catch (e) {
      throw FieldOperatorException(e.message);
    }
  }

  List<PilgrimSearchItem> _mapSearchRows(List<dynamic> rows) {
    final items = <PilgrimSearchItem>[];
    for (final raw in rows) {
      final row = Map<String, dynamic>.from(raw as Map);
      final details = _detailsMap(row['pilgrim_details']);
      items.add(
        PilgrimSearchItem(
          profileId: row['id'] as String,
          fullName: (row['full_name'] as String?) ?? '',
          passportNumber: details?['passport_number'] as String?,
          travelPermitNumber: details?['travel_permit_number'] as String?,
          fieldStatus: details?['field_status'] as String?,
          medicalTestStatus: details?['medical_test_status'] as String?,
        ),
      );
    }
    return items;
  }

  PilgrimFieldRecord? _mapFieldRecord(Map<String, dynamic> row) {
    final details = _detailsMap(row['pilgrim_details']);
    if (details == null) {
      return null;
    }

    return PilgrimFieldRecord(
      profileId: row['id'] as String,
      fullName: (row['full_name'] as String?) ?? '',
      passportNumber: details['passport_number'] as String?,
      travelPermitNumber: details['travel_permit_number'] as String?,
      fieldStatus: details['field_status'] as String?,
      medicalTestStatus: details['medical_test_status'] as String?,
      hotelName: details['hotel_name'] as String?,
      transportationDetails: details['transportation_details'] as String?,
    );
  }

  Map<String, dynamic>? _detailsMap(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is List) {
      if (value.isEmpty) {
        return null;
      }
      return Map<String, dynamic>.from(value.first as Map);
    }
    return Map<String, dynamic>.from(value as Map);
  }
}

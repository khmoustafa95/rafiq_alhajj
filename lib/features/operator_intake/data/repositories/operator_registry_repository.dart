import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_record.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_update.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OperatorRegistryException implements Exception {
  const OperatorRegistryException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Operator registry request failed';
}

class OperatorRegistryRepository {
  OperatorRegistryRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  static const _profileSelect =
      'id, full_name, '
      'pilgrim_details(passport_number, travel_permit_number, medical_test_status, '
      'travel_date, hotel_name, hotel_location_url, transportation_details)';

  Future<List<OperatorPilgrimSummary>> fetchAll() async {
    if (!isAvailable) {
      throw const OperatorRegistryException('Supabase is not configured');
    }

    try {
      final rows = await _client!
          .from('profiles')
          .select(_profileSelect)
          .eq('role', 'pilgrim')
          .order('full_name');

      return _mapSummaries(rows as List<dynamic>);
    } on PostgrestException catch (e) {
      throw OperatorRegistryException(e.message);
    }
  }

  Future<OperatorPilgrimRecord?> fetchById(String profileId) async {
    if (!isAvailable) {
      throw const OperatorRegistryException('Supabase is not configured');
    }

    try {
      final row = await _client!
          .from('profiles')
          .select(_profileSelect)
          .eq('id', profileId)
          .eq('role', 'pilgrim')
          .maybeSingle();

      if (row == null) {
        return null;
      }

      return _mapRecord(Map<String, dynamic>.from(row));
    } on PostgrestException catch (e) {
      throw OperatorRegistryException(e.message);
    }
  }

  Future<void> updateLogistics({
    required String profileId,
    required OperatorPilgrimUpdate update,
  }) async {
    if (!isAvailable) {
      throw const OperatorRegistryException('Supabase is not configured');
    }

    try {
      await _client!
          .from('pilgrim_details')
          .update(update.toDatabasePayload())
          .eq('profile_id', profileId);
    } on PostgrestException catch (e) {
      throw OperatorRegistryException(e.message);
    }
  }

  List<OperatorPilgrimSummary> _mapSummaries(List<dynamic> rows) {
    final items = <OperatorPilgrimSummary>[];
    for (final raw in rows) {
      final row = Map<String, dynamic>.from(raw as Map);
      final details = _detailsMap(row['pilgrim_details']);
      items.add(
        OperatorPilgrimSummary(
          profileId: row['id'] as String,
          fullName: (row['full_name'] as String?) ?? '',
          passportNumber: details?['passport_number'] as String?,
          travelPermitNumber: details?['travel_permit_number'] as String?,
          medicalTestStatus: details?['medical_test_status'] as String?,
          travelDate: _parseDate(details?['travel_date']),
          hotelName: details?['hotel_name'] as String?,
        ),
      );
    }
    return items;
  }

  OperatorPilgrimRecord? _mapRecord(Map<String, dynamic> row) {
    final details = _detailsMap(row['pilgrim_details']);
    if (details == null) {
      return null;
    }

    return OperatorPilgrimRecord(
      profileId: row['id'] as String,
      fullName: (row['full_name'] as String?) ?? '',
      passportNumber: details['passport_number'] as String?,
      travelPermitNumber: details['travel_permit_number'] as String?,
      medicalTestStatus: details['medical_test_status'] as String?,
      travelDate: _parseDate(details['travel_date']),
      hotelName: details['hotel_name'] as String?,
      hotelLocationUrl: details['hotel_location_url'] as String?,
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

  DateTime? _parseDate(dynamic value) {
    if (value == null) {
      return null;
    }
    return DateTime.tryParse(value.toString());
  }
}

import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/utils/postgrest_search_sanitize.dart';
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

class PilgrimGroupOption {
  const PilgrimGroupOption({required this.id, required this.name});

  final String id;
  final String name;
}

class OperatorRegistryRepository {
  OperatorRegistryRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  static const _profileSelect =
      'id, full_name, group_id, '
      'groups(name), '
      'pilgrim_details(passport_number, travel_permit_number, medical_test_status, '
      'travel_date, hotel_name, hotel_location_url, transportation_details, gender)';

  Future<List<OperatorPilgrimSummary>> fetchAll() async {
    final page = await fetchPage(const StaffTableQuery(pageSize: 1000));
    return page.items;
  }

  Future<List<PilgrimGroupOption>> fetchGroupOptions() async {
    if (!isAvailable) {
      return const [];
    }

    try {
      final rows = await _client!
          .from('groups')
          .select('id, name')
          .order('name');

      return (rows as List<dynamic>)
          .map(
            (raw) => PilgrimGroupOption(
              id: (raw as Map)['id'] as String,
              name: raw['name'] as String,
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw OperatorRegistryException(e.message);
    }
  }

  Future<Set<String>> _profileIdsMatchingDetailsSearch(String term) async {
    final rows = await _client!
        .from('pilgrim_details')
        .select('profile_id')
        .or(
          'passport_number.ilike.%$term%,travel_permit_number.ilike.%$term%',
        );

    return (rows as List<dynamic>)
        .map((row) => (row as Map)['profile_id'] as String)
        .toSet();
  }

  PostgrestFilterBuilder<PostgrestList> _applyPilgrimSearch(
    PostgrestFilterBuilder<PostgrestList> request,
    String term,
    Set<String> detailProfileIds,
  ) {
    if (detailProfileIds.isEmpty) {
      return request.ilike('full_name', '%$term%');
    }

    final idList = detailProfileIds.join(',');
    return request.or('full_name.ilike.%$term%,id.in.($idList)');
  }

  PostgrestTransformBuilder<PostgrestList> _applyPilgrimSort(
    PostgrestFilterBuilder<PostgrestList> request,
    StaffTableQuery query,
  ) {
    return switch (query.sortColumnId) {
      'passport' => request.order(
          'pilgrim_details(passport_number)',
          ascending: query.sortAscending,
        ),
      'travel_date' => request.order(
          'pilgrim_details(travel_date)',
          ascending: query.sortAscending,
        ),
      'gender' => request.order(
          'pilgrim_details(gender)',
          ascending: query.sortAscending,
        ),
      'group' => request.order(
          'name',
          ascending: query.sortAscending,
          referencedTable: 'groups',
        ),
      'travel_permit' => request.order(
          'pilgrim_details(travel_permit_number)',
          ascending: query.sortAscending,
        ),
      'medical_test' => request.order(
          'pilgrim_details(medical_test_status)',
          ascending: query.sortAscending,
        ),
      'hotel' => request.order(
          'pilgrim_details(hotel_name)',
          ascending: query.sortAscending,
        ),
      _ => request.order('full_name', ascending: query.sortAscending),
    };
  }

  Future<PaginatedResult<OperatorPilgrimSummary>> fetchPage(
    StaffTableQuery query,
  ) async {
    if (!isAvailable) {
      throw const OperatorRegistryException('Supabase is not configured');
    }

    try {
      var select = _profileSelect;
      final gender = query.filters['gender'];
      if (gender != null && gender.isNotEmpty) {
        select = select.replaceFirst(
          'pilgrim_details(',
          'pilgrim_details!inner(',
        );
      }

      var request = _client!
          .from('profiles')
          .select(select)
          .eq('role', 'pilgrim');

      final search = query.search.trim();
      if (search.isNotEmpty) {
        final term = sanitizePostgrestSearchTerm(search);
        final detailProfileIds = await _profileIdsMatchingDetailsSearch(term);
        request = _applyPilgrimSearch(request, term, detailProfileIds);
      }

      final groupId = query.filters['group_id'];
      if (groupId != null && groupId.isNotEmpty) {
        request = request.eq('group_id', groupId);
      }

      if (gender != null && gender.isNotEmpty) {
        request = request.eq('pilgrim_details.gender', gender);
      }

      final response = await _applyPilgrimSort(request, query)
          .range(query.from, query.to)
          .count(CountOption.exact);

      final rows = response.data as List<dynamic>;
      final items = _mapSummaries(rows);
      return PaginatedResult(
        items: items,
        totalCount: response.count,
        pageSize: query.pageSize,
      );
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

  Future<void> savePilgrim({
    required String profileId,
    required OperatorPilgrimUpdate update,
    bool includeProfileFields = false,
  }) async {
    if (!isAvailable) {
      throw const OperatorRegistryException('Supabase is not configured');
    }

    try {
      if (includeProfileFields) {
        await _client!
            .from('profiles')
            .update(update.toProfilePayload())
            .eq('id', profileId);
      }

      await _client!
          .from('pilgrim_details')
          .update(update.toDetailsPayload())
          .eq('profile_id', profileId);
    } on PostgrestException catch (e) {
      throw OperatorRegistryException(e.message);
    }
  }

  Future<void> bulkAssignGroup({
    required List<String> profileIds,
    required String? groupId,
  }) async {
    if (!isAvailable) {
      throw const OperatorRegistryException('Supabase is not configured');
    }
    if (profileIds.isEmpty) {
      return;
    }

    try {
      await _client!
          .from('profiles')
          .update({'group_id': groupId})
          .inFilter('id', profileIds);
    } on PostgrestException catch (e) {
      throw OperatorRegistryException(e.message);
    }
  }

  List<OperatorPilgrimSummary> _mapSummaries(List<dynamic> rows) {
    final items = <OperatorPilgrimSummary>[];
    for (final raw in rows) {
      final row = Map<String, dynamic>.from(raw as Map);
      final details = _detailsMap(row['pilgrim_details']);
      final group = _groupMap(row['groups']);
      items.add(
        OperatorPilgrimSummary(
          profileId: row['id'] as String,
          fullName: (row['full_name'] as String?) ?? '',
          passportNumber: details?['passport_number'] as String?,
          travelPermitNumber: details?['travel_permit_number'] as String?,
          medicalTestStatus: details?['medical_test_status'] as String?,
          travelDate: _parseDate(details?['travel_date']),
          hotelName: details?['hotel_name'] as String?,
          gender: details?['gender'] as String?,
          groupId: row['group_id'] as String?,
          groupName: group?['name'] as String?,
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

    final group = _groupMap(row['groups']);

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
      gender: details['gender'] as String?,
      groupId: row['group_id'] as String?,
      groupName: group?['name'] as String?,
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

  Map<String, dynamic>? _groupMap(dynamic value) {
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

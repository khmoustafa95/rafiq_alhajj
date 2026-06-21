import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/features/operator_intake/data/data_sources/operator_registry_remote_data_source.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_record.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_summary.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/operator_pilgrim_update.dart';
import 'package:rafiq_alhajj/features/operator_intake/domain/models/pilgrim_credentials.dart';
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
  OperatorRegistryRepository([SupabaseClient? client])
      : _remote =
            client == null ? null : OperatorRegistryRemoteDataSource(client);

  final OperatorRegistryRemoteDataSource? _remote;

  bool get isAvailable => AppConfig.hasSupabase && _remote != null;

  Future<List<OperatorPilgrimSummary>> fetchAll({String? tripId}) async {
    final page = await fetchPage(
      const StaffTableQuery(pageSize: 1000),
      tripId: tripId,
    );
    return page.items;
  }

  Future<List<PilgrimGroupOption>> fetchGroupOptions() async {
    if (!isAvailable) {
      return const [];
    }
    final remote = _remote!;
    try {
      final rows = await remote.fetchGroupOptions();

      return rows
          .map(
            (raw) => PilgrimGroupOption(
              id: raw['id'] as String,
              name: raw['name'] as String,
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw OperatorRegistryException(e.message);
    }
  }

  Future<PaginatedResult<OperatorPilgrimSummary>> fetchPage(
    StaffTableQuery query, {
    String? tripId,
  }) async {
    if (!isAvailable) {
      throw const OperatorRegistryException('Supabase is not configured');
    }
    final remote = _remote!;
    try {
      final result = await remote.fetchPage(query, tripId: tripId);
      final items = result.rows.map(_mapSummary).toList(growable: false);

      return PaginatedResult(
        items: items,
        totalCount: result.count,
        pageSize: query.pageSize,
      );
    } on PostgrestException catch (e) {
      throw OperatorRegistryException(e.message);
    }
  }

  Future<OperatorPilgrimRecord?> fetchById(
    String pilgrimId, {
    String? tripId,
  }) async {
    if (!isAvailable) {
      throw const OperatorRegistryException('Supabase is not configured');
    }
    final remote = _remote!;
    try {
      final rows = await remote.fetchById(pilgrimId, tripId: tripId);
      if (rows.isEmpty) {
        return null;
      }

      return _mapRecord(rows.first);
    } on PostgrestException catch (e) {
      throw OperatorRegistryException(e.message);
    }
  }

  Future<void> savePilgrim({
    required String pilgrimId,
    required OperatorPilgrimUpdate update,
    bool includeProfileFields = false,
    String? tripId,
    String? enrollmentId,
  }) async {
    if (!isAvailable) {
      throw const OperatorRegistryException('Supabase is not configured');
    }
    final remote = _remote!;
    try {
      await remote.updatePilgrimPerson(pilgrimId, update.toPersonPayload());

      await remote.updateEnrollment(
        pilgrimId,
        update.toEnrollmentPayload(includeGroup: includeProfileFields),
        enrollmentId: enrollmentId,
        tripId: tripId,
      );

      if (includeProfileFields) {
        final pilgrim = await remote.fetchPilgrimProfileId(pilgrimId);
        final profileId = pilgrim?['profile_id'] as String?;
        if (profileId != null) {
          await remote.updateProfile(profileId, update.toProfilePayload());
        }
      }
    } on PostgrestException catch (e) {
      throw OperatorRegistryException(e.message);
    }
  }

  Future<PilgrimCredentials> resetPilgrimPassword(String profileId) async {
    if (!isAvailable) {
      throw const OperatorRegistryException('Supabase is not configured');
    }
    final remote = _remote!;
    try {
      final response = await remote.resetPilgrimPassword(profileId);
      if (response.status != 200) {
        final error = response.data is Map
            ? (response.data as Map)['error']?.toString()
            : null;
        throw OperatorRegistryException(error ?? 'Password reset failed');
      }
      final data = Map<String, dynamic>.from(response.data as Map);
      return PilgrimCredentials(
        email: data['email'] as String,
        password: data['password'] as String,
      );
    } on FunctionException catch (e) {
      throw OperatorRegistryException(e.reasonPhrase ?? 'Edge function error');
    } on PostgrestException catch (e) {
      throw OperatorRegistryException(e.message);
    }
  }

  Future<void> bulkAssignGroup({
    required List<String> pilgrimIds,
    required String? groupId,
    String? tripId,
  }) async {
    if (!isAvailable) {
      throw const OperatorRegistryException('Supabase is not configured');
    }
    final remote = _remote!;
    if (pilgrimIds.isEmpty) {
      return;
    }

    try {
      await remote.bulkAssignGroup(
        pilgrimIds: pilgrimIds,
        groupId: groupId,
        tripId: tripId,
      );
    } on PostgrestException catch (e) {
      throw OperatorRegistryException(e.message);
    }
  }

  OperatorPilgrimSummary _mapSummary(Map<String, dynamic> row) {
    return OperatorPilgrimSummary(row);
  }

  OperatorPilgrimRecord _mapRecord(Map<String, dynamic> row) {
    return OperatorPilgrimRecord(row);
  }
}

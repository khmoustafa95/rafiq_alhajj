import 'package:rafiq_alhajj/features/trips/data/data_sources/trips_remote_data_source.dart';
import 'package:rafiq_alhajj/features/trips/domain/models/trip.dart';
import 'package:rafiq_alhajj/features/trips/domain/models/trip_editor_input.dart';
import 'package:rafiq_alhajj/features/trips/domain/models/trip_office.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TripsException implements Exception {
  const TripsException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Trips request failed';
}

/// Data access for trips (seasonal journeys) and the offices participating in
/// them via `trip_groups`. Delegates raw Supabase calls to
/// [TripsRemoteDataSource] and maps rows to domain models.
class TripsRepository {
  TripsRepository([SupabaseClient? client])
      : _remote = client == null ? null : TripsRemoteDataSource(client);

  final TripsRemoteDataSource? _remote;

  bool get isAvailable => _remote != null;

  Future<List<Trip>> fetchTrips() async {
    final remote = _remote;
    if (remote == null) {
      return const [];
    }

    try {
      final rows = await remote.fetchTrips();
      return rows.map(_rowToTrip).toList(growable: false);
    } on PostgrestException catch (e) {
      throw TripsException(e.message);
    }
  }

  Future<Trip> fetchById(String id) async {
    final remote = _remote;
    if (remote == null) {
      throw const TripsException('Supabase is not configured');
    }

    try {
      return _rowToTrip(await remote.fetchById(id));
    } on PostgrestException catch (e) {
      throw TripsException(e.message);
    }
  }

  Future<Trip> save(TripEditorInput input) async {
    final remote = _remote;
    if (remote == null) {
      throw const TripsException('Supabase is not configured');
    }

    try {
      final payload = <String, dynamic>{
        'type': input.type,
        'season_year': input.seasonYear,
        'name': input.name.trim(),
        'status': input.status,
        'start_date': input.startDate?.toIso8601String().split('T').first,
        'end_date': input.endDate?.toIso8601String().split('T').first,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      };

      final row = await remote.upsert(payload, id: input.id);
      return _rowToTrip(row);
    } on PostgrestException catch (e) {
      throw TripsException(e.message);
    }
  }

  Future<void> delete(String id) async {
    final remote = _remote;
    if (remote == null) {
      throw const TripsException('Supabase is not configured');
    }

    try {
      await remote.delete(id);
    } on PostgrestException catch (e) {
      throw TripsException(e.message);
    }
  }

  Future<List<TripOffice>> fetchOffices(String tripId) async {
    final remote = _remote;
    if (remote == null) {
      return const [];
    }

    try {
      final rows = await remote.fetchOffices(tripId);
      return rows.map(_rowToOffice).toList(growable: false);
    } on PostgrestException catch (e) {
      throw TripsException(e.message);
    }
  }

  /// Offices (`groups`) not yet linked to [tripId].
  Future<List<TripGroupOption>> fetchAvailableGroups(String tripId) async {
    final remote = _remote;
    if (remote == null) {
      return const [];
    }

    try {
      final linked = await remote.fetchLinkedGroups(tripId);
      final linkedIds =
          linked.map((row) => row['group_id'] as String).toSet();

      final rows = await remote.fetchAllGroups();
      return rows
          .where((row) => !linkedIds.contains(row['id'] as String))
          .map(
            (row) => TripGroupOption(
              id: row['id'] as String,
              name: row['name'] as String? ?? '',
            ),
          )
          .toList(growable: false);
    } on PostgrestException catch (e) {
      throw TripsException(e.message);
    }
  }

  Future<void> addOffice({
    required String tripId,
    required String groupId,
  }) async {
    final remote = _remote;
    if (remote == null) {
      throw const TripsException('Supabase is not configured');
    }

    try {
      await remote.addOffice(tripId: tripId, groupId: groupId);
    } on PostgrestException catch (e) {
      throw TripsException(e.message);
    }
  }

  /// Toggle an office between `active` and `withdrawn` (the coalition leave/join).
  Future<void> setOfficeStatus({
    required String tripGroupId,
    required String status,
  }) async {
    final remote = _remote;
    if (remote == null) {
      throw const TripsException('Supabase is not configured');
    }

    try {
      await remote.setOfficeStatus(tripGroupId: tripGroupId, status: status);
    } on PostgrestException catch (e) {
      throw TripsException(e.message);
    }
  }

  Future<void> removeOffice(String tripGroupId) async {
    final remote = _remote;
    if (remote == null) {
      throw const TripsException('Supabase is not configured');
    }

    try {
      await remote.removeOffice(tripGroupId);
    } on PostgrestException catch (e) {
      throw TripsException(e.message);
    }
  }

  Trip _rowToTrip(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] as String,
      type: map['type'] as String? ?? 'hajj',
      seasonYear: (map['season_year'] as num?)?.toInt() ?? 0,
      name: map['name'] as String? ?? '',
      status: map['status'] as String? ?? 'planning',
      startDate: _parseDate(map['start_date']),
      endDate: _parseDate(map['end_date']),
      createdAt: _parseDate(map['created_at']),
      updatedAt: _parseDate(map['updated_at']),
    );
  }

  TripOffice _rowToOffice(Map<String, dynamic> map) {
    final group = map['groups'];
    final groupMap = group is Map ? Map<String, dynamic>.from(group) : null;
    return TripOffice(
      tripGroupId: map['id'] as String,
      tripId: map['trip_id'] as String,
      groupId: map['group_id'] as String,
      groupName: groupMap?['name'] as String? ?? '',
      status: map['status'] as String? ?? 'active',
      presidentName: groupMap?['president_name'] as String?,
      joinedAt: _parseDate(map['joined_at']),
      withdrawnAt: _parseDate(map['withdrawn_at']),
    );
  }

  DateTime? _parseDate(dynamic value) {
    if (value is String && value.isNotEmpty) {
      return DateTime.tryParse(value);
    }
    return null;
  }
}

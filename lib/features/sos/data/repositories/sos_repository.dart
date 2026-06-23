import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/sos/data/data_sources/sos_remote_data_source.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_alert.dart';
import 'package:rafiq_alhajj/features/sos/domain/models/sos_ping.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SosException implements Exception {
  const SosException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'SOS request failed';
}

class SosRepository {
  SosRepository([SupabaseClient? client])
      : _remote = (AppConfig.hasSupabase && client != null)
            ? SosRemoteDataSource(client)
            : null;

  final SosRemoteDataSource? _remote;

  bool get isAvailable => _remote != null;

  Future<String> raiseAlert({
    double? latitude,
    double? longitude,
    double? accuracy,
  }) async {
    final remote = _requireRemote();
    try {
      return await remote.raiseAlert(
        latitude: latitude,
        longitude: longitude,
        accuracy: accuracy,
      );
    } on PostgrestException catch (e) {
      throw SosException(e.message);
    }
  }

  Future<void> pushLocation({
    required String alertId,
    required double latitude,
    required double longitude,
    double? accuracy,
  }) async {
    final remote = _requireRemote();
    try {
      await remote.pushLocation(
        alertId: alertId,
        latitude: latitude,
        longitude: longitude,
        accuracy: accuracy,
      );
    } on PostgrestException catch (e) {
      throw SosException(e.message);
    }
  }

  Future<void> cancelByPilgrim(String alertId) async {
    final remote = _requireRemote();
    try {
      await remote.cancelByPilgrim(alertId);
    } on PostgrestException catch (e) {
      throw SosException(e.message);
    }
  }

  Future<void> resolveByStaff(String alertId) async {
    final remote = _requireRemote();
    try {
      await remote.resolveByStaff(alertId);
    } on PostgrestException catch (e) {
      throw SosException(e.message);
    }
  }

  Future<SosAlert?> fetchMyActiveAlert(String profileId) async {
    final remote = _remote;
    if (remote == null) {
      return null;
    }
    try {
      final row = await remote.fetchMyActiveAlert(profileId);
      return row == null ? null : _mapAlert(row);
    } on PostgrestException catch (e) {
      throw SosException(e.message);
    }
  }

  Future<List<SosAlert>> fetchActiveAlerts() async {
    final remote = _remote;
    if (remote == null) {
      return const [];
    }
    try {
      final rows = await remote.fetchActiveAlerts();
      return rows.map(_mapAlert).toList(growable: false);
    } on PostgrestException catch (e) {
      throw SosException(e.message);
    }
  }

  Future<List<SosPing>> fetchPings(String alertId) async {
    final remote = _remote;
    if (remote == null) {
      return const [];
    }
    try {
      final rows = await remote.fetchPings(alertId);
      return rows.map(_mapPing).toList(growable: false);
    } on PostgrestException catch (e) {
      throw SosException(e.message);
    }
  }

  SosRemoteDataSource _requireRemote() {
    final remote = _remote;
    if (remote == null) {
      throw const SosException('Supabase is not configured');
    }
    return remote;
  }

  SosAlert _mapAlert(Map<String, dynamic> map) {
    final profile = map['profiles'];
    final group = map['groups'];
    return SosAlert(
      id: map['id'] as String,
      pilgrimProfileId: map['pilgrim_profile_id'] as String,
      pilgrimName: profile is Map ? profile['full_name'] as String? : null,
      groupId: map['group_id'] as String?,
      groupName: group is Map ? group['name'] as String? : null,
      status: SosStatus.fromName(map['status'] as String?),
      latitude: (map['latitude'] as num?)?.toDouble(),
      longitude: (map['longitude'] as num?)?.toDouble(),
      accuracy: (map['accuracy'] as num?)?.toDouble(),
      note: map['note'] as String?,
      startedAt:
          DateTime.tryParse(map['started_at'] as String? ?? '')?.toLocal() ??
              DateTime.now(),
      lastLocationAt: map['last_location_at'] != null
          ? DateTime.tryParse(map['last_location_at'] as String)?.toLocal()
          : null,
    );
  }

  SosPing _mapPing(Map<String, dynamic> map) {
    return SosPing(
      id: map['id'] as String,
      alertId: map['alert_id'] as String,
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      accuracy: (map['accuracy'] as num?)?.toDouble(),
      createdAt:
          DateTime.tryParse(map['created_at'] as String? ?? '')?.toLocal() ??
              DateTime.now(),
    );
  }
}

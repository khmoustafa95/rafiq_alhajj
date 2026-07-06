import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/admin_analytics/data/data_sources/admin_analytics_remote_data_source.dart';
import 'package:rafiq_alhajj/features/admin_analytics/data/mappers/admin_dashboard_stats_mapper.dart';
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/admin_dashboard_stats.dart';
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/chart_slice.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_pilgrim_status.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminAnalyticsException implements Exception {
  const AdminAnalyticsException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Admin analytics request failed';
}

/// Label key for pilgrims without a group — translate in UI via [adminUnassignedGroup].
const String kUnassignedGroupKey = '__unassigned__';

class AdminAnalyticsRepository {
  AdminAnalyticsRepository([SupabaseClient? client])
      : _remote =
            client == null ? null : AdminAnalyticsRemoteDataSource(client);

  final AdminAnalyticsRemoteDataSource? _remote;

  bool get isAvailable => AppConfig.hasSupabase && _remote != null;

  Future<AdminDashboardStats> fetchDashboardStats({String? tripId}) async {
    if (!isAvailable) {
      throw const AdminAnalyticsException('Supabase is not configured');
    }
    final remote = _remote!;

    try {
      final json = await remote
          .fetchDashboardStatsRpc(tripId: tripId)
          .timeout(
            const Duration(seconds: 30),
            onTimeout: () => throw const AdminAnalyticsException(
              'Dashboard metrics request timed out',
            ),
          );
      return AdminDashboardStatsMapper.fromRpcJson(json);
    } on PostgrestException catch (e) {
      throw AdminAnalyticsException(e.message);
    }
  }

  /// Legacy multi-query aggregation — kept for reference/tests; prefer RPC above.
  Future<AdminDashboardStats> fetchDashboardStatsLegacy({String? tripId}) async {
    if (!isAvailable) {
      throw const AdminAnalyticsException('Supabase is not configured');
    }
    final remote = _remote!;

    try {
      final results = await Future.wait<dynamic>([
        remote.fetchOperators(),
        remote.fetchGroups(),
        remote.fetchEnrollments(tripId: tripId),
        remote.fetchDocumentUploaders(),
        remote.fetchActiveSosCount(),
        remote.fetchPushFailureCount(),
        remote.fetchActiveCompetitionCount(),
        remote.fetchCompetitionEntryCount(),
        remote.fetchPublishedContentCount(),
        remote.fetchPilgrimDeviceTokens(),
        if (tripId != null)
          remote.fetchTripById(tripId)
        else
          Future<Map<String, dynamic>?>.value(),
      ]).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw const AdminAnalyticsException(
          'Dashboard metrics request timed out',
        ),
      );

      final operatorRows = results[0] as List<Map<String, dynamic>>;
      final groupRows = results[1] as List<Map<String, dynamic>>;
      final enrollmentRows = results[2] as List<Map<String, dynamic>>;
      final documentRows = results[3] as List<Map<String, dynamic>>;
      final activeSosCount = results[4] as int;
      final pushFailureCount = results[5] as int;
      final activeCompetitionCount = results[6] as int;
      final competitionParticipantCount = results[7] as int;
      final publishedContentCount = results[8] as int;
      final deviceTokenRows = results[9] as List<Map<String, dynamic>>;
      final tripRow = results.length > 10
          ? results[10] as Map<String, dynamic>?
          : null;

      final groupNames = <String, String>{
        for (final row in groupRows)
          row['id'] as String: row['name'] as String,
      };

      final groupCounts = <String, int>{};
      final statusCounts = <String, int>{};
      var arrivedHotelCount = 0;
      var pendingFieldCount = 0;
      var inTransitCount = 0;
      var unassignedPilgrimCount = 0;
      var specialNeedsCount = 0;
      var missingTravelPermitCount = 0;
      var missingMedicalTestCount = 0;
      var pilgrimsWithoutLoginCount = 0;

      for (final row in enrollmentRows) {
        final map = Map<String, dynamic>.from(row);

        final groupId = map['group_id'] as String?;
        if (groupId == null) {
          unassignedPilgrimCount++;
        }
        final label = groupId == null
            ? kUnassignedGroupKey
            : groupNames[groupId] ?? kUnassignedGroupKey;
        groupCounts[label] = (groupCounts[label] ?? 0) + 1;

        final status =
            map['field_status'] as String? ?? FieldPilgrimStatus.pending;
        statusCounts[status] = (statusCounts[status] ?? 0) + 1;

        switch (status) {
          case FieldPilgrimStatus.arrivedHotel:
          case FieldPilgrimStatus.completed:
            arrivedHotelCount++;
          case FieldPilgrimStatus.inTransit:
          case FieldPilgrimStatus.medicalDone:
            inTransitCount++;
          case FieldPilgrimStatus.pending:
            pendingFieldCount++;
        }

        if (map['needs_wheelchair'] == true) {
          specialNeedsCount++;
        }

        final travelPermit = map['travel_permit_number'] as String?;
        if (travelPermit == null || travelPermit.trim().isEmpty) {
          missingTravelPermitCount++;
        }

        final medicalTest = map['medical_test_status'] as String?;
        if (medicalTest == null || medicalTest.trim().isEmpty) {
          missingMedicalTestCount++;
        }

        final pilgrim = map['pilgrims'];
        String? profileId;
        if (pilgrim is Map) {
          profileId = pilgrim['profile_id'] as String?;
        }
        if (profileId == null || profileId.isEmpty) {
          pilgrimsWithoutLoginCount++;
        }
      }

      final uploadCounts = <String, int>{};
      for (final row in documentRows) {
        final map = Map<String, dynamic>.from(row);
        final profile = map['profiles'];
        var name = kUnknownOperatorKey;
        if (profile is Map) {
          name = (profile['full_name'] as String?) ?? name;
        } else if (profile is List && profile.isNotEmpty) {
          name = (profile.first as Map)['full_name'] as String? ?? name;
        }
        uploadCounts[name] = (uploadCounts[name] ?? 0) + 1;
      }

      final pilgrimPushTokenCount = _countPilgrimPushTokens(deviceTokenRows);

      return AdminDashboardStats(
        scopedTripId: tripId,
        scopedTripLabel: _tripLabel(tripRow),
        pilgrimCount: enrollmentRows.length,
        operatorCount: operatorRows.length,
        groupCount: groupRows.length,
        arrivedHotelCount: arrivedHotelCount,
        pendingFieldCount: pendingFieldCount,
        inTransitCount: inTransitCount,
        activeSosCount: activeSosCount,
        unassignedPilgrimCount: unassignedPilgrimCount,
        specialNeedsCount: specialNeedsCount,
        missingTravelPermitCount: missingTravelPermitCount,
        missingMedicalTestCount: missingMedicalTestCount,
        pilgrimsWithoutLoginCount: pilgrimsWithoutLoginCount,
        pilgrimPushTokenCount: pilgrimPushTokenCount,
        pushFailureCount: pushFailureCount,
        activeCompetitionCount: activeCompetitionCount,
        competitionParticipantCount: competitionParticipantCount,
        publishedContentCount: publishedContentCount,
        pilgrimsByGroup: _toSlices(groupCounts),
        fieldStatusBreakdown: _toSlices(statusCounts),
        operatorDocumentUploads: _toSlices(uploadCounts),
      );
    } on PostgrestException catch (e) {
      throw AdminAnalyticsException(e.message);
    }
  }

  int _countPilgrimPushTokens(List<Map<String, dynamic>> rows) {
    final pilgrimProfileIds = <String>{};
    for (final row in rows) {
      final profileId = row['profile_id'] as String?;
      if (profileId == null) {
        continue;
      }
      final profile = row['profiles'];
      var role = '';
      if (profile is Map) {
        role = profile['role'] as String? ?? '';
      }
      if (role == 'pilgrim') {
        pilgrimProfileIds.add(profileId);
      }
    }
    return pilgrimProfileIds.length;
  }

  String? _tripLabel(Map<String, dynamic>? tripRow) {
    if (tripRow == null) {
      return null;
    }
    final name = tripRow['name'] as String? ?? '';
    final type = tripRow['type'] as String? ?? '';
    final year = tripRow['season_year'];
    final yearLabel = year == null ? '' : ' $year';
    return '$type$yearLabel · $name'.trim();
  }

  List<ChartSlice> _toSlices(Map<String, int> counts) {
    final entries = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries
        .map((e) => ChartSlice(label: e.key, value: e.value))
        .toList(growable: false);
  }
}

const String kUnknownOperatorKey = '__unknown__';

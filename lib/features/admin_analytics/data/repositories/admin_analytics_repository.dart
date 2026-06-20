import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/admin_analytics/data/data_sources/admin_analytics_remote_data_source.dart';
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/admin_dashboard_stats.dart';
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/chart_slice.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_pilgrim_status.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/ritual_step_definition.dart';
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

  Future<AdminDashboardStats> fetchDashboardStats() async {
    if (!isAvailable) {
      throw const AdminAnalyticsException('Supabase is not configured');
    }
    final remote = _remote!;

    try {
      final results = await Future.wait<List<Map<String, dynamic>>>([
        remote.fetchPilgrims(),
        remote.fetchOperators(),
        remote.fetchGroups(),
        remote.fetchEnrollments(),
        remote.fetchCompletedRitualLogs(),
        remote.fetchDocumentUploaders(),
      ]).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw const AdminAnalyticsException(
          'Dashboard metrics request timed out',
        ),
      );

      final pilgrimRows = results[0];
      final operatorRows = results[1];
      final groupRows = results[2];
      final enrollmentRows = results[3];
      final ritualRows = results[4];
      final documentRows = results[5];

      final groupNames = <String, String>{
        for (final row in groupRows)
          row['id'] as String: row['name'] as String,
      };

      final groupCounts = <String, int>{};
      final statusCounts = <String, int>{};
      for (final row in enrollmentRows) {
        final map = Map<String, dynamic>.from(row);
        final groupId = map['group_id'] as String?;
        final label = groupId == null
            ? kUnassignedGroupKey
            : groupNames[groupId] ?? kUnassignedGroupKey;
        groupCounts[label] = (groupCounts[label] ?? 0) + 1;

        final status =
            map['field_status'] as String? ?? FieldPilgrimStatus.pending;
        statusCounts[status] = (statusCounts[status] ?? 0) + 1;
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

      final pilgrimCount = pilgrimRows.length;
      final totalRitualSlots = enrollmentRows.length * HajjRitualSteps.all.length;
      final completedRituals = ritualRows.length;
      final ritualPercent = totalRitualSlots == 0
          ? 0.0
          : (completedRituals / totalRitualSlots * 100).clamp(0, 100);

      return AdminDashboardStats(
        pilgrimCount: pilgrimCount,
        operatorCount: operatorRows.length,
        ritualCompletionPercent: ritualPercent.toDouble(),
        pilgrimsByGroup: _toSlices(groupCounts),
        fieldStatusBreakdown: _toSlices(statusCounts),
        operatorDocumentUploads: _toSlices(uploadCounts),
      );
    } on PostgrestException catch (e) {
      throw AdminAnalyticsException(e.message);
    }
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

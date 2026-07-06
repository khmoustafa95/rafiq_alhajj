import 'package:rafiq_alhajj/features/admin_analytics/data/repositories/admin_analytics_repository.dart';
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/admin_dashboard_stats.dart';
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/chart_slice.dart';

/// Maps the [fetch_admin_dashboard_stats] RPC JSON payload to [AdminDashboardStats].
abstract final class AdminDashboardStatsMapper {
  static AdminDashboardStats fromRpcJson(Map<String, dynamic> json) {
    return AdminDashboardStats(
      scopedTripId: json['scoped_trip_id'] as String?,
      scopedTripLabel: json['scoped_trip_label'] as String?,
      pilgrimCount: _int(json['pilgrim_count']),
      operatorCount: _int(json['operator_count']),
      groupCount: _int(json['group_count']),
      arrivedHotelCount: _int(json['arrived_hotel_count']),
      pendingFieldCount: _int(json['pending_field_count']),
      inTransitCount: _int(json['in_transit_count']),
      activeSosCount: _int(json['active_sos_count']),
      unassignedPilgrimCount: _int(json['unassigned_pilgrim_count']),
      specialNeedsCount: _int(json['special_needs_count']),
      missingTravelPermitCount: _int(json['missing_travel_permit_count']),
      missingMedicalTestCount: _int(json['missing_medical_test_count']),
      pilgrimsWithoutLoginCount: _int(json['pilgrims_without_login_count']),
      pilgrimPushTokenCount: _int(json['pilgrim_push_token_count']),
      pushFailureCount: _int(json['push_failure_count']),
      activeCompetitionCount: _int(json['active_competition_count']),
      competitionParticipantCount: _int(json['competition_participant_count']),
      publishedContentCount: _int(json['published_content_count']),
      pilgrimsByGroup: _slices(json['pilgrims_by_group']),
      fieldStatusBreakdown: _slices(json['field_status_breakdown']),
      operatorDocumentUploads: _slices(json['operator_document_uploads']),
    );
  }

  static int _int(dynamic value) => value is num ? value.toInt() : 0;

  static List<ChartSlice> _slices(dynamic raw) {
    if (raw is! List) {
      return const [];
    }
    return raw
        .map((entry) {
          if (entry is! Map) {
            return null;
          }
          final map = Map<String, dynamic>.from(entry);
          return ChartSlice(
            label: map['label'] as String? ?? kUnassignedGroupKey,
            value: _int(map['value']),
          );
        })
        .whereType<ChartSlice>()
        .toList(growable: false);
  }
}

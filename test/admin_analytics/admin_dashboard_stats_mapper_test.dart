import 'package:flutter_test/flutter_test.dart';
import 'package:rafiq_alhajj/features/admin_analytics/data/mappers/admin_dashboard_stats_mapper.dart';
import 'package:rafiq_alhajj/features/admin_analytics/data/repositories/admin_analytics_repository.dart';

void main() {
  group('AdminDashboardStatsMapper', () {
    test('fromRpcJson maps scalar fields and chart slices', () {
      final stats = AdminDashboardStatsMapper.fromRpcJson({
        'scoped_trip_id': 'trip-1',
        'scoped_trip_label': 'hajj 2026 · Main',
        'pilgrim_count': 42,
        'operator_count': 3,
        'group_count': 5,
        'arrived_hotel_count': 10,
        'pending_field_count': 8,
        'in_transit_count': 6,
        'active_sos_count': 1,
        'unassigned_pilgrim_count': 2,
        'special_needs_count': 4,
        'missing_travel_permit_count': 3,
        'missing_medical_test_count': 1,
        'pilgrims_without_login_count': 5,
        'pilgrim_push_token_count': 20,
        'push_failure_count': 0,
        'active_competition_count': 2,
        'competition_participant_count': 15,
        'published_content_count': 9,
        'pilgrims_by_group': [
          {'label': 'Group A', 'value': 20},
          {'label': kUnassignedGroupKey, 'value': 2},
        ],
        'field_status_breakdown': [
          {'label': 'pending', 'value': 8},
        ],
        'operator_document_uploads': [
          {'label': 'Operator One', 'value': 4},
        ],
      });

      expect(stats.scopedTripId, 'trip-1');
      expect(stats.pilgrimCount, 42);
      expect(stats.pushReachPercent, greaterThan(0));
      expect(stats.pilgrimsByGroup, hasLength(2));
      expect(stats.pilgrimsByGroup.first.label, 'Group A');
      expect(stats.fieldStatusBreakdown.single.label, 'pending');
    });
  });
}

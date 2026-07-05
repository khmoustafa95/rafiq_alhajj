import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/chart_slice.dart';

part 'admin_dashboard_stats.freezed.dart';

@freezed
abstract class AdminDashboardStats with _$AdminDashboardStats {
  const factory AdminDashboardStats({
    required String? scopedTripId,
    required String? scopedTripLabel,
    required int pilgrimCount,
    required int operatorCount,
    required int groupCount,
    required int arrivedHotelCount,
    required int pendingFieldCount,
    required int inTransitCount,
    required int activeSosCount,
    required int unassignedPilgrimCount,
    required int specialNeedsCount,
    required int missingTravelPermitCount,
    required int missingMedicalTestCount,
    required int pilgrimsWithoutLoginCount,
    required int pilgrimPushTokenCount,
    required int pushFailureCount,
    required int activeCompetitionCount,
    required int competitionParticipantCount,
    required int publishedContentCount,
    required List<ChartSlice> pilgrimsByGroup,
    required List<ChartSlice> fieldStatusBreakdown,
    required List<ChartSlice> operatorDocumentUploads,
  }) = _AdminDashboardStats;

  const AdminDashboardStats._();

  int get pilgrimsWithLoginCount =>
      (pilgrimCount - pilgrimsWithoutLoginCount).clamp(0, pilgrimCount);

  int get pushReachPercent {
    if (pilgrimsWithLoginCount == 0) {
      return 0;
    }
    return ((pilgrimPushTokenCount / pilgrimsWithLoginCount) * 100)
        .round()
        .clamp(0, 100);
  }
}

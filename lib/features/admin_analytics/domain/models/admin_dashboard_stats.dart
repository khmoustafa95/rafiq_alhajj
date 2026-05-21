import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/admin_analytics/domain/models/chart_slice.dart';

part 'admin_dashboard_stats.freezed.dart';

@freezed
abstract class AdminDashboardStats with _$AdminDashboardStats {
  const factory AdminDashboardStats({
    required int pilgrimCount,
    required int operatorCount,
    required double ritualCompletionPercent,
    required List<ChartSlice> pilgrimsByGroup,
    required List<ChartSlice> fieldStatusBreakdown,
    required List<ChartSlice> operatorDocumentUploads,
  }) = _AdminDashboardStats;
}

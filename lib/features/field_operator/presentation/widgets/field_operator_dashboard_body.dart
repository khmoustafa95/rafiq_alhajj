import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_operator_stats.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_pilgrim_status.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_progress_summary.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_stat_card.dart';
import 'package:rafiq_alhajj/features/field_operator/presentation/widgets/field_operator_welcome_card.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class FieldOperatorDashboardBody extends StatelessWidget {
  const FieldOperatorDashboardBody({
    required this.stats,
    required this.operatorName,
    required this.onOpenPilgrimsWithFilter,
    required this.onOpenPilgrimsList,
    super.key,
  });

  final FieldOperatorStats stats;
  final String? operatorName;
  final ValueChanged<String?> onOpenPilgrimsWithFilter;
  final VoidCallback onOpenPilgrimsList;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      children: [
        FieldOperatorWelcomeCard(
          name: operatorName,
          total: stats.total,
        ),
        SizedBox(height: 20.h),
        Text(
          l10n.fieldOperatorStatsTitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        SizedBox(height: 4.h),
        Text(
          l10n.fieldOperatorStatsHint,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
        SizedBox(height: 14.h),
        FieldOperatorStatCard(
          label: l10n.fieldOperatorStatsTotal,
          value: stats.total,
          color: AppColors.primary,
          icon: Icons.groups_outlined,
          onTap: () => onOpenPilgrimsWithFilter(null),
        ),
        SizedBox(height: 12.h),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth >= 360 ? 2 : 1;
            return GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10.h,
              crossAxisSpacing: 10.w,
              childAspectRatio: crossAxisCount == 2 ? 1.35 : 2.4,
              children: [
                FieldOperatorStatCard(
                  label: l10n.fieldStatusPending,
                  value: stats.pending,
                  color: AppColors.warning,
                  icon: Icons.hourglass_empty,
                  compact: true,
                  onTap: () => onOpenPilgrimsWithFilter(
                    FieldPilgrimStatus.pending,
                  ),
                ),
                FieldOperatorStatCard(
                  label: l10n.fieldStatusMedicalDone,
                  value: stats.medicalDone,
                  color: AppColors.info,
                  icon: Icons.medical_services_outlined,
                  compact: true,
                  onTap: () => onOpenPilgrimsWithFilter(
                    FieldPilgrimStatus.medicalDone,
                  ),
                ),
                FieldOperatorStatCard(
                  label: l10n.fieldStatusArrivedHotel,
                  value: stats.arrivedHotel,
                  color: AppColors.accentTeal,
                  icon: Icons.hotel_outlined,
                  compact: true,
                  onTap: () => onOpenPilgrimsWithFilter(
                    FieldPilgrimStatus.arrivedHotel,
                  ),
                ),
                FieldOperatorStatCard(
                  label: l10n.fieldStatusInTransit,
                  value: stats.inTransit,
                  color: AppColors.accentPurple,
                  icon: Icons.directions_bus_outlined,
                  compact: true,
                  onTap: () => onOpenPilgrimsWithFilter(
                    FieldPilgrimStatus.inTransit,
                  ),
                ),
                FieldOperatorStatCard(
                  label: l10n.fieldStatusCompleted,
                  value: stats.completed,
                  color: AppColors.success,
                  icon: Icons.check_circle_outline,
                  compact: true,
                  onTap: () => onOpenPilgrimsWithFilter(
                    FieldPilgrimStatus.completed,
                  ),
                ),
                FieldOperatorStatCard(
                  label: l10n.fieldOperatorStatsWheelchair,
                  value: stats.needsWheelchair,
                  color: AppColors.tertiary,
                  icon: Icons.accessible_outlined,
                  compact: true,
                  onTap: onOpenPilgrimsList,
                ),
              ],
            );
          },
        ),
        SizedBox(height: 20.h),
        FieldOperatorProgressSummary(stats: stats),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_operator_stats.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class FieldOperatorProgressSummary extends StatelessWidget {
  const FieldOperatorProgressSummary({
    required this.stats,
    super.key,
  });

  final FieldOperatorStats stats;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    if (stats.total == 0) {
      return const SizedBox.shrink();
    }

    final completedRatio = stats.completed / stats.total;
    final inProgress = stats.total - stats.pending;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.fieldOperatorProgressTitle,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: 12.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: LinearProgressIndicator(
                value: completedRatio,
                minHeight: 10.h,
                backgroundColor: colorScheme.surfaceContainerHighest,
                color: AppColors.success,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              l10n.fieldOperatorProgressSummary(
                stats.completed,
                inProgress,
                stats.total,
              ),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

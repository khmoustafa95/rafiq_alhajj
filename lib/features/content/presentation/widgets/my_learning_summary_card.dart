import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Summary counts for the My Learning hub.
class MyLearningSummaryCard extends StatelessWidget {
  const MyLearningSummaryCard({
    required this.inProgressCount,
    required this.completedCount,
    super.key,
  });

  final int inProgressCount;
  final int completedCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DecoratedBox(
      decoration: AppDecorations.card(radius: AppDecorations.radiusLg),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Expanded(
              child: _SummaryStat(
                icon: Icons.play_lesson_outlined,
                color: AppColors.primary,
                label: l10n.contentMyLearningSummaryInProgress(inProgressCount),
              ),
            ),
            Container(
              width: 1,
              height: 40.h,
              color: AppColors.border,
            ),
            Expanded(
              child: _SummaryStat(
                icon: Icons.check_circle_outline,
                color: AppColors.success,
                label: l10n.contentMyLearningSummaryCompleted(completedCount),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryStat extends StatelessWidget {
  const _SummaryStat({
    required this.icon,
    required this.color,
    required this.label,
  });

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24.sp),
        SizedBox(height: 8.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_page_constraint.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Trophy summary shown when all quiz questions are answered.
class CompetitionQuizCompleteView extends StatelessWidget {
  const CompetitionQuizCompleteView({
    required this.answeredCount,
    required this.onDone,
    super.key,
  });

  final int answeredCount;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return CompetitionPageConstraint(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.secondary.withValues(alpha: 0.3),
                    AppColors.secondary,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.35),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                Icons.emoji_events_rounded,
                size: 56.sp,
                color: AppColors.onSecondary,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              l10n.competitionQuizComplete,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            Text(
              l10n.competitionQuizCompleteSummary(answeredCount),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 28.h),
            FilledButton(
              onPressed: onDone,
              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 52.h),
              ),
              child: Text(l10n.competitionQuizDone),
            ),
          ],
        ),
      ),
    );
  }
}

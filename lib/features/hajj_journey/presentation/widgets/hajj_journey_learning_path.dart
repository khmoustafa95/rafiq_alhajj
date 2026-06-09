import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_lesson_node.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_path_connector.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class HajjJourneyLearningPath extends StatelessWidget {
  const HajjJourneyLearningPath({
    required this.steps,
    required this.onStepTap,
    this.onLockedTap,
    super.key,
  });

  final List<HajjJourneyStepWithStatus> steps;
  final void Function(HajjJourneyStepWithStatus step) onStepTap;
  final VoidCallback? onLockedTap;

  CompetitionLessonNodeStatus _statusFor(int index) {
    final step = steps[index];
    if (step.isCompleted) {
      return CompetitionLessonNodeStatus.completed;
    }

    final firstIncomplete = steps.indexWhere((s) => !s.isCompleted);
    if (index == firstIncomplete) {
      return CompetitionLessonNodeStatus.current;
    }

    return CompetitionLessonNodeStatus.locked;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    if (steps.isEmpty) {
      return DecoratedBox(
        decoration: AppDecorations.card(color: AppColors.surfaceMuted),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Text(
            l10n.hajjJourneyEmpty,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: AppDecorations.card(
        color: AppColors.surface,
        radius: AppDecorations.radiusLg,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.hajjJourneyPathTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            SizedBox(height: 4.h),
            Text(
              l10n.hajjJourneyPathSubtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            SizedBox(height: 20.h),
            for (var i = 0; i < steps.length; i++) ...[
              if (i > 0)
                Align(
                  alignment: i.isOdd
                      ? AlignmentDirectional.centerEnd
                      : AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: i.isOdd ? 0 : 24.w,
                      end: i.isOdd ? 24.w : 0,
                    ),
                    child: CompetitionPathConnector(
                      fromRight: i.isOdd,
                      isCompleted: steps[i - 1].isCompleted,
                    ),
                  ),
                ),
              Align(
                alignment: i.isEven
                    ? AlignmentDirectional.centerStart
                    : AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CompetitionLessonNode(
                        index: i,
                        status: _statusFor(i),
                        onTap: () {
                          final status = _statusFor(i);
                          if (status == CompetitionLessonNodeStatus.locked) {
                            onLockedTap?.call();
                            return;
                          }
                          onStepTap(steps[i]);
                        },
                      ),
                      SizedBox(height: 6.h),
                      SizedBox(
                        width: 120.w,
                        child: Text(
                          isArabic
                              ? steps[i].step.titleAr
                              : steps[i].step.titleEn,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: _statusFor(i) ==
                                            CompetitionLessonNodeStatus.locked
                                        ? AppColors.textSecondary
                                        : AppColors.textPrimary,
                                    fontWeight: _statusFor(i) ==
                                            CompetitionLessonNodeStatus.current
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

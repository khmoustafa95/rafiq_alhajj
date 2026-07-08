import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/widgets/learning_path/learning_path_node_status.dart';
import 'package:rafiq_alhajj/core/widgets/learning_path/learning_path_scaffold.dart';
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return LearningPathScaffold(
      title: l10n.hajjJourneyPathTitle,
      subtitle: l10n.hajjJourneyPathSubtitle,
      itemCount: steps.length,
      emptyMessage: l10n.hajjJourneyEmpty,
      nodeHorizontalPadding: 8,
      isCompleted: (index) => steps[index].isCompleted,
      onLockedTap: onLockedTap,
      onStepTap: (index) => onStepTap(steps[index]),
      captionBuilder: (context, index, status) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 6.h),
            SizedBox(
              width: 120.w,
              child: Text(
                isArabic ? steps[index].step.titleAr : steps[index].step.titleEn,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: status == LearningPathNodeStatus.locked
                          ? Theme.of(context).colorScheme.onSurfaceVariant
                          : Theme.of(context).colorScheme.onSurface,
                      fontWeight: status == LearningPathNodeStatus.current
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}

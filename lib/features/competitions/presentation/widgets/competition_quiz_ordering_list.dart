import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class CompetitionQuizOrderingList extends StatelessWidget {
  const CompetitionQuizOrderingList({
    required this.optionsById,
    required this.orderedOptionIds,
    required this.onReorder,
    this.feedbackCorrectIds,
    this.isFeedback = false,
    super.key,
  });

  final Map<String, CompetitionQuestionOption> optionsById;
  final List<String> orderedOptionIds;
  final void Function(int oldIndex, int newIndex) onReorder;
  final List<String>? feedbackCorrectIds;
  final bool isFeedback;

  String _optionLabel(AppLocalizations l10n, String raw) {
    return switch (raw) {
      'true' => l10n.competitionAnswerTrue,
      'false' => l10n.competitionAnswerFalse,
      _ => raw,
    };
  }

  Color? _tileColor(BuildContext context, String optionId, int index) {
    if (!isFeedback || feedbackCorrectIds == null) {
      return AppColors.surface;
    }

    final correctIndex = feedbackCorrectIds!.indexOf(optionId);
    if (correctIndex == index) {
      return AppColors.success.withValues(alpha: 0.12);
    }
    if (correctIndex >= 0) {
      return Theme.of(context).colorScheme.error.withValues(alpha: 0.08);
    }
    return AppColors.surface;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      onReorderItem: isFeedback ? (_, _) {} : onReorder,
      itemCount: orderedOptionIds.length,
      itemBuilder: (context, index) {
        final optionId = orderedOptionIds[index];
        final option = optionsById[optionId];
        if (option == null) {

          
          return SizedBox(key: ValueKey(optionId));
        }

        final l10n = AppLocalizations.of(context);
        final tile = Material(
          color: _tileColor(context, optionId, index),
          borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
          child: Container(
            margin: EdgeInsets.only(bottom: 8.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDecorations.radiusMd),
              border: Border.all(color: AppColors.border),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 4.h,
              ),
              leading: CircleAvatar(
                radius: 16.r,
                backgroundColor: AppColors.primary.withValues(alpha: 0.12),
                child: Text(
                  '${index + 1}',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              title: Text(
                _optionLabel(l10n, option.label),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              trailing: isFeedback
                  ? null
                  : ReorderableDragStartListener(
                      index: index,
                      child: const Icon(
                        Icons.drag_handle_rounded,
                        color: AppColors.textSecondary,
                      ),
                    ),
            ),
          ),
        );

        return KeyedSubtree(
          key: ValueKey(optionId),
          child: tile,
        );
      },
    );
  }
}

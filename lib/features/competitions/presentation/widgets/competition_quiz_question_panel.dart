import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_colors.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_quiz_option_card.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_quiz_ordering_list.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

/// Active question prompt plus answer choices (multiple-choice or ordering).
class CompetitionQuizQuestionPanel extends StatelessWidget {
  const CompetitionQuizQuestionPanel({
    required this.question,
    required this.questionIndex,
    required this.totalQuestions,
    required this.selectedOptionId,
    required this.orderingOptionIds,
    required this.lastResult,
    required this.isSubmitting,
    required this.optionLabel,
    required this.optionState,
    required this.onSelectOption,
    required this.onReorderOrdering,
    super.key,
  });

  final CompetitionQuestion question;
  final int questionIndex;
  final int totalQuestions;
  final String? selectedOptionId;
  final List<String> orderingOptionIds;
  final CompetitionAnswerResult? lastResult;
  final bool isSubmitting;
  final String Function(String raw) optionLabel;
  final CompetitionQuizOptionState Function({
    required String optionId,
    required bool isFeedback,
  }) optionState;
  final ValueChanged<String> onSelectOption;
  final void Function(int oldIndex, int newIndex) onReorderOrdering;

  static const _optionLetters = ['A', 'B', 'C', 'D', 'E', 'F'];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isFeedback = lastResult != null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              question.questionType.isOrdering
                  ? l10n.competitionQuizOrderingBadge(
                      questionIndex + 1,
                      totalQuestions,
                    )
                  : l10n.competitionQuizQuestionBadge(
                      questionIndex + 1,
                      totalQuestions,
                    ),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.onSecondary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          SizedBox(height: 16.h),
          DecoratedBox(
            decoration: AppDecorations.card(
              radius: AppDecorations.radiusLg,
            ),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Text(
                question.prompt,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.35,
                    ),
              ),
            ),
          ),
          if (question.questionType.isOrdering) ...[
            SizedBox(height: 8.h),
            Text(
              l10n.competitionOrderingHint,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ],
          SizedBox(height: 12.h),
          Expanded(
            child: question.questionType.isOrdering
                ? CompetitionQuizOrderingList(
                    optionsById: {
                      for (final option in question.options) option.id: option,
                    },
                    orderedOptionIds: orderingOptionIds,
                    onReorder: onReorderOrdering,
                    isFeedback: isFeedback,
                    feedbackCorrectIds: lastResult?.correctOptionIds,
                  )
                : ListView.separated(
                    itemCount: question.options.length,
                    separatorBuilder: (_, _) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      final option = question.options[index];

                      return CompetitionQuizOptionCard(
                        letter: _optionLetters[index % _optionLetters.length],
                        label: optionLabel(option.label),
                        state: optionState(
                          optionId: option.id,
                          isFeedback: isFeedback,
                        ),
                        onTap: isFeedback || isSubmitting
                            ? null
                            : () => onSelectOption(option.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

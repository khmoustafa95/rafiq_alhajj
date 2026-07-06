import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq_alhajj/core/theme/app_decorations.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_lesson_node.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/widgets/competition_path_connector.dart';
import 'package:rafiq_alhajj/l10n/app_localizations.dart';

class CompetitionLearningPath extends StatelessWidget {
  const CompetitionLearningPath({
    required this.questions,
    required this.answeredQuestionIds,
    required this.onLessonTap,
    this.onLockedTap,
    super.key,
  });

  final List<CompetitionQuestion> questions;
  final Set<String> answeredQuestionIds;
  final void Function(CompetitionQuestion question) onLessonTap;
  final VoidCallback? onLockedTap;

  CompetitionLessonNodeStatus _statusFor(int index, CompetitionQuestion question) {
    if (answeredQuestionIds.contains(question.id)) {
      return CompetitionLessonNodeStatus.completed;
    }

    final firstUnansweredIndex = questions.indexWhere(
      (q) => !answeredQuestionIds.contains(q.id),
    );

    if (index == firstUnansweredIndex) {
      return CompetitionLessonNodeStatus.current;
    }

    return CompetitionLessonNodeStatus.locked;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (questions.isEmpty) {
      return DecoratedBox(
        decoration: AppDecorations.themedCard(context),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Row(
            children: [
              Icon(
                Icons.quiz_outlined,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 28.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  l10n.competitionQuizNoQuestions,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: AppDecorations.themedCard(
        context,
        radius: AppDecorations.radiusLg,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.competitionPathTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            SizedBox(height: 4.h),
            Text(
              l10n.competitionPathSubtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            SizedBox(height: 20.h),
            for (var i = 0; i < questions.length; i++) ...[
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
                      isCompleted: answeredQuestionIds.contains(questions[i - 1].id),
                    ),
                  ),
                ),
              Align(
                alignment: i.isEven
                    ? AlignmentDirectional.centerStart
                    : AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: CompetitionLessonNode(
                    index: i,
                    status: _statusFor(i, questions[i]),
                    points: questions[i].points,
                    onTap: () {
                      final status = _statusFor(i, questions[i]);
                      if (status == CompetitionLessonNodeStatus.locked) {
                        onLockedTap?.call();
                        return;
                      }
                      onLessonTap(questions[i]);
                    },
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

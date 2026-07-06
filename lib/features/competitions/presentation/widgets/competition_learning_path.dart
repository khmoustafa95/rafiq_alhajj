import 'package:flutter/material.dart';
import 'package:rafiq_alhajj/core/widgets/learning_path/learning_path_scaffold.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return LearningPathScaffold(
      title: l10n.competitionPathTitle,
      subtitle: l10n.competitionPathSubtitle,
      itemCount: questions.length,
      emptyMessage: l10n.competitionQuizNoQuestions,
      emptyIcon: Icons.quiz_outlined,
      isCompleted: (index) => answeredQuestionIds.contains(questions[index].id),
      pointsForIndex: (index) => questions[index].points,
      onLockedTap: onLockedTap,
      onStepTap: (index) => onLessonTap(questions[index]),
    );
  }
}

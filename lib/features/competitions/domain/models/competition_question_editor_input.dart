import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';

class CompetitionQuestionOptionInput {
  const CompetitionQuestionOptionInput({
    this.id,
    required this.label,
    required this.isCorrect,
    this.sortOrder = 0,
  });

  final String? id;
  final String label;
  final bool isCorrect;
  final int sortOrder;
}

class CompetitionQuestionEditorInput {
  const CompetitionQuestionEditorInput({
    this.id,
    required this.competitionId,
    required this.questionType,
    required this.prompt,
    this.explanation,
    required this.points,
    required this.options,
    this.sortOrder = 0,
  });

  final String? id;
  final String competitionId;
  final CompetitionQuestionType questionType;
  final String prompt;
  final String? explanation;
  final int points;
  final List<CompetitionQuestionOptionInput> options;
  final int sortOrder;

  static List<CompetitionQuestionOptionInput> defaultTrueFalseOptions({
    bool correctIsTrue = true,
  }) {
    return [
      CompetitionQuestionOptionInput(
        label: 'true',
        isCorrect: correctIsTrue,
      ),
      CompetitionQuestionOptionInput(
        label: 'false',
        isCorrect: !correctIsTrue,
        sortOrder: 1,
      ),
    ];
  }

  static List<CompetitionQuestionOptionInput> defaultMultipleChoiceOptions() {
    return List.generate(
      4,
      (index) => CompetitionQuestionOptionInput(
        label: '',
        isCorrect: index == 0,
        sortOrder: index,
      ),
    );
  }

  static List<CompetitionQuestionOptionInput> defaultOrderingOptions() {
    return List.generate(
      4,
      (index) => CompetitionQuestionOptionInput(
        label: '',
        isCorrect: false,
        sortOrder: index,
      ),
    );
  }
}

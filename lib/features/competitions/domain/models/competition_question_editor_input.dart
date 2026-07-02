import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';

part 'competition_question_editor_input.freezed.dart';

@freezed
abstract class CompetitionQuestionOptionInput
    with _$CompetitionQuestionOptionInput {
  const factory CompetitionQuestionOptionInput({
    String? id,
    required String label,
    required bool isCorrect,
    @Default(0) int sortOrder,
  }) = _CompetitionQuestionOptionInput;
}

@freezed
abstract class CompetitionQuestionEditorInput
    with _$CompetitionQuestionEditorInput {
  const factory CompetitionQuestionEditorInput({
    String? id,
    required String competitionId,
    required CompetitionQuestionType questionType,
    required String prompt,
    String? explanation,
    required int points,
    required List<CompetitionQuestionOptionInput> options,
    @Default(0) int sortOrder,
  }) = _CompetitionQuestionEditorInput;

  const CompetitionQuestionEditorInput._();

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

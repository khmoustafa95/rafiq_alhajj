enum CompetitionQuestionType {
  multipleChoice,
  trueFalse,
  ordering;

  static CompetitionQuestionType fromDatabase(String value) {
    return switch (value) {
      'true_false' => CompetitionQuestionType.trueFalse,
      'ordering' => CompetitionQuestionType.ordering,
      _ => CompetitionQuestionType.multipleChoice,
    };
  }

  String toDatabase() {
    return switch (this) {
      CompetitionQuestionType.trueFalse => 'true_false',
      CompetitionQuestionType.ordering => 'ordering',
      CompetitionQuestionType.multipleChoice => 'multiple_choice',
    };
  }

  bool get isOrdering => this == CompetitionQuestionType.ordering;
}

class CompetitionQuestionOption {
  const CompetitionQuestionOption({
    required this.id,
    required this.questionId,
    required this.sortOrder,
    required this.label,
    this.isCorrect = false,
  });

  final String id;
  final String questionId;
  final int sortOrder;
  final String label;
  final bool isCorrect;
}

class CompetitionQuestion {
  const CompetitionQuestion({
    required this.id,
    required this.competitionId,
    required this.sortOrder,
    required this.questionType,
    required this.prompt,
    this.explanation,
    required this.points,
    required this.options,
  });

  final String id;
  final String competitionId;
  final int sortOrder;
  final CompetitionQuestionType questionType;
  final String prompt;
  final String? explanation;
  final int points;
  final List<CompetitionQuestionOption> options;
}

class CompetitionAnswerResult {
  const CompetitionAnswerResult({
    required this.isCorrect,
    required this.pointsAwarded,
    this.explanation,
    this.correctOptionId,
    this.correctOptionIds = const [],
  });

  final bool isCorrect;
  final int pointsAwarded;
  final String? explanation;
  final String? correctOptionId;
  final List<String> correctOptionIds;
}

class CompetitionQuizProgress {
  const CompetitionQuizProgress({
    required this.questions,
    required this.answeredQuestionIds,
  });

  final List<CompetitionQuestion> questions;
  final Set<String> answeredQuestionIds;

  int get totalQuestions => questions.length;

  int get answeredCount => answeredQuestionIds.length;

  bool get isComplete =>
      totalQuestions > 0 && answeredCount >= totalQuestions;

  CompetitionQuestion? get nextQuestion {
    for (final question in questions) {
      if (!answeredQuestionIds.contains(question.id)) {
        return question;
      }
    }
    return null;
  }
}

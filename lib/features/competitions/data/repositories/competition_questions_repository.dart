import 'dart:math';

import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/competitions/data/data_sources/competition_questions_remote_data_source.dart';
import 'package:rafiq_alhajj/features/competitions/data/repositories/competitions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompetitionQuestionsRepository {
  CompetitionQuestionsRepository([SupabaseClient? client])
      : _remote = AppConfig.hasSupabase && client != null
            ? CompetitionQuestionsRemoteDataSource(client)
            : null;

  final CompetitionQuestionsRemoteDataSource? _remote;

  bool get isAvailable => _remote != null;

  Future<CompetitionQuizProgress> fetchQuizProgress({
    required String competitionId,
    String? profileId,
  }) async {
    final remote = _remote;
    if (remote == null) {
      return const CompetitionQuizProgress(
        questions: [],
        answeredQuestionIds: {},
      );
    }

    try {
      final questionRows = await remote.fetchQuestions(competitionId);

      final questions = _mapQuestions(
        questionRows,
        includeCorrectFlags: false,
      );

      final answeredIds = <String>{};
      if (profileId != null && questions.isNotEmpty) {
        final attemptRows = await remote.fetchAttempts(
          profileId: profileId,
          questionIds: questions.map((q) => q.id).toList(),
        );

        for (final map in attemptRows) {
          answeredIds.add(map['question_id'] as String);
        }
      }

      return CompetitionQuizProgress(
        questions: questions,
        answeredQuestionIds: answeredIds,
      );
    } on PostgrestException catch (e) {
      throw CompetitionsException(e.message);
    }
  }

  Future<CompetitionAnswerResult> submitAnswer({
    required String questionId,
    required String optionId,
  }) async {
    final remote = _remote;
    if (remote == null) {
      throw const CompetitionsException('Supabase is not configured');
    }

    try {
      final result = await remote.submitAnswer(
        questionId: questionId,
        optionId: optionId,
      );

      final map = Map<String, dynamic>.from(result);
      return _mapAnswerResult(map);
    } on PostgrestException catch (e) {
      throw CompetitionsException(e.message);
    }
  }

  Future<CompetitionAnswerResult> submitOrderingAnswer({
    required String questionId,
    required List<String> orderedOptionIds,
  }) async {
    final remote = _remote;
    if (remote == null) {
      throw const CompetitionsException('Supabase is not configured');
    }

    try {
      final result = await remote.submitOrderingAnswer(
        questionId: questionId,
        orderedOptionIds: orderedOptionIds,
      );

      return _mapAnswerResult(Map<String, dynamic>.from(result));
    } on PostgrestException catch (e) {
      throw CompetitionsException(e.message);
    }
  }

  CompetitionAnswerResult _mapAnswerResult(Map<String, dynamic> map) {
    final correctIdsRaw = map['correct_option_ids'];
    final correctOptionIds = <String>[];
    if (correctIdsRaw is List) {
      for (final id in correctIdsRaw) {
        correctOptionIds.add(id as String);
      }
    }

    return CompetitionAnswerResult(
      isCorrect: map['is_correct'] as bool? ?? false,
      pointsAwarded: map['points_awarded'] as int? ?? 0,
      explanation: map['explanation'] as String?,
      correctOptionId: map['correct_option_id'] as String?,
      correctOptionIds: correctOptionIds,
    );
  }

  List<CompetitionQuestion> _mapQuestions(
    List<dynamic> rows, {
    required bool includeCorrectFlags,
  }) {
    return rows.map((raw) {
      final row = Map<String, dynamic>.from(raw as Map);
      final optionsRaw = row['competition_question_options'];
      final options = <CompetitionQuestionOption>[];

      if (optionsRaw is List) {
        for (final optionRaw in optionsRaw) {
          final option = Map<String, dynamic>.from(optionRaw as Map);
          options.add(
            CompetitionQuestionOption(
              id: option['id'] as String,
              questionId: option['question_id'] as String,
              sortOrder: option['sort_order'] as int? ?? 0,
              label: option['label'] as String,
              isCorrect: includeCorrectFlags
                  ? option['is_correct'] as bool? ?? false
                  : false,
            ),
          );
        }
      }

      final questionType = CompetitionQuestionType.fromDatabase(
        row['question_type'] as String,
      );

      options.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

      if (!includeCorrectFlags && questionType.isOrdering && options.isNotEmpty) {
        final questionId = row['id'] as String;
        options.shuffle(Random(questionId.hashCode));
      }

      return CompetitionQuestion(
        id: row['id'] as String,
        competitionId: row['competition_id'] as String,
        sortOrder: row['sort_order'] as int? ?? 0,
        questionType: questionType,
        prompt: row['prompt'] as String,
        explanation: row['explanation'] as String?,
        points: row['points'] as int? ?? 10,
        options: options,
      );
    }).toList();
  }
}

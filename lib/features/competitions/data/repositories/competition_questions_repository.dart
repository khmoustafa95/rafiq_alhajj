import 'dart:math';

import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/competitions/data/repositories/competitions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompetitionQuestionsRepository {
  CompetitionQuestionsRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  Future<CompetitionQuizProgress> fetchQuizProgress({
    required String competitionId,
    String? profileId,
  }) async {
    if (!isAvailable) {
      return const CompetitionQuizProgress(
        questions: [],
        answeredQuestionIds: {},
      );
    }

    try {
      final questionRows = await _client!
          .from('competition_questions')
          .select(
            'id, competition_id, sort_order, question_type, prompt, points, '
            'competition_question_options(id, question_id, sort_order, label)',
          )
          .eq('competition_id', competitionId)
          .order('sort_order');

      final questions = _mapQuestions(
        questionRows as List<dynamic>,
        includeCorrectFlags: false,
      );

      final answeredIds = <String>{};
      if (profileId != null && questions.isNotEmpty) {
        final attemptRows = await _client
            .from('competition_question_attempts')
            .select('question_id')
            .eq('profile_id', profileId)
            .inFilter(
              'question_id',
              questions.map((q) => q.id).toList(),
            );

        for (final row in attemptRows as List<dynamic>) {
          final map = Map<String, dynamic>.from(row as Map);
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
    if (!isAvailable) {
      throw const CompetitionsException('Supabase is not configured');
    }

    try {
      final result = await _client!.rpc<Map<String, dynamic>>(
        'submit_competition_answer',
        params: {
          'p_question_id': questionId,
          'p_option_id': optionId,
        },
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
    if (!isAvailable) {
      throw const CompetitionsException('Supabase is not configured');
    }

    try {
      final result = await _client!.rpc<Map<String, dynamic>>(
        'submit_competition_ordering_answer',
        params: {
          'p_question_id': questionId,
          'p_option_ids': orderedOptionIds,
        },
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

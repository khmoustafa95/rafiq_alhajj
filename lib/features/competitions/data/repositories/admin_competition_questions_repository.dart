import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/competitions/data/data_sources/admin_competition_questions_remote_data_source.dart';
import 'package:rafiq_alhajj/features/competitions/data/repositories/competitions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question_editor_input.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminCompetitionQuestionsRepository {
  AdminCompetitionQuestionsRepository([SupabaseClient? client])
      : _remote = AppConfig.hasSupabase && client != null
            ? AdminCompetitionQuestionsRemoteDataSource(client)
            : null;

  final AdminCompetitionQuestionsRemoteDataSource? _remote;

  bool get isAvailable => _remote != null;

  Future<List<CompetitionQuestion>> fetchByCompetition(
    String competitionId,
  ) async {
    final remote = _remote;
    if (remote == null) {
      throw const CompetitionsException('Supabase is not configured');
    }

    try {
      final rows = await remote.fetchByCompetition(competitionId);

      return _mapQuestions(rows);
    } on PostgrestException catch (e) {
      throw CompetitionsException(e.message);
    }
  }

  Future<CompetitionQuestion> upsert(CompetitionQuestionEditorInput input) {
    _validateInput(input);
    return _upsertValidated(input);
  }

  Future<void> delete(String questionId) async {
    final remote = _remote;
    if (remote == null) {
      throw const CompetitionsException('Supabase is not configured');
    }

    try {
      await remote.deleteQuestion(questionId);
    } on PostgrestException catch (e) {
      throw CompetitionsException(e.message);
    }
  }

  void _validateInput(CompetitionQuestionEditorInput input) {
    if (input.prompt.trim().isEmpty) {
      throw const CompetitionsException('Question prompt is required');
    }

    if (input.questionType == CompetitionQuestionType.ordering) {
      if (input.options.length < 3) {
        throw const CompetitionsException('Ordering needs at least 3 steps');
      }
      for (final option in input.options) {
        if (option.label.trim().isEmpty) {
          throw const CompetitionsException('All steps need text');
        }
      }
      return;
    }

    final correctCount =
        input.options.where((option) => option.isCorrect).length;
    if (correctCount != 1) {
      throw const CompetitionsException('Exactly one correct answer is required');
    }

    for (final option in input.options) {
      if (option.label.trim().isEmpty &&
          input.questionType != CompetitionQuestionType.trueFalse) {
        throw const CompetitionsException('All answer options need text');
      }
    }
  }

  Future<CompetitionQuestion> _upsertValidated(
    CompetitionQuestionEditorInput input,
  ) async {
    final remote = _remote;
    if (remote == null) {
      throw const CompetitionsException('Supabase is not configured');
    }

    final questionPayload = {
      'competition_id': input.competitionId,
      'sort_order': input.sortOrder,
      'question_type': input.questionType.toDatabase(),
      'prompt': input.prompt.trim(),
      'explanation': _emptyToNull(input.explanation),
      'points': input.points,
    };

    try {
      late final String questionId;

      if (input.id != null) {
        final row = await remote.updateQuestion(input.id!, questionPayload);
        questionId = row['id'] as String;

        await remote.deleteOptions(questionId);
      } else {
        final row = await remote.insertQuestion(questionPayload);
        questionId = row['id'] as String;
      }

      final optionPayloads = input.options
          .map(
            (option) => {
              'question_id': questionId,
              'sort_order': option.sortOrder,
              'label': option.label.trim(),
              'is_correct': option.isCorrect,
            },
          )
          .toList();

      if (optionPayloads.isNotEmpty) {
        await remote.insertOptions(optionPayloads);
      }

      final items = await fetchByCompetition(input.competitionId);
      for (final item in items) {
        if (item.id == questionId) {
          return item;
        }
      }

      throw const CompetitionsException('Saved question could not be loaded');
    } on PostgrestException catch (e) {
      throw CompetitionsException(e.message);
    }
  }

  List<CompetitionQuestion> _mapQuestions(List<dynamic> rows) {
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
              isCorrect: option['is_correct'] as bool? ?? false,
            ),
          );
        }
      }

      options.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

      return CompetitionQuestion(
        id: row['id'] as String,
        competitionId: row['competition_id'] as String,
        sortOrder: row['sort_order'] as int? ?? 0,
        questionType: CompetitionQuestionType.fromDatabase(
          row['question_type'] as String,
        ),
        prompt: row['prompt'] as String,
        explanation: row['explanation'] as String?,
        points: row['points'] as int? ?? 10,
        options: options,
      );
    }).toList();
  }

  static String? _emptyToNull(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}

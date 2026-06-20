import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for `competition_questions`,
/// `competition_question_attempts` and the scoring RPCs.
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Mapping to
/// domain models is the repository's responsibility
/// (see [CompetitionQuestionsRepository]).
class CompetitionQuestionsRemoteDataSource {
  const CompetitionQuestionsRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const questionColumns =
      'id, competition_id, sort_order, question_type, prompt, points, '
      'competition_question_options(id, question_id, sort_order, label)';

  Future<List<Map<String, dynamic>>> fetchQuestions(
    String competitionId,
  ) async {
    final rows = await _client
        .from('competition_questions')
        .select(questionColumns)
        .eq('competition_id', competitionId)
        .order('sort_order');
    return _asMaps(rows);
  }

  Future<List<Map<String, dynamic>>> fetchAttempts({
    required String profileId,
    required List<String> questionIds,
  }) async {
    final rows = await _client
        .from('competition_question_attempts')
        .select('question_id')
        .eq('profile_id', profileId)
        .inFilter('question_id', questionIds);
    return _asMaps(rows);
  }

  Future<Map<String, dynamic>> submitAnswer({
    required String questionId,
    required String optionId,
  }) {
    return _client.rpc<Map<String, dynamic>>(
      'submit_competition_answer',
      params: {
        'p_question_id': questionId,
        'p_option_id': optionId,
      },
    );
  }

  Future<Map<String, dynamic>> submitOrderingAnswer({
    required String questionId,
    required List<String> orderedOptionIds,
  }) {
    return _client.rpc<Map<String, dynamic>>(
      'submit_competition_ordering_answer',
      params: {
        'p_question_id': questionId,
        'p_option_ids': orderedOptionIds,
      },
    );
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';

/// Direct Supabase access for admin management of `competition_questions` and
/// `competition_question_options`.
///
/// Data sources own all [SupabaseClient] calls and return raw rows. Mapping to
/// domain models is the repository's responsibility
/// (see [AdminCompetitionQuestionsRepository]).
class AdminCompetitionQuestionsRemoteDataSource {
  const AdminCompetitionQuestionsRemoteDataSource(this._client);

  final SupabaseClient _client;

  static const questionColumns =
      'id, competition_id, sort_order, question_type, prompt, explanation, points, '
      'competition_question_options(id, question_id, sort_order, label, is_correct)';

  Future<List<Map<String, dynamic>>> fetchByCompetition(
    String competitionId,
  ) async {
    final rows = await _client
        .from('competition_questions')
        .select(questionColumns)
        .eq('competition_id', competitionId)
        .order('sort_order');
    return _asMaps(rows);
  }

  Future<Map<String, dynamic>> updateQuestion(
    String id,
    Map<String, dynamic> payload,
  ) async {
    final row = await _client
        .from('competition_questions')
        .update(payload)
        .eq('id', id)
        .select('id')
        .single();
    return Map<String, dynamic>.from(row);
  }

  Future<Map<String, dynamic>> insertQuestion(
    Map<String, dynamic> payload,
  ) async {
    final row = await _client
        .from('competition_questions')
        .insert(payload)
        .select('id')
        .single();
    return Map<String, dynamic>.from(row);
  }

  Future<void> deleteOptions(String questionId) async {
    await _client
        .from('competition_question_options')
        .delete()
        .eq('question_id', questionId);
  }

  Future<void> insertOptions(List<Map<String, dynamic>> payloads) async {
    await _client.from('competition_question_options').insert(payloads);
  }

  Future<void> deleteQuestion(String questionId) async {
    await _client
        .from('competition_questions')
        .delete()
        .eq('id', questionId);
  }

  List<Map<String, dynamic>> _asMaps(dynamic rows) {
    return (rows as List<dynamic>)
        .map((row) => Map<String, dynamic>.from(row as Map))
        .toList(growable: false);
  }
}

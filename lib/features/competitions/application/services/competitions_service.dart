import 'package:rafiq_alhajj/features/competitions/data/repositories/competition_questions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_catalog_cache.dart';

class CompetitionsService {
  const CompetitionsService(this._questionsRepository);

  final CompetitionQuestionsRepository _questionsRepository;

  Future<CompetitionQuizProgress> fetchQuizProgress({
    required ContentCatalogCache cache,
    required String competitionId,
    required String? profileId,
  }) async {
    if (profileId == null) {
      return _questionsRepository.fetchQuizProgress(
        competitionId: competitionId,
        profileId: profileId,
      );
    }

    try {
      final progress = await _questionsRepository.fetchQuizProgress(
        competitionId: competitionId,
        profileId: profileId,
      );
      await cache.writeQuizProgress(
        competitionId: competitionId,
        profileId: profileId,
        progress: progress,
      );
      return progress;
    } catch (_) {
      return cache.readQuizProgress(
            competitionId: competitionId,
            profileId: profileId,
          ) ??
          const CompetitionQuizProgress(
            questions: [],
            answeredQuestionIds: {},
          );
    }
  }
}

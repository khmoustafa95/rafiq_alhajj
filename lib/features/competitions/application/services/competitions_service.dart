import 'package:rafiq_alhajj/features/competitions/data/repositories/competition_questions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/data/repositories/competitions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/features/content/data/local/content_catalog_cache.dart';

class CompetitionsService {
  const CompetitionsService(
    this._competitionsRepository,
    this._questionsRepository,
  );

  final CompetitionsRepository _competitionsRepository;
  final CompetitionQuestionsRepository _questionsRepository;

  Future<List<Competition>> loadActiveCompetitions({
    required ContentCatalogCache cache,
  }) async {
    try {
      final competitions = await _competitionsRepository.fetchActive();
      await cache.writeActiveCompetitions(competitions);
      return competitions;
    } catch (_) {
      return cache.readActiveCompetitions() ?? const [];
    }
  }

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

    final cached = cache.readQuizProgress(
      competitionId: competitionId,
      profileId: profileId,
    );

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
      return cached ??
          const CompetitionQuizProgress(
            questions: [],
            answeredQuestionIds: {},
          );
    }
  }
}

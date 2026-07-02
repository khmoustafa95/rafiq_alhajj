import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/competitions/data/local/pending_quiz_attempts_cache.dart';
import 'package:rafiq_alhajj/features/competitions/data/repositories/competitions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/presentation/providers/competitions_providers.dart';

/// Flushes locally queued quiz answers when connectivity is restored.
abstract final class PendingQuizSyncService {
  static Future<void> flush(Ref ref) async {
    final profileId = ref.read(authProfileIdProvider);
    if (profileId == null) {
      return;
    }

    final pending = await PendingQuizAttemptsCache.readAll(profileId);
    if (pending.isEmpty) {
      return;
    }

    final repo = ref.read(competitionQuestionsRepositoryProvider);
    final syncedCompetitionIds = <String>{};

    for (final attempt in pending) {
      try {
        if (attempt.orderedOptionIds != null) {
          await repo.submitOrderingAnswer(
            questionId: attempt.questionId,
            orderedOptionIds: attempt.orderedOptionIds!,
          );
        } else if (attempt.optionId != null) {
          await repo.submitAnswer(
            questionId: attempt.questionId,
            optionId: attempt.optionId!,
          );
        } else {
          continue;
        }
        await PendingQuizAttemptsCache.remove(profileId, attempt.questionId);
        syncedCompetitionIds.add(attempt.competitionId);
      } on CompetitionsException {
        // Keep in queue for next connectivity restore.
      }
    }

    for (final competitionId in syncedCompetitionIds) {
      ref.invalidate(competitionQuizProgressProvider(competitionId));
      ref.invalidate(competitionDetailProvider(competitionId));
    }
  }
}

import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/core/models/staff_table_query.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_invalidation_registry.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_attach.dart';
import 'package:rafiq_alhajj/core/supabase/realtime_sync_providers.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/competitions/application/services/competitions_service.dart';
import 'package:rafiq_alhajj/features/competitions/data/repositories/admin_competition_questions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/data/repositories/admin_competitions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/data/repositories/competition_questions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/data/repositories/competitions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_editor_input.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_question_editor_input.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_catalog_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'competitions_providers.g.dart';

@Riverpod(keepAlive: true)
CompetitionsService competitionsService(Ref ref) {
  return CompetitionsService(
    ref.watch(competitionQuestionsRepositoryProvider),
  );
}

@Riverpod(keepAlive: true)
CompetitionsRepository competitionsRepository(Ref ref) {
  return CompetitionsRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
AdminCompetitionsRepository adminCompetitionsRepository(Ref ref) {
  return AdminCompetitionsRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
CompetitionQuestionsRepository competitionQuestionsRepository(Ref ref) {
  return CompetitionQuestionsRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
AdminCompetitionQuestionsRepository adminCompetitionQuestionsRepository(
  Ref ref,
) {
  return AdminCompetitionQuestionsRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@riverpod
Future<List<Competition>> activeCompetitions(Ref ref) {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.competitions,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncCompetitionsProvider),
    handlerId: 'active_competitions',
    onInvalidate: (ref) => ref.invalidate(activeCompetitionsProvider),
  );

  return ref.read(competitionsRepositoryProvider).fetchActive();
}

@riverpod
class CompetitionDetail extends _$CompetitionDetail {
  @override
  Future<CompetitionWithEntries?> build(String competitionId) {
    attachRealtimeSync(
      ref,
      syncKey: RealtimeSyncKeys.competitions,
      ensureSyncActive: (ref) => ref.watch(realtimeSyncCompetitionsProvider),
      handlerId: 'competition_detail',
      onInvalidate: (ref) => ref.invalidate(competitionDetailProvider),
    );

    final profileId = ref.watch(authProfileIdProvider);
    return ref.read(competitionsRepositoryProvider).fetchWithEntries(
          competitionId,
          currentProfileId: profileId,
        );
  }

  Future<bool> join() async {
    final profileId = ref.read(authProfileIdProvider);
    if (profileId == null) {
      return false;
    }

    try {
      await ref.read(competitionsRepositoryProvider).join(
            competitionId: competitionId,
            profileId: profileId,
          );
      ref.invalidateSelf();
      await future;
      return true;
    } on CompetitionsException {
      return false;
    }
  }

}

@riverpod
Future<CompetitionQuizProgress> competitionQuizProgress(
  Ref ref,
  String competitionId,
) {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.competitions,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncCompetitionsProvider),
    handlerId: 'competition_quiz_progress',
    onInvalidate: (ref) =>
        ref.invalidate(competitionQuizProgressProvider(competitionId)),
  );

  final profileId = ref.watch(authProfileIdProvider);

  return ref.read(contentCatalogCacheProvider.future).then(
        (cache) => ref.read(competitionsServiceProvider).fetchQuizProgress(
              cache: cache,
              competitionId: competitionId,
              profileId: profileId,
            ),
      );
}

@riverpod
class CompetitionQuizSubmit extends _$CompetitionQuizSubmit {
  @override
  FutureOr<CompetitionAnswerResult?> build() => null;

  Future<CompetitionAnswerResult?> submit({
    required String competitionId,
    required String questionId,
    required String optionId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref
          .read(competitionQuestionsRepositoryProvider)
          .submitAnswer(questionId: questionId, optionId: optionId);
      ref.invalidate(competitionQuizProgressProvider(competitionId));
      ref.invalidate(competitionDetailProvider(competitionId));
      return result;
    });
    return state.value;
  }

  Future<CompetitionAnswerResult?> submitOrdering({
    required String competitionId,
    required String questionId,
    required List<String> orderedOptionIds,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref
          .read(competitionQuestionsRepositoryProvider)
          .submitOrderingAnswer(
            questionId: questionId,
            orderedOptionIds: orderedOptionIds,
          );
      ref.invalidate(competitionQuizProgressProvider(competitionId));
      ref.invalidate(competitionDetailProvider(competitionId));
      return result;
    });
    return state.value;
  }
}

@riverpod
Future<List<CompetitionQuestion>> adminCompetitionQuestions(
  Ref ref,
  String competitionId,
) {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.competitions,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncCompetitionsProvider),
    handlerId: 'admin_competition_questions',
    onInvalidate: (ref) =>
        ref.invalidate(adminCompetitionQuestionsProvider(competitionId)),
  );

  return ref
      .read(adminCompetitionQuestionsRepositoryProvider)
      .fetchByCompetition(competitionId);
}

@riverpod
class AdminCompetitionQuestionSave extends _$AdminCompetitionQuestionSave {
  @override
  FutureOr<void> build() {}

  Future<bool> save(CompetitionQuestionEditorInput input) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(adminCompetitionQuestionsRepositoryProvider)
          .upsert(input);
      ref.invalidate(adminCompetitionQuestionsProvider(input.competitionId));
    });
    return !state.hasError;
  }
}

@riverpod
class AdminCompetitionQuestionDelete extends _$AdminCompetitionQuestionDelete {
  @override
  FutureOr<void> build() {}

  Future<bool> delete({
    required String competitionId,
    required String questionId,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(adminCompetitionQuestionsRepositoryProvider)
          .delete(questionId);
      ref.invalidate(adminCompetitionQuestionsProvider(competitionId));
    });
    return !state.hasError;
  }
}

@riverpod
Future<PaginatedResult<Competition>> adminCompetitionListPage(
  Ref ref,
  StaffTableQuery query,
) {
  attachRealtimeSync(
    ref,
    syncKey: RealtimeSyncKeys.competitions,
    ensureSyncActive: (ref) => ref.watch(realtimeSyncCompetitionsProvider),
    handlerId: 'admin_competition_list_page',
    onInvalidate: (ref) => ref.invalidate(adminCompetitionListPageProvider),
  );

  return ref.read(adminCompetitionsRepositoryProvider).fetchPage(query);
}

@riverpod
class AdminCompetitionList extends _$AdminCompetitionList {
  @override
  Future<List<Competition>> build() async {
    attachRealtimeSync(
      ref,
      syncKey: RealtimeSyncKeys.competitions,
      ensureSyncActive: (ref) => ref.watch(realtimeSyncCompetitionsProvider),
      handlerId: 'admin_competition_list',
      onInvalidate: (ref) => ref.invalidate(adminCompetitionListProvider),
    );

    return ref.read(adminCompetitionsRepositoryProvider).fetchAll();
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  Future<bool> deleteItem(String id) async {
    try {
      await ref.read(adminCompetitionsRepositoryProvider).delete(id);
      ref.invalidateSelf();
      ref.invalidate(adminCompetitionListPageProvider);
      await future;
      return true;
    } on CompetitionsException {
      return false;
    }
  }
}

@riverpod
class AdminCompetitionSave extends _$AdminCompetitionSave {
  @override
  FutureOr<void> build() {}

  Future<bool> save(CompetitionEditorInput input) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(adminCompetitionsRepositoryProvider).upsert(input);
      ref.invalidate(adminCompetitionListProvider);
      ref.invalidate(adminCompetitionListPageProvider);
    });
    return !state.hasError;
  }
}

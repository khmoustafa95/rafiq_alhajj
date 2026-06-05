import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/auth/presentation/providers/auth_session_provider.dart';
import 'package:rafiq_alhajj/features/competitions/data/repositories/admin_competitions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/data/repositories/competitions_repository.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition.dart';
import 'package:rafiq_alhajj/features/competitions/domain/models/competition_editor_input.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'competitions_providers.g.dart';

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

@riverpod
Future<List<Competition>> activeCompetitions(Ref ref) {
  return ref.read(competitionsRepositoryProvider).fetchActive();
}

@riverpod
class CompetitionDetail extends _$CompetitionDetail {
  @override
  Future<CompetitionWithEntries?> build(String competitionId) {
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

  Future<bool> recordProgress() async {
    final data = state.value;
    final entry = data?.myEntry;
    if (entry == null) {
      return false;
    }

    try {
      await ref.read(competitionsRepositoryProvider).addScore(
            entryId: entry.id,
            delta: 10,
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
class AdminCompetitionList extends _$AdminCompetitionList {
  @override
  Future<List<Competition>> build() {
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
    });
    return !state.hasError;
  }
}

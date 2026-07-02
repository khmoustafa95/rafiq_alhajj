import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/content/presentation/providers/content_catalog_providers.dart';
import 'package:rafiq_alhajj/features/hajj_journey/application/services/hajj_journey_service.dart';
import 'package:rafiq_alhajj/features/hajj_journey/data/repositories/admin_hajj_journey_repository.dart';
import 'package:rafiq_alhajj/features/hajj_journey/data/repositories/hajj_journey_repository.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';
import 'package:rafiq_alhajj/features/pilgrim/presentation/providers/pilgrim_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'hajj_journey_providers.g.dart';

@Riverpod(keepAlive: true)
HajjJourneyService hajjJourneyService(Ref ref) {
  return HajjJourneyService(ref.watch(hajjJourneyRepositoryProvider));
}

@Riverpod(keepAlive: true)
HajjJourneyRepository hajjJourneyRepository(Ref ref) {
  return HajjJourneyRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@Riverpod(keepAlive: true)
AdminHajjJourneyRepository adminHajjJourneyRepository(Ref ref) {
  return AdminHajjJourneyRepository(
    AppConfig.hasSupabase ? Supabase.instance.client : null,
  );
}

@riverpod
Future<List<HajjJourneyStep>> hajjJourneySteps(Ref ref) async {
  final cache = await ref.read(contentCatalogCacheProvider.future);
  return ref.read(hajjJourneyServiceProvider).loadActiveSteps(cache: cache);
}

@riverpod
Future<HajjJourneyStep?> hajjJourneyStepByKey(Ref ref, String ritualKey) async {
  return ref.read(hajjJourneyRepositoryProvider).fetchStepByRitualKey(ritualKey);
}

@riverpod
Future<HajjJourneyState> hajjJourneyState(Ref ref) async {
  final steps = await ref.watch(hajjJourneyStepsProvider.future);
  final dashboard = await ref.watch(pilgrimDashboardStateProvider.future);

  final progressByKey = {
    for (final ritual in dashboard.rituals) ritual.definition.key: ritual,
  };

  final withStatus = steps.map((step) {
    final ritual = progressByKey[step.ritualKey];
    return HajjJourneyStepWithStatus(
      step: step,
      isCompleted: ritual?.isCompleted ?? false,
      completedAt: ritual?.completedAt,
      pendingSync: ritual?.pendingSync ?? false,
    );
  }).toList();

  return HajjJourneyState(
    steps: withStatus,
    hasPendingSync: dashboard.hasPendingSync,
  );
}

@riverpod
Future<List<HajjJourneyStep>> adminHajjJourneySteps(Ref ref) async {
  return ref.read(adminHajjJourneyRepositoryProvider).fetchAll();
}

@riverpod
Future<HajjJourneyStep?> adminHajjJourneyStep(Ref ref, String ritualKey) async {
  return ref.read(adminHajjJourneyRepositoryProvider).fetchByRitualKey(ritualKey);
}

@riverpod
class AdminHajjJourneySave extends _$AdminHajjJourneySave {
  @override
  FutureOr<void> build() {}

  Future<void> save({
    required String ritualKey,
    required HajjJourneyEditorInput input,
    required List<HajjJourneyMediaInput> media,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(adminHajjJourneyRepositoryProvider);
      await repo.upsertStep(ritualKey: ritualKey, input: input);
      final saved = await repo.fetchByRitualKey(ritualKey);
      if (saved != null) {
        await repo.replaceMedia(stepId: saved.id, media: media);
      }
      ref.invalidate(adminHajjJourneyStepsProvider);
      ref.invalidate(adminHajjJourneyStepProvider(ritualKey));
      ref.invalidate(hajjJourneyStepsProvider);
      ref.invalidate(hajjJourneyStepByKeyProvider(ritualKey));
      ref.invalidate(hajjJourneyStateProvider);
    });
  }
}

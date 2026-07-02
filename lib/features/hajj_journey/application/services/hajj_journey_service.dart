import 'package:rafiq_alhajj/features/content/data/local/content_catalog_cache.dart';
import 'package:rafiq_alhajj/features/hajj_journey/data/hajj_journey_fallback_data.dart';
import 'package:rafiq_alhajj/features/hajj_journey/data/repositories/hajj_journey_repository.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';

class HajjJourneyService {
  const HajjJourneyService(this._repository);

  final HajjJourneyRepository _repository;

  Future<List<HajjJourneyStep>> loadActiveSteps({
    required ContentCatalogCache cache,
  }) async {
    try {
      final steps = await _repository.fetchActiveSteps();
      await cache.writeJourneySteps(steps);
      return steps;
    } catch (_) {
      final cached = cache.readJourneySteps();
      if (cached != null && cached.isNotEmpty) {
        return cached;
      }
      return HajjJourneyFallbackData.steps();
    }
  }
}

import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/hajj_journey/data/hajj_journey_fallback_data.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_media.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HajjJourneyException implements Exception {
  const HajjJourneyException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Hajj journey request failed';
}

class HajjJourneyRepository {
  HajjJourneyRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  Future<List<HajjJourneyStep>> fetchActiveSteps() async {
    if (!isAvailable) {
      return HajjJourneyFallbackData.steps();
    }

    try {
      final rows = await _client!
          .from('hajj_journey_steps')
          .select(
            'id, ritual_key, sort_order, title_ar, title_en, '
            'description_ar, description_en, is_active, '
            'hajj_journey_media(id, media_type, title, url, sort_order)',
          )
          .eq('is_active', true)
          .order('sort_order');

      final steps = (rows as List<dynamic>)
          .map((row) => _mapStep(Map<String, dynamic>.from(row as Map)))
          .toList();

      if (steps.isEmpty) {
        return HajjJourneyFallbackData.steps();
      }

      return steps;
    } on PostgrestException catch (e) {
      throw HajjJourneyException(e.message);
    }
  }

  Future<HajjJourneyStep?> fetchStepByRitualKey(String ritualKey) async {
    final steps = await fetchActiveSteps();
    for (final step in steps) {
      if (step.ritualKey == ritualKey) {
        return step;
      }
    }
    return null;
  }

  HajjJourneyStep _mapStep(Map<String, dynamic> row) {
    final mediaRows = row['hajj_journey_media'] as List<dynamic>? ?? [];
    final media = mediaRows
        .map((m) => _mapMedia(Map<String, dynamic>.from(m as Map)))
        .toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));

    return HajjJourneyStep(
      id: row['id'] as String,
      ritualKey: row['ritual_key'] as String,
      sortOrder: row['sort_order'] as int? ?? 0,
      titleAr: row['title_ar'] as String,
      titleEn: row['title_en'] as String,
      descriptionAr: row['description_ar'] as String,
      descriptionEn: row['description_en'] as String,
      isActive: row['is_active'] as bool? ?? true,
      media: media,
    );
  }

  HajjJourneyMedia _mapMedia(Map<String, dynamic> row) {
    return HajjJourneyMedia(
      id: row['id'] as String,
      mediaType: HajjJourneyMedia.mediaTypeFromString(
        row['media_type'] as String,
      ),
      title: row['title'] as String?,
      url: row['url'] as String,
      sortOrder: row['sort_order'] as int? ?? 0,
    );
  }
}

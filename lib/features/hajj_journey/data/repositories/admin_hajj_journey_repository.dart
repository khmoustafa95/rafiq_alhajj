import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/hajj_journey/data/repositories/hajj_journey_repository.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_media.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminHajjJourneyRepository {
  AdminHajjJourneyRepository([SupabaseClient? client]) : _client = client;

  final SupabaseClient? _client;

  bool get isAvailable => AppConfig.hasSupabase && _client != null;

  Future<List<HajjJourneyStep>> fetchAll() async {
    if (!isAvailable) {
      return [];
    }

    try {
      final rows = await _client!
          .from('hajj_journey_steps')
          .select(
            'id, ritual_key, sort_order, title_ar, title_en, '
            'description_ar, description_en, is_active, '
            'hajj_journey_media(id, media_type, title, url, sort_order)',
          )
          .order('sort_order');

      return (rows as List<dynamic>)
          .map((row) => _mapStep(Map<String, dynamic>.from(row as Map)))
          .toList();
    } on PostgrestException catch (e) {
      throw HajjJourneyException(e.message);
    }
  }

  Future<HajjJourneyStep?> fetchByRitualKey(String ritualKey) async {
    if (!isAvailable) {
      return null;
    }

    try {
      final row = await _client!
          .from('hajj_journey_steps')
          .select(
            'id, ritual_key, sort_order, title_ar, title_en, '
            'description_ar, description_en, is_active, '
            'hajj_journey_media(id, media_type, title, url, sort_order)',
          )
          .eq('ritual_key', ritualKey)
          .maybeSingle();

      if (row == null) {
        return null;
      }

      return _mapStep(Map<String, dynamic>.from(row));
    } on PostgrestException catch (e) {
      throw HajjJourneyException(e.message);
    }
  }

  Future<void> upsertStep({
    required String ritualKey,
    required HajjJourneyEditorInput input,
  }) async {
    if (!isAvailable) {
      throw const HajjJourneyException('Supabase unavailable');
    }

    try {
      await _client!.from('hajj_journey_steps').upsert(
        {
          'ritual_key': ritualKey,
          'sort_order': input.sortOrder,
          'title_ar': input.titleAr,
          'title_en': input.titleEn,
          'description_ar': input.descriptionAr,
          'description_en': input.descriptionEn,
          'is_active': input.isActive,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        },
        onConflict: 'ritual_key',
      );
    } on PostgrestException catch (e) {
      throw HajjJourneyException(e.message);
    }
  }

  Future<void> replaceMedia({
    required String stepId,
    required List<HajjJourneyMediaInput> media,
  }) async {
    if (!isAvailable) {
      throw const HajjJourneyException('Supabase unavailable');
    }

    try {
      await _client!.from('hajj_journey_media').delete().eq('step_id', stepId);

      if (media.isEmpty) {
        return;
      }

      await _client.from('hajj_journey_media').insert(
            media
                .map(
                  (item) => {
                    'step_id': stepId,
                    'media_type': item.mediaTypeKey,
                    'title': item.title,
                    'url': item.url,
                    'sort_order': item.sortOrder,
                  },
                )
                .toList(),
          );
    } on PostgrestException catch (e) {
      throw HajjJourneyException(e.message);
    }
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

extension on HajjJourneyMediaInput {
  String get mediaTypeKey => switch (mediaType) {
        HajjMediaType.video => 'video',
        HajjMediaType.audio => 'audio',
        HajjMediaType.image => 'image',
      };
}

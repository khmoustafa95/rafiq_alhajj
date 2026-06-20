import 'package:rafiq_alhajj/core/config/app_config.dart';
import 'package:rafiq_alhajj/features/hajj_journey/data/data_sources/admin_hajj_journey_remote_data_source.dart';
import 'package:rafiq_alhajj/features/hajj_journey/data/repositories/hajj_journey_repository.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_media.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_step.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminHajjJourneyRepository {
  AdminHajjJourneyRepository([SupabaseClient? client])
      : _remote = AppConfig.hasSupabase && client != null
            ? AdminHajjJourneyRemoteDataSource(client)
            : null;

  final AdminHajjJourneyRemoteDataSource? _remote;

  bool get isAvailable => _remote != null;

  Future<List<HajjJourneyStep>> fetchAll() async {
    final remote = _remote;
    if (remote == null) {
      return [];
    }

    try {
      final rows = await remote.fetchAll();

      return rows.map(_mapStep).toList();
    } on PostgrestException catch (e) {
      throw HajjJourneyException(e.message);
    }
  }

  Future<HajjJourneyStep?> fetchByRitualKey(String ritualKey) async {
    final remote = _remote;
    if (remote == null) {
      return null;
    }

    try {
      final row = await remote.fetchByRitualKey(ritualKey);

      if (row == null) {
        return null;
      }

      return _mapStep(row);
    } on PostgrestException catch (e) {
      throw HajjJourneyException(e.message);
    }
  }

  Future<void> upsertStep({
    required String ritualKey,
    required HajjJourneyEditorInput input,
  }) async {
    final remote = _remote;
    if (remote == null) {
      throw const HajjJourneyException('Supabase unavailable');
    }

    try {
      await remote.upsertStep({
        'ritual_key': ritualKey,
        'sort_order': input.sortOrder,
        'title_ar': input.titleAr,
        'title_en': input.titleEn,
        'description_ar': input.descriptionAr,
        'description_en': input.descriptionEn,
        'is_active': input.isActive,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      });
    } on PostgrestException catch (e) {
      throw HajjJourneyException(e.message);
    }
  }

  Future<void> replaceMedia({
    required String stepId,
    required List<HajjJourneyMediaInput> media,
  }) async {
    final remote = _remote;
    if (remote == null) {
      throw const HajjJourneyException('Supabase unavailable');
    }

    try {
      await remote.deleteMedia(stepId);

      if (media.isEmpty) {
        return;
      }

      await remote.insertMedia(
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

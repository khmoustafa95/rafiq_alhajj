import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_media.dart';

class HajjJourneyStep {
  const HajjJourneyStep({
    required this.id,
    required this.ritualKey,
    required this.sortOrder,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    this.isActive = true,
    this.media = const [],
  });

  final String id;
  final String ritualKey;
  final int sortOrder;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final bool isActive;
  final List<HajjJourneyMedia> media;

  String titleForLocale(String languageCode) =>
      languageCode == 'ar' ? titleAr : titleEn;

  String descriptionForLocale(String languageCode) =>
      languageCode == 'ar' ? descriptionAr : descriptionEn;

  HajjJourneyStep copyWith({
    String? id,
    String? ritualKey,
    int? sortOrder,
    String? titleAr,
    String? titleEn,
    String? descriptionAr,
    String? descriptionEn,
    bool? isActive,
    List<HajjJourneyMedia>? media,
  }) {
    return HajjJourneyStep(
      id: id ?? this.id,
      ritualKey: ritualKey ?? this.ritualKey,
      sortOrder: sortOrder ?? this.sortOrder,
      titleAr: titleAr ?? this.titleAr,
      titleEn: titleEn ?? this.titleEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      isActive: isActive ?? this.isActive,
      media: media ?? this.media,
    );
  }
}

class HajjJourneyStepWithStatus {
  const HajjJourneyStepWithStatus({
    required this.step,
    required this.isCompleted,
    this.completedAt,
    this.pendingSync = false,
  });

  final HajjJourneyStep step;
  final bool isCompleted;
  final DateTime? completedAt;
  final bool pendingSync;
}

class HajjJourneyState {
  const HajjJourneyState({
    required this.steps,
    this.hasPendingSync = false,
  });

  final List<HajjJourneyStepWithStatus> steps;
  final bool hasPendingSync;

  int get completedCount => steps.where((s) => s.isCompleted).length;

  int get totalCount => steps.length;

  HajjJourneyStepWithStatus? get currentStep {
    for (final step in steps) {
      if (!step.isCompleted) {
        return step;
      }
    }
    return null;
  }

  bool isUnlocked(int index) {
    if (index <= 0) {
      return true;
    }
    return steps[index - 1].isCompleted;
  }
}

class HajjJourneyEditorInput {
  const HajjJourneyEditorInput({
    required this.ritualKey,
    required this.sortOrder,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    this.isActive = true,
  });

  final String ritualKey;
  final int sortOrder;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final bool isActive;
}

class HajjJourneyMediaInput {
  const HajjJourneyMediaInput({
    required this.mediaType,
    required this.url,
    this.title,
    this.sortOrder = 0,
  });

  final HajjMediaType mediaType;
  final String? title;
  final String url;
  final int sortOrder;
}

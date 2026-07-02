import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/hajj_journey/domain/models/hajj_journey_media.dart';

part 'hajj_journey_step.freezed.dart';

@freezed
abstract class HajjJourneyStep with _$HajjJourneyStep {
  const factory HajjJourneyStep({
    required String id,
    required String ritualKey,
    required int sortOrder,
    required String titleAr,
    required String titleEn,
    required String descriptionAr,
    required String descriptionEn,
    @Default(true) bool isActive,
    @Default([]) List<HajjJourneyMedia> media,
  }) = _HajjJourneyStep;

  const HajjJourneyStep._();

  String titleForLocale(String languageCode) =>
      languageCode == 'ar' ? titleAr : titleEn;

  String descriptionForLocale(String languageCode) =>
      languageCode == 'ar' ? descriptionAr : descriptionEn;
}

@freezed
abstract class HajjJourneyStepWithStatus with _$HajjJourneyStepWithStatus {
  const factory HajjJourneyStepWithStatus({
    required HajjJourneyStep step,
    required bool isCompleted,
    DateTime? completedAt,
    @Default(false) bool pendingSync,
  }) = _HajjJourneyStepWithStatus;
}

@freezed
abstract class HajjJourneyState with _$HajjJourneyState {
  const factory HajjJourneyState({
    required List<HajjJourneyStepWithStatus> steps,
    @Default(false) bool hasPendingSync,
  }) = _HajjJourneyState;

  const HajjJourneyState._();

  int get completedCount => steps.where((step) => step.isCompleted).length;

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

@freezed
abstract class HajjJourneyEditorInput with _$HajjJourneyEditorInput {
  const factory HajjJourneyEditorInput({
    required String ritualKey,
    required int sortOrder,
    required String titleAr,
    required String titleEn,
    required String descriptionAr,
    required String descriptionEn,
    @Default(true) bool isActive,
  }) = _HajjJourneyEditorInput;
}

@freezed
abstract class HajjJourneyMediaInput with _$HajjJourneyMediaInput {
  const factory HajjJourneyMediaInput({
    required HajjMediaType mediaType,
    required String url,
    String? title,
    @Default(0) int sortOrder,
  }) = _HajjJourneyMediaInput;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ritual_progress.freezed.dart';
part 'ritual_progress.g.dart';

@freezed
abstract class RitualProgress with _$RitualProgress {
  const factory RitualProgress({
    required String ritualKey,
    required bool isCompleted,
    DateTime? completedAt,
    @Default(false) bool pendingSync,
  }) = _RitualProgress;

  factory RitualProgress.fromJson(Map<String, dynamic> json) =>
      _$RitualProgressFromJson(json);
}

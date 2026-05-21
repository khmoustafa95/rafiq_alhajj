import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/ritual_step_definition.dart';

part 'ritual_step_status.freezed.dart';

@freezed
abstract class RitualStepStatus with _$RitualStepStatus {
  const factory RitualStepStatus({
    required RitualStepDefinition definition,
    required bool isCompleted,
    DateTime? completedAt,
    required bool pendingSync,
  }) = _RitualStepStatus;
}

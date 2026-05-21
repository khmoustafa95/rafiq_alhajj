import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim_details.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/ritual_step_status.dart';

part 'pilgrim_dashboard.freezed.dart';

@freezed
abstract class PilgrimDashboard with _$PilgrimDashboard {
  const factory PilgrimDashboard({
    required PilgrimDetails? logistics,
    required List<RitualStepStatus> rituals,
    required bool hasPendingSync,
  }) = _PilgrimDashboard;

  const PilgrimDashboard._();

  int get completedCount => rituals.where((r) => r.isCompleted).length;

  int get totalCount => rituals.length;
}

import 'package:json_annotation/json_annotation.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/ritual_progress.dart';

part 'ritual_log_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RitualLogDto {
  const RitualLogDto({
    required this.ritualKey,
    required this.isCompleted,
    required this.completedAt,
  });

  factory RitualLogDto.fromJson(Map<String, dynamic> json) =>
      _$RitualLogDtoFromJson(json);

  final String ritualKey;
  final bool isCompleted;
  final DateTime? completedAt;

  RitualProgress toDomain() {
    return RitualProgress(
      ritualKey: ritualKey,
      isCompleted: isCompleted,
      completedAt: completedAt,
    );
  }
}

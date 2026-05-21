// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ritual_log_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RitualLogDto _$RitualLogDtoFromJson(Map<String, dynamic> json) => RitualLogDto(
  ritualKey: json['ritual_key'] as String,
  isCompleted: json['is_completed'] as bool,
  completedAt: json['completed_at'] == null
      ? null
      : DateTime.parse(json['completed_at'] as String),
);

Map<String, dynamic> _$RitualLogDtoToJson(RitualLogDto instance) =>
    <String, dynamic>{
      'ritual_key': instance.ritualKey,
      'is_completed': instance.isCompleted,
      'completed_at': instance.completedAt?.toIso8601String(),
    };

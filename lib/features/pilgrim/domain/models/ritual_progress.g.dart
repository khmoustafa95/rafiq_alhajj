// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ritual_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RitualProgress _$RitualProgressFromJson(Map<String, dynamic> json) =>
    _RitualProgress(
      ritualKey: json['ritualKey'] as String,
      isCompleted: json['isCompleted'] as bool,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      pendingSync: json['pendingSync'] as bool? ?? false,
    );

Map<String, dynamic> _$RitualProgressToJson(_RitualProgress instance) =>
    <String, dynamic>{
      'ritualKey': instance.ritualKey,
      'isCompleted': instance.isCompleted,
      'completedAt': instance.completedAt?.toIso8601String(),
      'pendingSync': instance.pendingSync,
    };

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rafiq_alhajj/features/field_operator/domain/models/field_pilgrim_status.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim.dart';

part 'field_operator_stats.freezed.dart';

@freezed
abstract class FieldOperatorStats with _$FieldOperatorStats {
  const factory FieldOperatorStats({
    required int total,
    required int pending,
    required int medicalDone,
    required int arrivedHotel,
    required int inTransit,
    required int completed,
    required int needsWheelchair,
    required int vaccinated,
  }) = _FieldOperatorStats;

  const FieldOperatorStats._();

  factory FieldOperatorStats.fromPilgrims(List<Pilgrim> pilgrims) {
    var pending = 0;
    var medicalDone = 0;
    var arrivedHotel = 0;
    var inTransit = 0;
    var completed = 0;
    var needsWheelchair = 0;
    var vaccinated = 0;

    for (final pilgrim in pilgrims) {
      switch (pilgrim.fieldStatus) {
        case FieldPilgrimStatus.medicalDone:
          medicalDone++;
        case FieldPilgrimStatus.arrivedHotel:
          arrivedHotel++;
        case FieldPilgrimStatus.inTransit:
          inTransit++;
        case FieldPilgrimStatus.completed:
          completed++;
        default:
          pending++;
      }

      if (pilgrim.needsWheelchair == true) {
        needsWheelchair++;
      }
      if (pilgrim.isVaccinated == true) {
        vaccinated++;
      }
    }

    return FieldOperatorStats(
      total: pilgrims.length,
      pending: pending,
      medicalDone: medicalDone,
      arrivedHotel: arrivedHotel,
      inTransit: inTransit,
      completed: completed,
      needsWheelchair: needsWheelchair,
      vaccinated: vaccinated,
    );
  }
}

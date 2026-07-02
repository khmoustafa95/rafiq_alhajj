import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip.freezed.dart';

/// A seasonal journey (Hajj or Umrah) for a specific year.
///
/// Travel offices (`groups`) join a trip via `trip_groups`, and pilgrims are
/// enrolled in a trip via `trip_enrollments`. A pilgrim can take part in more
/// than one trip across seasons.
@freezed
abstract class Trip with _$Trip {
  const factory Trip({
    required String id,
    required String type,
    required int seasonYear,
    required String name,
    @Default('planning') String status,
    DateTime? startDate,
    DateTime? endDate,
    @Default(0) int officeCount,
    @Default(0) int pilgrimCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Trip;

  const Trip._();

  /// `hajj` or `umrah`.
  bool get isHajj => type == 'hajj';

  bool get isUmrah => type == 'umrah';
}

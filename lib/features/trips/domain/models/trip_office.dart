import 'package:freezed_annotation/freezed_annotation.dart';

part 'trip_office.freezed.dart';

/// A travel office (`groups` row) participating in a trip via `trip_groups`.
@freezed
abstract class TripOffice with _$TripOffice {
  const factory TripOffice({
    required String tripGroupId,
    required String tripId,
    required String groupId,
    required String groupName,
    @Default('active') String status,
    String? presidentName,
    DateTime? joinedAt,
    DateTime? withdrawnAt,
  }) = _TripOffice;

  const TripOffice._();

  bool get isActive => status == 'active';
}

/// A lightweight office option used when adding a group to a trip.
@freezed
abstract class TripGroupOption with _$TripGroupOption {
  const factory TripGroupOption({
    required String id,
    required String name,
  }) = _TripGroupOption;
}

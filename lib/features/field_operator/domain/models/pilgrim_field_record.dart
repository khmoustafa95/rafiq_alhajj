import 'package:freezed_annotation/freezed_annotation.dart';

part 'pilgrim_field_record.freezed.dart';

@freezed
abstract class PilgrimFieldRecord with _$PilgrimFieldRecord {
  const factory PilgrimFieldRecord({
    required String profileId,
    required String fullName,
    required String? passportNumber,
    required String? travelPermitNumber,
    required String? fieldStatus,
    required String? medicalTestStatus,
    required String? hotelName,
    required String? transportationDetails,
  }) = _PilgrimFieldRecord;
}

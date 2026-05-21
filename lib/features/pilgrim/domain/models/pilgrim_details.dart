import 'package:freezed_annotation/freezed_annotation.dart';

part 'pilgrim_details.freezed.dart';
part 'pilgrim_details.g.dart';

@freezed
abstract class PilgrimDetails with _$PilgrimDetails {
  const factory PilgrimDetails({
    required String? passportNumber,
    required String? travelPermitNumber,
    required String? medicalTestStatus,
    required DateTime? travelDate,
    required String? hotelName,
    required String? hotelLocationUrl,
    required String? transportationDetails,
  }) = _PilgrimDetails;

  factory PilgrimDetails.fromJson(Map<String, dynamic> json) =>
      _$PilgrimDetailsFromJson(json);
}

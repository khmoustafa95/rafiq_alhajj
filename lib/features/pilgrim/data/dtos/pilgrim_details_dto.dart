import 'package:json_annotation/json_annotation.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim_details.dart';

part 'pilgrim_details_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PilgrimDetailsDto {
  const PilgrimDetailsDto({
    required this.passportNumber,
    required this.travelPermitNumber,
    required this.medicalTestStatus,
    required this.travelDate,
    required this.hotelName,
    required this.hotelLocationUrl,
    required this.transportationDetails,
  });

  factory PilgrimDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$PilgrimDetailsDtoFromJson(json);

  final String? passportNumber;
  final String? travelPermitNumber;
  final String? medicalTestStatus;
  final DateTime? travelDate;
  final String? hotelName;
  final String? hotelLocationUrl;
  final String? transportationDetails;

  PilgrimDetails toDomain() {
    return PilgrimDetails(
      passportNumber: passportNumber,
      travelPermitNumber: travelPermitNumber,
      medicalTestStatus: medicalTestStatus,
      travelDate: travelDate,
      hotelName: hotelName,
      hotelLocationUrl: hotelLocationUrl,
      transportationDetails: transportationDetails,
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pilgrim_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PilgrimDetailsDto _$PilgrimDetailsDtoFromJson(Map<String, dynamic> json) =>
    PilgrimDetailsDto(
      passportNumber: json['passport_number'] as String?,
      travelPermitNumber: json['travel_permit_number'] as String?,
      medicalTestStatus: json['medical_test_status'] as String?,
      travelDate: json['travel_date'] == null
          ? null
          : DateTime.parse(json['travel_date'] as String),
      hotelName: json['hotel_name'] as String?,
      hotelLocationUrl: json['hotel_location_url'] as String?,
      transportationDetails: json['transportation_details'] as String?,
    );

Map<String, dynamic> _$PilgrimDetailsDtoToJson(PilgrimDetailsDto instance) =>
    <String, dynamic>{
      'passport_number': instance.passportNumber,
      'travel_permit_number': instance.travelPermitNumber,
      'medical_test_status': instance.medicalTestStatus,
      'travel_date': instance.travelDate?.toIso8601String(),
      'hotel_name': instance.hotelName,
      'hotel_location_url': instance.hotelLocationUrl,
      'transportation_details': instance.transportationDetails,
    };

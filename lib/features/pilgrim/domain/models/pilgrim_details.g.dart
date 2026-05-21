// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pilgrim_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PilgrimDetails _$PilgrimDetailsFromJson(Map<String, dynamic> json) =>
    _PilgrimDetails(
      passportNumber: json['passportNumber'] as String?,
      travelPermitNumber: json['travelPermitNumber'] as String?,
      medicalTestStatus: json['medicalTestStatus'] as String?,
      travelDate: json['travelDate'] == null
          ? null
          : DateTime.parse(json['travelDate'] as String),
      hotelName: json['hotelName'] as String?,
      hotelLocationUrl: json['hotelLocationUrl'] as String?,
      transportationDetails: json['transportationDetails'] as String?,
    );

Map<String, dynamic> _$PilgrimDetailsToJson(_PilgrimDetails instance) =>
    <String, dynamic>{
      'passportNumber': instance.passportNumber,
      'travelPermitNumber': instance.travelPermitNumber,
      'medicalTestStatus': instance.medicalTestStatus,
      'travelDate': instance.travelDate?.toIso8601String(),
      'hotelName': instance.hotelName,
      'hotelLocationUrl': instance.hotelLocationUrl,
      'transportationDetails': instance.transportationDetails,
    };

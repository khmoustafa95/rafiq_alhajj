import 'package:json_annotation/json_annotation.dart';
import 'package:rafiq_alhajj/features/pilgrim/domain/models/pilgrim.dart';

part 'pilgrim_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PilgrimDto {
  const PilgrimDto({
    this.registryId,
    this.profileId,
    this.enrollmentId,
    this.pilgrimId,
    this.tripId,
    this.tripType,
    this.groupId,
    this.koboId,
    this.sequence,
    this.cluster,
    this.coordinatorName,
    this.stickerNumber,
    this.visaNumber,
    this.barcodeNumber,
    this.fullNameAr,
    this.motherNameAr,
    this.birthDate,
    this.firstNameEn,
    this.lastNameEn,
    this.fatherNameEn,
    this.motherNameEn,
    this.passportNumber,
    this.passportExpiryDate,
    this.passportIssueDate,
    this.travelPermitNumber,
    this.gender,
    this.bodySize,
    this.groupName,
    this.companionName,
    this.relation,
    this.requestType,
    this.housingType,
    this.hadyStatus,
    this.residence,
    this.healthStatus,
    this.needsWheelchair,
    this.isSmoking,
    this.healthCard,
    this.isVaccinated,
    this.makkahHotel,
    this.makkahFloor,
    this.makkahRoom,
    this.madinahTravelDate,
    this.madinahHotel,
    this.madinahFloor,
    this.madinahRoom,
    this.departureAirport,
    this.departureAirline,
    this.departureFlightNo,
    this.departureDate,
    this.departureTime,
    this.returnAirport,
    this.returnAirline,
    this.returnFlightNo,
    this.returnDate,
    this.returnTime,
    this.serviceCenterName,
    this.serviceCenterArafat,
    this.serviceCenterMina,
    this.busArafat,
    this.busMina,
    this.tentArafat,
    this.tentMina,
    this.phoneNumber,
    this.whatsappNumber,
    this.syrianPhoneNumber,
    this.notes,
    this.fieldStatus,
    this.medicalTestStatus,
    this.travelDate,
    this.hotelName,
    this.hotelLocationUrl,
    this.transportationDetails,
  });

  factory PilgrimDto.fromJson(Map<String, dynamic> json) =>
      _$PilgrimDtoFromJson(json);

  @JsonKey(name: 'registry_id')
  final int? registryId;
  final String? profileId;
  final String? enrollmentId;
  final String? pilgrimId;
  final String? tripId;
  final String? tripType;
  final String? groupId;
  final String? koboId;
  final String? sequence;
  final String? cluster;
  final String? coordinatorName;
  final String? stickerNumber;
  final String? visaNumber;
  final String? barcodeNumber;
  final String? fullNameAr;
  final String? motherNameAr;
  final String? birthDate;
  final String? firstNameEn;
  final String? lastNameEn;
  final String? fatherNameEn;
  final String? motherNameEn;
  final String? passportNumber;
  final String? passportExpiryDate;
  final String? passportIssueDate;
  final String? travelPermitNumber;
  final String? gender;
  final String? bodySize;
  final String? groupName;
  final String? companionName;
  final String? relation;
  final String? requestType;
  final String? housingType;
  final String? hadyStatus;
  final String? residence;
  final String? healthStatus;
  final bool? needsWheelchair;
  final bool? isSmoking;
  final bool? healthCard;
  final bool? isVaccinated;
  final String? makkahHotel;
  final String? makkahFloor;
  final String? makkahRoom;
  final String? madinahTravelDate;
  final String? madinahHotel;
  final String? madinahFloor;
  final String? madinahRoom;
  final String? departureAirport;
  final String? departureAirline;
  final String? departureFlightNo;
  final String? departureDate;
  final String? departureTime;
  final String? returnAirport;
  final String? returnAirline;
  final String? returnFlightNo;
  final String? returnDate;
  final String? returnTime;
  final String? serviceCenterName;
  final String? serviceCenterArafat;
  final String? serviceCenterMina;
  final String? busArafat;
  final String? busMina;
  final String? tentArafat;
  final String? tentMina;
  final String? phoneNumber;
  final String? whatsappNumber;
  final String? syrianPhoneNumber;
  final String? notes;
  final String? fieldStatus;
  final String? medicalTestStatus;
  final DateTime? travelDate;
  final String? hotelName;
  final String? hotelLocationUrl;
  final String? transportationDetails;

  Pilgrim toDomain({String? displayName}) {
    return Pilgrim(
      profileId: profileId,
      enrollmentId: enrollmentId,
      pilgrimId: pilgrimId,
      tripId: tripId,
      tripType: tripType,
      groupId: groupId,
      displayName: displayName ?? fullNameAr,
      fieldStatus: fieldStatus,
      medicalTestStatus: medicalTestStatus,
      travelDate: travelDate,
      hotelName: hotelName,
      hotelLocationUrl: hotelLocationUrl,
      transportationDetails: transportationDetails,
      travelPermitNumber: travelPermitNumber,
      id: registryId,
      koboId: koboId,
      sequence: sequence,
      cluster: cluster,
      coordinatorName: coordinatorName,
      stickerNumber: stickerNumber,
      visaNumber: visaNumber,
      barcodeNumber: barcodeNumber,
      fullNameAr: fullNameAr,
      motherNameAr: motherNameAr,
      birthDate: birthDate,
      firstNameEn: firstNameEn,
      lastNameEn: lastNameEn,
      fatherNameEn: fatherNameEn,
      motherNameEn: motherNameEn,
      passportNumber: passportNumber,
      passportExpiryDate: passportExpiryDate,
      passportIssueDate: passportIssueDate,
      gender: gender,
      bodySize: bodySize,
      groupName: groupName,
      companionName: companionName,
      relation: relation,
      requestType: requestType,
      housingType: housingType,
      hadyStatus: hadyStatus,
      residence: residence,
      healthStatus: healthStatus,
      needsWheelchair: needsWheelchair,
      isSmoking: isSmoking,
      healthCard: healthCard,
      isVaccinated: isVaccinated,
      makkahHotel: makkahHotel,
      makkahFloor: makkahFloor,
      makkahRoom: makkahRoom,
      madinahTravelDate: madinahTravelDate,
      madinahHotel: madinahHotel,
      madinahFloor: madinahFloor,
      madinahRoom: madinahRoom,
      departureAirport: departureAirport,
      departureAirline: departureAirline,
      departureFlightNo: departureFlightNo,
      departureDate: departureDate,
      departureTime: departureTime,
      returnAirport: returnAirport,
      returnAirline: returnAirline,
      returnFlightNo: returnFlightNo,
      returnDate: returnDate,
      returnTime: returnTime,
      serviceCenterName: serviceCenterName,
      serviceCenterArafat: serviceCenterArafat,
      serviceCenterMina: serviceCenterMina,
      busArafat: busArafat,
      busMina: busMina,
      tentArafat: tentArafat,
      tentMina: tentMina,
      phoneNumber: phoneNumber,
      whatsappNumber: whatsappNumber,
      syrianPhoneNumber: syrianPhoneNumber,
      notes: notes,
    );
  }

  static Pilgrim fromJoinedProfile(Map<String, dynamic> row) {
    final details = _detailsMap(row['pilgrim_details']);
    if (details == null) {
      return Pilgrim(
        profileId: row['id'] as String?,
        displayName: row['full_name'] as String?,
      );
    }

    final dto = PilgrimDto.fromJson({
      ...details,
      'profile_id': row['id'],
    });

    return dto.toDomain(displayName: row['full_name'] as String?);
  }

  static Map<String, dynamic>? _detailsMap(dynamic value) {
    if (value == null) {
      return null;
    }
    if (value is List) {
      if (value.isEmpty) {
        return null;
      }
      return Map<String, dynamic>.from(value.first as Map);
    }
    return Map<String, dynamic>.from(value as Map);
  }
}

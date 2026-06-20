// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pilgrim.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Pilgrim {

/// Auth profile id (Supabase `profiles.id`).
 String? get profileId; String? get displayName; String? get fieldStatus; String? get medicalTestStatus; DateTime? get travelDate; String? get hotelName; String? get hotelLocationUrl; String? get transportationDetails; String? get travelPermitNumber;// بيانات التعريف والربط
 int? get id; String? get koboId;// ربط الحاج بالرحلة (النموذج الجديد)
 String? get enrollmentId; String? get pilgrimId; String? get tripId; String? get tripType; String? get groupId;// البيانات الأساسية
 String? get sequence; String? get cluster; String? get coordinatorName; String? get stickerNumber; String? get visaNumber; String? get barcodeNumber; String? get fullNameAr; String? get motherNameAr; String? get birthDate;// البيانات بالإنجليزية
 String? get firstNameEn; String? get lastNameEn; String? get fatherNameEn; String? get motherNameEn;// وثائق السفر
 String? get passportNumber; String? get passportExpiryDate; String? get passportIssueDate;// معلومات شخصية
 String? get gender; String? get bodySize; String? get groupName; String? get companionName; String? get relation;// تفاصيل الطلب والسكن
 String? get requestType; String? get housingType; String? get hadyStatus; String? get residence;// الحالة الصحية
 String? get healthStatus; bool? get needsWheelchair; bool? get isSmoking; bool? get healthCard; bool? get isVaccinated;// تفاصيل مكة
 String? get makkahHotel; String? get makkahFloor; String? get makkahRoom;// تفاصيل المدينة
 String? get madinahTravelDate; String? get madinahHotel; String? get madinahFloor; String? get madinahRoom;// تفاصيل رحلة الذهاب
 String? get departureAirport; String? get departureAirline; String? get departureFlightNo; String? get departureDate; String? get departureTime;// تفاصيل رحلة العودة
 String? get returnAirport; String? get returnAirline; String? get returnFlightNo; String? get returnDate; String? get returnTime;// المشاعر المقدسة
 String? get serviceCenterName; String? get serviceCenterArafat; String? get serviceCenterMina; String? get busArafat; String? get busMina; String? get tentArafat; String? get tentMina;// التواصل
 String? get phoneNumber; String? get whatsappNumber; String? get syrianPhoneNumber; String? get notes;
/// Create a copy of Pilgrim
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PilgrimCopyWith<Pilgrim> get copyWith => _$PilgrimCopyWithImpl<Pilgrim>(this as Pilgrim, _$identity);

  /// Serializes this Pilgrim to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Pilgrim&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.fieldStatus, fieldStatus) || other.fieldStatus == fieldStatus)&&(identical(other.medicalTestStatus, medicalTestStatus) || other.medicalTestStatus == medicalTestStatus)&&(identical(other.travelDate, travelDate) || other.travelDate == travelDate)&&(identical(other.hotelName, hotelName) || other.hotelName == hotelName)&&(identical(other.hotelLocationUrl, hotelLocationUrl) || other.hotelLocationUrl == hotelLocationUrl)&&(identical(other.transportationDetails, transportationDetails) || other.transportationDetails == transportationDetails)&&(identical(other.travelPermitNumber, travelPermitNumber) || other.travelPermitNumber == travelPermitNumber)&&(identical(other.id, id) || other.id == id)&&(identical(other.koboId, koboId) || other.koboId == koboId)&&(identical(other.enrollmentId, enrollmentId) || other.enrollmentId == enrollmentId)&&(identical(other.pilgrimId, pilgrimId) || other.pilgrimId == pilgrimId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.tripType, tripType) || other.tripType == tripType)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.sequence, sequence) || other.sequence == sequence)&&(identical(other.cluster, cluster) || other.cluster == cluster)&&(identical(other.coordinatorName, coordinatorName) || other.coordinatorName == coordinatorName)&&(identical(other.stickerNumber, stickerNumber) || other.stickerNumber == stickerNumber)&&(identical(other.visaNumber, visaNumber) || other.visaNumber == visaNumber)&&(identical(other.barcodeNumber, barcodeNumber) || other.barcodeNumber == barcodeNumber)&&(identical(other.fullNameAr, fullNameAr) || other.fullNameAr == fullNameAr)&&(identical(other.motherNameAr, motherNameAr) || other.motherNameAr == motherNameAr)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.firstNameEn, firstNameEn) || other.firstNameEn == firstNameEn)&&(identical(other.lastNameEn, lastNameEn) || other.lastNameEn == lastNameEn)&&(identical(other.fatherNameEn, fatherNameEn) || other.fatherNameEn == fatherNameEn)&&(identical(other.motherNameEn, motherNameEn) || other.motherNameEn == motherNameEn)&&(identical(other.passportNumber, passportNumber) || other.passportNumber == passportNumber)&&(identical(other.passportExpiryDate, passportExpiryDate) || other.passportExpiryDate == passportExpiryDate)&&(identical(other.passportIssueDate, passportIssueDate) || other.passportIssueDate == passportIssueDate)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.bodySize, bodySize) || other.bodySize == bodySize)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.companionName, companionName) || other.companionName == companionName)&&(identical(other.relation, relation) || other.relation == relation)&&(identical(other.requestType, requestType) || other.requestType == requestType)&&(identical(other.housingType, housingType) || other.housingType == housingType)&&(identical(other.hadyStatus, hadyStatus) || other.hadyStatus == hadyStatus)&&(identical(other.residence, residence) || other.residence == residence)&&(identical(other.healthStatus, healthStatus) || other.healthStatus == healthStatus)&&(identical(other.needsWheelchair, needsWheelchair) || other.needsWheelchair == needsWheelchair)&&(identical(other.isSmoking, isSmoking) || other.isSmoking == isSmoking)&&(identical(other.healthCard, healthCard) || other.healthCard == healthCard)&&(identical(other.isVaccinated, isVaccinated) || other.isVaccinated == isVaccinated)&&(identical(other.makkahHotel, makkahHotel) || other.makkahHotel == makkahHotel)&&(identical(other.makkahFloor, makkahFloor) || other.makkahFloor == makkahFloor)&&(identical(other.makkahRoom, makkahRoom) || other.makkahRoom == makkahRoom)&&(identical(other.madinahTravelDate, madinahTravelDate) || other.madinahTravelDate == madinahTravelDate)&&(identical(other.madinahHotel, madinahHotel) || other.madinahHotel == madinahHotel)&&(identical(other.madinahFloor, madinahFloor) || other.madinahFloor == madinahFloor)&&(identical(other.madinahRoom, madinahRoom) || other.madinahRoom == madinahRoom)&&(identical(other.departureAirport, departureAirport) || other.departureAirport == departureAirport)&&(identical(other.departureAirline, departureAirline) || other.departureAirline == departureAirline)&&(identical(other.departureFlightNo, departureFlightNo) || other.departureFlightNo == departureFlightNo)&&(identical(other.departureDate, departureDate) || other.departureDate == departureDate)&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.returnAirport, returnAirport) || other.returnAirport == returnAirport)&&(identical(other.returnAirline, returnAirline) || other.returnAirline == returnAirline)&&(identical(other.returnFlightNo, returnFlightNo) || other.returnFlightNo == returnFlightNo)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.returnTime, returnTime) || other.returnTime == returnTime)&&(identical(other.serviceCenterName, serviceCenterName) || other.serviceCenterName == serviceCenterName)&&(identical(other.serviceCenterArafat, serviceCenterArafat) || other.serviceCenterArafat == serviceCenterArafat)&&(identical(other.serviceCenterMina, serviceCenterMina) || other.serviceCenterMina == serviceCenterMina)&&(identical(other.busArafat, busArafat) || other.busArafat == busArafat)&&(identical(other.busMina, busMina) || other.busMina == busMina)&&(identical(other.tentArafat, tentArafat) || other.tentArafat == tentArafat)&&(identical(other.tentMina, tentMina) || other.tentMina == tentMina)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.whatsappNumber, whatsappNumber) || other.whatsappNumber == whatsappNumber)&&(identical(other.syrianPhoneNumber, syrianPhoneNumber) || other.syrianPhoneNumber == syrianPhoneNumber)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,profileId,displayName,fieldStatus,medicalTestStatus,travelDate,hotelName,hotelLocationUrl,transportationDetails,travelPermitNumber,id,koboId,enrollmentId,pilgrimId,tripId,tripType,groupId,sequence,cluster,coordinatorName,stickerNumber,visaNumber,barcodeNumber,fullNameAr,motherNameAr,birthDate,firstNameEn,lastNameEn,fatherNameEn,motherNameEn,passportNumber,passportExpiryDate,passportIssueDate,gender,bodySize,groupName,companionName,relation,requestType,housingType,hadyStatus,residence,healthStatus,needsWheelchair,isSmoking,healthCard,isVaccinated,makkahHotel,makkahFloor,makkahRoom,madinahTravelDate,madinahHotel,madinahFloor,madinahRoom,departureAirport,departureAirline,departureFlightNo,departureDate,departureTime,returnAirport,returnAirline,returnFlightNo,returnDate,returnTime,serviceCenterName,serviceCenterArafat,serviceCenterMina,busArafat,busMina,tentArafat,tentMina,phoneNumber,whatsappNumber,syrianPhoneNumber,notes]);

@override
String toString() {
  return 'Pilgrim(profileId: $profileId, displayName: $displayName, fieldStatus: $fieldStatus, medicalTestStatus: $medicalTestStatus, travelDate: $travelDate, hotelName: $hotelName, hotelLocationUrl: $hotelLocationUrl, transportationDetails: $transportationDetails, travelPermitNumber: $travelPermitNumber, id: $id, koboId: $koboId, enrollmentId: $enrollmentId, pilgrimId: $pilgrimId, tripId: $tripId, tripType: $tripType, groupId: $groupId, sequence: $sequence, cluster: $cluster, coordinatorName: $coordinatorName, stickerNumber: $stickerNumber, visaNumber: $visaNumber, barcodeNumber: $barcodeNumber, fullNameAr: $fullNameAr, motherNameAr: $motherNameAr, birthDate: $birthDate, firstNameEn: $firstNameEn, lastNameEn: $lastNameEn, fatherNameEn: $fatherNameEn, motherNameEn: $motherNameEn, passportNumber: $passportNumber, passportExpiryDate: $passportExpiryDate, passportIssueDate: $passportIssueDate, gender: $gender, bodySize: $bodySize, groupName: $groupName, companionName: $companionName, relation: $relation, requestType: $requestType, housingType: $housingType, hadyStatus: $hadyStatus, residence: $residence, healthStatus: $healthStatus, needsWheelchair: $needsWheelchair, isSmoking: $isSmoking, healthCard: $healthCard, isVaccinated: $isVaccinated, makkahHotel: $makkahHotel, makkahFloor: $makkahFloor, makkahRoom: $makkahRoom, madinahTravelDate: $madinahTravelDate, madinahHotel: $madinahHotel, madinahFloor: $madinahFloor, madinahRoom: $madinahRoom, departureAirport: $departureAirport, departureAirline: $departureAirline, departureFlightNo: $departureFlightNo, departureDate: $departureDate, departureTime: $departureTime, returnAirport: $returnAirport, returnAirline: $returnAirline, returnFlightNo: $returnFlightNo, returnDate: $returnDate, returnTime: $returnTime, serviceCenterName: $serviceCenterName, serviceCenterArafat: $serviceCenterArafat, serviceCenterMina: $serviceCenterMina, busArafat: $busArafat, busMina: $busMina, tentArafat: $tentArafat, tentMina: $tentMina, phoneNumber: $phoneNumber, whatsappNumber: $whatsappNumber, syrianPhoneNumber: $syrianPhoneNumber, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $PilgrimCopyWith<$Res>  {
  factory $PilgrimCopyWith(Pilgrim value, $Res Function(Pilgrim) _then) = _$PilgrimCopyWithImpl;
@useResult
$Res call({
 String? profileId, String? displayName, String? fieldStatus, String? medicalTestStatus, DateTime? travelDate, String? hotelName, String? hotelLocationUrl, String? transportationDetails, String? travelPermitNumber, int? id, String? koboId, String? enrollmentId, String? pilgrimId, String? tripId, String? tripType, String? groupId, String? sequence, String? cluster, String? coordinatorName, String? stickerNumber, String? visaNumber, String? barcodeNumber, String? fullNameAr, String? motherNameAr, String? birthDate, String? firstNameEn, String? lastNameEn, String? fatherNameEn, String? motherNameEn, String? passportNumber, String? passportExpiryDate, String? passportIssueDate, String? gender, String? bodySize, String? groupName, String? companionName, String? relation, String? requestType, String? housingType, String? hadyStatus, String? residence, String? healthStatus, bool? needsWheelchair, bool? isSmoking, bool? healthCard, bool? isVaccinated, String? makkahHotel, String? makkahFloor, String? makkahRoom, String? madinahTravelDate, String? madinahHotel, String? madinahFloor, String? madinahRoom, String? departureAirport, String? departureAirline, String? departureFlightNo, String? departureDate, String? departureTime, String? returnAirport, String? returnAirline, String? returnFlightNo, String? returnDate, String? returnTime, String? serviceCenterName, String? serviceCenterArafat, String? serviceCenterMina, String? busArafat, String? busMina, String? tentArafat, String? tentMina, String? phoneNumber, String? whatsappNumber, String? syrianPhoneNumber, String? notes
});




}
/// @nodoc
class _$PilgrimCopyWithImpl<$Res>
    implements $PilgrimCopyWith<$Res> {
  _$PilgrimCopyWithImpl(this._self, this._then);

  final Pilgrim _self;
  final $Res Function(Pilgrim) _then;

/// Create a copy of Pilgrim
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileId = freezed,Object? displayName = freezed,Object? fieldStatus = freezed,Object? medicalTestStatus = freezed,Object? travelDate = freezed,Object? hotelName = freezed,Object? hotelLocationUrl = freezed,Object? transportationDetails = freezed,Object? travelPermitNumber = freezed,Object? id = freezed,Object? koboId = freezed,Object? enrollmentId = freezed,Object? pilgrimId = freezed,Object? tripId = freezed,Object? tripType = freezed,Object? groupId = freezed,Object? sequence = freezed,Object? cluster = freezed,Object? coordinatorName = freezed,Object? stickerNumber = freezed,Object? visaNumber = freezed,Object? barcodeNumber = freezed,Object? fullNameAr = freezed,Object? motherNameAr = freezed,Object? birthDate = freezed,Object? firstNameEn = freezed,Object? lastNameEn = freezed,Object? fatherNameEn = freezed,Object? motherNameEn = freezed,Object? passportNumber = freezed,Object? passportExpiryDate = freezed,Object? passportIssueDate = freezed,Object? gender = freezed,Object? bodySize = freezed,Object? groupName = freezed,Object? companionName = freezed,Object? relation = freezed,Object? requestType = freezed,Object? housingType = freezed,Object? hadyStatus = freezed,Object? residence = freezed,Object? healthStatus = freezed,Object? needsWheelchair = freezed,Object? isSmoking = freezed,Object? healthCard = freezed,Object? isVaccinated = freezed,Object? makkahHotel = freezed,Object? makkahFloor = freezed,Object? makkahRoom = freezed,Object? madinahTravelDate = freezed,Object? madinahHotel = freezed,Object? madinahFloor = freezed,Object? madinahRoom = freezed,Object? departureAirport = freezed,Object? departureAirline = freezed,Object? departureFlightNo = freezed,Object? departureDate = freezed,Object? departureTime = freezed,Object? returnAirport = freezed,Object? returnAirline = freezed,Object? returnFlightNo = freezed,Object? returnDate = freezed,Object? returnTime = freezed,Object? serviceCenterName = freezed,Object? serviceCenterArafat = freezed,Object? serviceCenterMina = freezed,Object? busArafat = freezed,Object? busMina = freezed,Object? tentArafat = freezed,Object? tentMina = freezed,Object? phoneNumber = freezed,Object? whatsappNumber = freezed,Object? syrianPhoneNumber = freezed,Object? notes = freezed,}) {
  return _then(_self.copyWith(
profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,fieldStatus: freezed == fieldStatus ? _self.fieldStatus : fieldStatus // ignore: cast_nullable_to_non_nullable
as String?,medicalTestStatus: freezed == medicalTestStatus ? _self.medicalTestStatus : medicalTestStatus // ignore: cast_nullable_to_non_nullable
as String?,travelDate: freezed == travelDate ? _self.travelDate : travelDate // ignore: cast_nullable_to_non_nullable
as DateTime?,hotelName: freezed == hotelName ? _self.hotelName : hotelName // ignore: cast_nullable_to_non_nullable
as String?,hotelLocationUrl: freezed == hotelLocationUrl ? _self.hotelLocationUrl : hotelLocationUrl // ignore: cast_nullable_to_non_nullable
as String?,transportationDetails: freezed == transportationDetails ? _self.transportationDetails : transportationDetails // ignore: cast_nullable_to_non_nullable
as String?,travelPermitNumber: freezed == travelPermitNumber ? _self.travelPermitNumber : travelPermitNumber // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,koboId: freezed == koboId ? _self.koboId : koboId // ignore: cast_nullable_to_non_nullable
as String?,enrollmentId: freezed == enrollmentId ? _self.enrollmentId : enrollmentId // ignore: cast_nullable_to_non_nullable
as String?,pilgrimId: freezed == pilgrimId ? _self.pilgrimId : pilgrimId // ignore: cast_nullable_to_non_nullable
as String?,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,tripType: freezed == tripType ? _self.tripType : tripType // ignore: cast_nullable_to_non_nullable
as String?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,sequence: freezed == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as String?,cluster: freezed == cluster ? _self.cluster : cluster // ignore: cast_nullable_to_non_nullable
as String?,coordinatorName: freezed == coordinatorName ? _self.coordinatorName : coordinatorName // ignore: cast_nullable_to_non_nullable
as String?,stickerNumber: freezed == stickerNumber ? _self.stickerNumber : stickerNumber // ignore: cast_nullable_to_non_nullable
as String?,visaNumber: freezed == visaNumber ? _self.visaNumber : visaNumber // ignore: cast_nullable_to_non_nullable
as String?,barcodeNumber: freezed == barcodeNumber ? _self.barcodeNumber : barcodeNumber // ignore: cast_nullable_to_non_nullable
as String?,fullNameAr: freezed == fullNameAr ? _self.fullNameAr : fullNameAr // ignore: cast_nullable_to_non_nullable
as String?,motherNameAr: freezed == motherNameAr ? _self.motherNameAr : motherNameAr // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String?,firstNameEn: freezed == firstNameEn ? _self.firstNameEn : firstNameEn // ignore: cast_nullable_to_non_nullable
as String?,lastNameEn: freezed == lastNameEn ? _self.lastNameEn : lastNameEn // ignore: cast_nullable_to_non_nullable
as String?,fatherNameEn: freezed == fatherNameEn ? _self.fatherNameEn : fatherNameEn // ignore: cast_nullable_to_non_nullable
as String?,motherNameEn: freezed == motherNameEn ? _self.motherNameEn : motherNameEn // ignore: cast_nullable_to_non_nullable
as String?,passportNumber: freezed == passportNumber ? _self.passportNumber : passportNumber // ignore: cast_nullable_to_non_nullable
as String?,passportExpiryDate: freezed == passportExpiryDate ? _self.passportExpiryDate : passportExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,passportIssueDate: freezed == passportIssueDate ? _self.passportIssueDate : passportIssueDate // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,bodySize: freezed == bodySize ? _self.bodySize : bodySize // ignore: cast_nullable_to_non_nullable
as String?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,companionName: freezed == companionName ? _self.companionName : companionName // ignore: cast_nullable_to_non_nullable
as String?,relation: freezed == relation ? _self.relation : relation // ignore: cast_nullable_to_non_nullable
as String?,requestType: freezed == requestType ? _self.requestType : requestType // ignore: cast_nullable_to_non_nullable
as String?,housingType: freezed == housingType ? _self.housingType : housingType // ignore: cast_nullable_to_non_nullable
as String?,hadyStatus: freezed == hadyStatus ? _self.hadyStatus : hadyStatus // ignore: cast_nullable_to_non_nullable
as String?,residence: freezed == residence ? _self.residence : residence // ignore: cast_nullable_to_non_nullable
as String?,healthStatus: freezed == healthStatus ? _self.healthStatus : healthStatus // ignore: cast_nullable_to_non_nullable
as String?,needsWheelchair: freezed == needsWheelchair ? _self.needsWheelchair : needsWheelchair // ignore: cast_nullable_to_non_nullable
as bool?,isSmoking: freezed == isSmoking ? _self.isSmoking : isSmoking // ignore: cast_nullable_to_non_nullable
as bool?,healthCard: freezed == healthCard ? _self.healthCard : healthCard // ignore: cast_nullable_to_non_nullable
as bool?,isVaccinated: freezed == isVaccinated ? _self.isVaccinated : isVaccinated // ignore: cast_nullable_to_non_nullable
as bool?,makkahHotel: freezed == makkahHotel ? _self.makkahHotel : makkahHotel // ignore: cast_nullable_to_non_nullable
as String?,makkahFloor: freezed == makkahFloor ? _self.makkahFloor : makkahFloor // ignore: cast_nullable_to_non_nullable
as String?,makkahRoom: freezed == makkahRoom ? _self.makkahRoom : makkahRoom // ignore: cast_nullable_to_non_nullable
as String?,madinahTravelDate: freezed == madinahTravelDate ? _self.madinahTravelDate : madinahTravelDate // ignore: cast_nullable_to_non_nullable
as String?,madinahHotel: freezed == madinahHotel ? _self.madinahHotel : madinahHotel // ignore: cast_nullable_to_non_nullable
as String?,madinahFloor: freezed == madinahFloor ? _self.madinahFloor : madinahFloor // ignore: cast_nullable_to_non_nullable
as String?,madinahRoom: freezed == madinahRoom ? _self.madinahRoom : madinahRoom // ignore: cast_nullable_to_non_nullable
as String?,departureAirport: freezed == departureAirport ? _self.departureAirport : departureAirport // ignore: cast_nullable_to_non_nullable
as String?,departureAirline: freezed == departureAirline ? _self.departureAirline : departureAirline // ignore: cast_nullable_to_non_nullable
as String?,departureFlightNo: freezed == departureFlightNo ? _self.departureFlightNo : departureFlightNo // ignore: cast_nullable_to_non_nullable
as String?,departureDate: freezed == departureDate ? _self.departureDate : departureDate // ignore: cast_nullable_to_non_nullable
as String?,departureTime: freezed == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as String?,returnAirport: freezed == returnAirport ? _self.returnAirport : returnAirport // ignore: cast_nullable_to_non_nullable
as String?,returnAirline: freezed == returnAirline ? _self.returnAirline : returnAirline // ignore: cast_nullable_to_non_nullable
as String?,returnFlightNo: freezed == returnFlightNo ? _self.returnFlightNo : returnFlightNo // ignore: cast_nullable_to_non_nullable
as String?,returnDate: freezed == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String?,returnTime: freezed == returnTime ? _self.returnTime : returnTime // ignore: cast_nullable_to_non_nullable
as String?,serviceCenterName: freezed == serviceCenterName ? _self.serviceCenterName : serviceCenterName // ignore: cast_nullable_to_non_nullable
as String?,serviceCenterArafat: freezed == serviceCenterArafat ? _self.serviceCenterArafat : serviceCenterArafat // ignore: cast_nullable_to_non_nullable
as String?,serviceCenterMina: freezed == serviceCenterMina ? _self.serviceCenterMina : serviceCenterMina // ignore: cast_nullable_to_non_nullable
as String?,busArafat: freezed == busArafat ? _self.busArafat : busArafat // ignore: cast_nullable_to_non_nullable
as String?,busMina: freezed == busMina ? _self.busMina : busMina // ignore: cast_nullable_to_non_nullable
as String?,tentArafat: freezed == tentArafat ? _self.tentArafat : tentArafat // ignore: cast_nullable_to_non_nullable
as String?,tentMina: freezed == tentMina ? _self.tentMina : tentMina // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,whatsappNumber: freezed == whatsappNumber ? _self.whatsappNumber : whatsappNumber // ignore: cast_nullable_to_non_nullable
as String?,syrianPhoneNumber: freezed == syrianPhoneNumber ? _self.syrianPhoneNumber : syrianPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Pilgrim].
extension PilgrimPatterns on Pilgrim {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Pilgrim value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Pilgrim() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Pilgrim value)  $default,){
final _that = this;
switch (_that) {
case _Pilgrim():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Pilgrim value)?  $default,){
final _that = this;
switch (_that) {
case _Pilgrim() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? profileId,  String? displayName,  String? fieldStatus,  String? medicalTestStatus,  DateTime? travelDate,  String? hotelName,  String? hotelLocationUrl,  String? transportationDetails,  String? travelPermitNumber,  int? id,  String? koboId,  String? enrollmentId,  String? pilgrimId,  String? tripId,  String? tripType,  String? groupId,  String? sequence,  String? cluster,  String? coordinatorName,  String? stickerNumber,  String? visaNumber,  String? barcodeNumber,  String? fullNameAr,  String? motherNameAr,  String? birthDate,  String? firstNameEn,  String? lastNameEn,  String? fatherNameEn,  String? motherNameEn,  String? passportNumber,  String? passportExpiryDate,  String? passportIssueDate,  String? gender,  String? bodySize,  String? groupName,  String? companionName,  String? relation,  String? requestType,  String? housingType,  String? hadyStatus,  String? residence,  String? healthStatus,  bool? needsWheelchair,  bool? isSmoking,  bool? healthCard,  bool? isVaccinated,  String? makkahHotel,  String? makkahFloor,  String? makkahRoom,  String? madinahTravelDate,  String? madinahHotel,  String? madinahFloor,  String? madinahRoom,  String? departureAirport,  String? departureAirline,  String? departureFlightNo,  String? departureDate,  String? departureTime,  String? returnAirport,  String? returnAirline,  String? returnFlightNo,  String? returnDate,  String? returnTime,  String? serviceCenterName,  String? serviceCenterArafat,  String? serviceCenterMina,  String? busArafat,  String? busMina,  String? tentArafat,  String? tentMina,  String? phoneNumber,  String? whatsappNumber,  String? syrianPhoneNumber,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Pilgrim() when $default != null:
return $default(_that.profileId,_that.displayName,_that.fieldStatus,_that.medicalTestStatus,_that.travelDate,_that.hotelName,_that.hotelLocationUrl,_that.transportationDetails,_that.travelPermitNumber,_that.id,_that.koboId,_that.enrollmentId,_that.pilgrimId,_that.tripId,_that.tripType,_that.groupId,_that.sequence,_that.cluster,_that.coordinatorName,_that.stickerNumber,_that.visaNumber,_that.barcodeNumber,_that.fullNameAr,_that.motherNameAr,_that.birthDate,_that.firstNameEn,_that.lastNameEn,_that.fatherNameEn,_that.motherNameEn,_that.passportNumber,_that.passportExpiryDate,_that.passportIssueDate,_that.gender,_that.bodySize,_that.groupName,_that.companionName,_that.relation,_that.requestType,_that.housingType,_that.hadyStatus,_that.residence,_that.healthStatus,_that.needsWheelchair,_that.isSmoking,_that.healthCard,_that.isVaccinated,_that.makkahHotel,_that.makkahFloor,_that.makkahRoom,_that.madinahTravelDate,_that.madinahHotel,_that.madinahFloor,_that.madinahRoom,_that.departureAirport,_that.departureAirline,_that.departureFlightNo,_that.departureDate,_that.departureTime,_that.returnAirport,_that.returnAirline,_that.returnFlightNo,_that.returnDate,_that.returnTime,_that.serviceCenterName,_that.serviceCenterArafat,_that.serviceCenterMina,_that.busArafat,_that.busMina,_that.tentArafat,_that.tentMina,_that.phoneNumber,_that.whatsappNumber,_that.syrianPhoneNumber,_that.notes);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? profileId,  String? displayName,  String? fieldStatus,  String? medicalTestStatus,  DateTime? travelDate,  String? hotelName,  String? hotelLocationUrl,  String? transportationDetails,  String? travelPermitNumber,  int? id,  String? koboId,  String? enrollmentId,  String? pilgrimId,  String? tripId,  String? tripType,  String? groupId,  String? sequence,  String? cluster,  String? coordinatorName,  String? stickerNumber,  String? visaNumber,  String? barcodeNumber,  String? fullNameAr,  String? motherNameAr,  String? birthDate,  String? firstNameEn,  String? lastNameEn,  String? fatherNameEn,  String? motherNameEn,  String? passportNumber,  String? passportExpiryDate,  String? passportIssueDate,  String? gender,  String? bodySize,  String? groupName,  String? companionName,  String? relation,  String? requestType,  String? housingType,  String? hadyStatus,  String? residence,  String? healthStatus,  bool? needsWheelchair,  bool? isSmoking,  bool? healthCard,  bool? isVaccinated,  String? makkahHotel,  String? makkahFloor,  String? makkahRoom,  String? madinahTravelDate,  String? madinahHotel,  String? madinahFloor,  String? madinahRoom,  String? departureAirport,  String? departureAirline,  String? departureFlightNo,  String? departureDate,  String? departureTime,  String? returnAirport,  String? returnAirline,  String? returnFlightNo,  String? returnDate,  String? returnTime,  String? serviceCenterName,  String? serviceCenterArafat,  String? serviceCenterMina,  String? busArafat,  String? busMina,  String? tentArafat,  String? tentMina,  String? phoneNumber,  String? whatsappNumber,  String? syrianPhoneNumber,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _Pilgrim():
return $default(_that.profileId,_that.displayName,_that.fieldStatus,_that.medicalTestStatus,_that.travelDate,_that.hotelName,_that.hotelLocationUrl,_that.transportationDetails,_that.travelPermitNumber,_that.id,_that.koboId,_that.enrollmentId,_that.pilgrimId,_that.tripId,_that.tripType,_that.groupId,_that.sequence,_that.cluster,_that.coordinatorName,_that.stickerNumber,_that.visaNumber,_that.barcodeNumber,_that.fullNameAr,_that.motherNameAr,_that.birthDate,_that.firstNameEn,_that.lastNameEn,_that.fatherNameEn,_that.motherNameEn,_that.passportNumber,_that.passportExpiryDate,_that.passportIssueDate,_that.gender,_that.bodySize,_that.groupName,_that.companionName,_that.relation,_that.requestType,_that.housingType,_that.hadyStatus,_that.residence,_that.healthStatus,_that.needsWheelchair,_that.isSmoking,_that.healthCard,_that.isVaccinated,_that.makkahHotel,_that.makkahFloor,_that.makkahRoom,_that.madinahTravelDate,_that.madinahHotel,_that.madinahFloor,_that.madinahRoom,_that.departureAirport,_that.departureAirline,_that.departureFlightNo,_that.departureDate,_that.departureTime,_that.returnAirport,_that.returnAirline,_that.returnFlightNo,_that.returnDate,_that.returnTime,_that.serviceCenterName,_that.serviceCenterArafat,_that.serviceCenterMina,_that.busArafat,_that.busMina,_that.tentArafat,_that.tentMina,_that.phoneNumber,_that.whatsappNumber,_that.syrianPhoneNumber,_that.notes);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? profileId,  String? displayName,  String? fieldStatus,  String? medicalTestStatus,  DateTime? travelDate,  String? hotelName,  String? hotelLocationUrl,  String? transportationDetails,  String? travelPermitNumber,  int? id,  String? koboId,  String? enrollmentId,  String? pilgrimId,  String? tripId,  String? tripType,  String? groupId,  String? sequence,  String? cluster,  String? coordinatorName,  String? stickerNumber,  String? visaNumber,  String? barcodeNumber,  String? fullNameAr,  String? motherNameAr,  String? birthDate,  String? firstNameEn,  String? lastNameEn,  String? fatherNameEn,  String? motherNameEn,  String? passportNumber,  String? passportExpiryDate,  String? passportIssueDate,  String? gender,  String? bodySize,  String? groupName,  String? companionName,  String? relation,  String? requestType,  String? housingType,  String? hadyStatus,  String? residence,  String? healthStatus,  bool? needsWheelchair,  bool? isSmoking,  bool? healthCard,  bool? isVaccinated,  String? makkahHotel,  String? makkahFloor,  String? makkahRoom,  String? madinahTravelDate,  String? madinahHotel,  String? madinahFloor,  String? madinahRoom,  String? departureAirport,  String? departureAirline,  String? departureFlightNo,  String? departureDate,  String? departureTime,  String? returnAirport,  String? returnAirline,  String? returnFlightNo,  String? returnDate,  String? returnTime,  String? serviceCenterName,  String? serviceCenterArafat,  String? serviceCenterMina,  String? busArafat,  String? busMina,  String? tentArafat,  String? tentMina,  String? phoneNumber,  String? whatsappNumber,  String? syrianPhoneNumber,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _Pilgrim() when $default != null:
return $default(_that.profileId,_that.displayName,_that.fieldStatus,_that.medicalTestStatus,_that.travelDate,_that.hotelName,_that.hotelLocationUrl,_that.transportationDetails,_that.travelPermitNumber,_that.id,_that.koboId,_that.enrollmentId,_that.pilgrimId,_that.tripId,_that.tripType,_that.groupId,_that.sequence,_that.cluster,_that.coordinatorName,_that.stickerNumber,_that.visaNumber,_that.barcodeNumber,_that.fullNameAr,_that.motherNameAr,_that.birthDate,_that.firstNameEn,_that.lastNameEn,_that.fatherNameEn,_that.motherNameEn,_that.passportNumber,_that.passportExpiryDate,_that.passportIssueDate,_that.gender,_that.bodySize,_that.groupName,_that.companionName,_that.relation,_that.requestType,_that.housingType,_that.hadyStatus,_that.residence,_that.healthStatus,_that.needsWheelchair,_that.isSmoking,_that.healthCard,_that.isVaccinated,_that.makkahHotel,_that.makkahFloor,_that.makkahRoom,_that.madinahTravelDate,_that.madinahHotel,_that.madinahFloor,_that.madinahRoom,_that.departureAirport,_that.departureAirline,_that.departureFlightNo,_that.departureDate,_that.departureTime,_that.returnAirport,_that.returnAirline,_that.returnFlightNo,_that.returnDate,_that.returnTime,_that.serviceCenterName,_that.serviceCenterArafat,_that.serviceCenterMina,_that.busArafat,_that.busMina,_that.tentArafat,_that.tentMina,_that.phoneNumber,_that.whatsappNumber,_that.syrianPhoneNumber,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Pilgrim implements Pilgrim {
  const _Pilgrim({this.profileId, this.displayName, this.fieldStatus, this.medicalTestStatus, this.travelDate, this.hotelName, this.hotelLocationUrl, this.transportationDetails, this.travelPermitNumber, this.id, this.koboId, this.enrollmentId, this.pilgrimId, this.tripId, this.tripType, this.groupId, this.sequence, this.cluster, this.coordinatorName, this.stickerNumber, this.visaNumber, this.barcodeNumber, this.fullNameAr, this.motherNameAr, this.birthDate, this.firstNameEn, this.lastNameEn, this.fatherNameEn, this.motherNameEn, this.passportNumber, this.passportExpiryDate, this.passportIssueDate, this.gender, this.bodySize, this.groupName, this.companionName, this.relation, this.requestType, this.housingType, this.hadyStatus, this.residence, this.healthStatus, this.needsWheelchair, this.isSmoking, this.healthCard, this.isVaccinated, this.makkahHotel, this.makkahFloor, this.makkahRoom, this.madinahTravelDate, this.madinahHotel, this.madinahFloor, this.madinahRoom, this.departureAirport, this.departureAirline, this.departureFlightNo, this.departureDate, this.departureTime, this.returnAirport, this.returnAirline, this.returnFlightNo, this.returnDate, this.returnTime, this.serviceCenterName, this.serviceCenterArafat, this.serviceCenterMina, this.busArafat, this.busMina, this.tentArafat, this.tentMina, this.phoneNumber, this.whatsappNumber, this.syrianPhoneNumber, this.notes});
  factory _Pilgrim.fromJson(Map<String, dynamic> json) => _$PilgrimFromJson(json);

/// Auth profile id (Supabase `profiles.id`).
@override final  String? profileId;
@override final  String? displayName;
@override final  String? fieldStatus;
@override final  String? medicalTestStatus;
@override final  DateTime? travelDate;
@override final  String? hotelName;
@override final  String? hotelLocationUrl;
@override final  String? transportationDetails;
@override final  String? travelPermitNumber;
// بيانات التعريف والربط
@override final  int? id;
@override final  String? koboId;
// ربط الحاج بالرحلة (النموذج الجديد)
@override final  String? enrollmentId;
@override final  String? pilgrimId;
@override final  String? tripId;
@override final  String? tripType;
@override final  String? groupId;
// البيانات الأساسية
@override final  String? sequence;
@override final  String? cluster;
@override final  String? coordinatorName;
@override final  String? stickerNumber;
@override final  String? visaNumber;
@override final  String? barcodeNumber;
@override final  String? fullNameAr;
@override final  String? motherNameAr;
@override final  String? birthDate;
// البيانات بالإنجليزية
@override final  String? firstNameEn;
@override final  String? lastNameEn;
@override final  String? fatherNameEn;
@override final  String? motherNameEn;
// وثائق السفر
@override final  String? passportNumber;
@override final  String? passportExpiryDate;
@override final  String? passportIssueDate;
// معلومات شخصية
@override final  String? gender;
@override final  String? bodySize;
@override final  String? groupName;
@override final  String? companionName;
@override final  String? relation;
// تفاصيل الطلب والسكن
@override final  String? requestType;
@override final  String? housingType;
@override final  String? hadyStatus;
@override final  String? residence;
// الحالة الصحية
@override final  String? healthStatus;
@override final  bool? needsWheelchair;
@override final  bool? isSmoking;
@override final  bool? healthCard;
@override final  bool? isVaccinated;
// تفاصيل مكة
@override final  String? makkahHotel;
@override final  String? makkahFloor;
@override final  String? makkahRoom;
// تفاصيل المدينة
@override final  String? madinahTravelDate;
@override final  String? madinahHotel;
@override final  String? madinahFloor;
@override final  String? madinahRoom;
// تفاصيل رحلة الذهاب
@override final  String? departureAirport;
@override final  String? departureAirline;
@override final  String? departureFlightNo;
@override final  String? departureDate;
@override final  String? departureTime;
// تفاصيل رحلة العودة
@override final  String? returnAirport;
@override final  String? returnAirline;
@override final  String? returnFlightNo;
@override final  String? returnDate;
@override final  String? returnTime;
// المشاعر المقدسة
@override final  String? serviceCenterName;
@override final  String? serviceCenterArafat;
@override final  String? serviceCenterMina;
@override final  String? busArafat;
@override final  String? busMina;
@override final  String? tentArafat;
@override final  String? tentMina;
// التواصل
@override final  String? phoneNumber;
@override final  String? whatsappNumber;
@override final  String? syrianPhoneNumber;
@override final  String? notes;

/// Create a copy of Pilgrim
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PilgrimCopyWith<_Pilgrim> get copyWith => __$PilgrimCopyWithImpl<_Pilgrim>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PilgrimToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Pilgrim&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.fieldStatus, fieldStatus) || other.fieldStatus == fieldStatus)&&(identical(other.medicalTestStatus, medicalTestStatus) || other.medicalTestStatus == medicalTestStatus)&&(identical(other.travelDate, travelDate) || other.travelDate == travelDate)&&(identical(other.hotelName, hotelName) || other.hotelName == hotelName)&&(identical(other.hotelLocationUrl, hotelLocationUrl) || other.hotelLocationUrl == hotelLocationUrl)&&(identical(other.transportationDetails, transportationDetails) || other.transportationDetails == transportationDetails)&&(identical(other.travelPermitNumber, travelPermitNumber) || other.travelPermitNumber == travelPermitNumber)&&(identical(other.id, id) || other.id == id)&&(identical(other.koboId, koboId) || other.koboId == koboId)&&(identical(other.enrollmentId, enrollmentId) || other.enrollmentId == enrollmentId)&&(identical(other.pilgrimId, pilgrimId) || other.pilgrimId == pilgrimId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.tripType, tripType) || other.tripType == tripType)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.sequence, sequence) || other.sequence == sequence)&&(identical(other.cluster, cluster) || other.cluster == cluster)&&(identical(other.coordinatorName, coordinatorName) || other.coordinatorName == coordinatorName)&&(identical(other.stickerNumber, stickerNumber) || other.stickerNumber == stickerNumber)&&(identical(other.visaNumber, visaNumber) || other.visaNumber == visaNumber)&&(identical(other.barcodeNumber, barcodeNumber) || other.barcodeNumber == barcodeNumber)&&(identical(other.fullNameAr, fullNameAr) || other.fullNameAr == fullNameAr)&&(identical(other.motherNameAr, motherNameAr) || other.motherNameAr == motherNameAr)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate)&&(identical(other.firstNameEn, firstNameEn) || other.firstNameEn == firstNameEn)&&(identical(other.lastNameEn, lastNameEn) || other.lastNameEn == lastNameEn)&&(identical(other.fatherNameEn, fatherNameEn) || other.fatherNameEn == fatherNameEn)&&(identical(other.motherNameEn, motherNameEn) || other.motherNameEn == motherNameEn)&&(identical(other.passportNumber, passportNumber) || other.passportNumber == passportNumber)&&(identical(other.passportExpiryDate, passportExpiryDate) || other.passportExpiryDate == passportExpiryDate)&&(identical(other.passportIssueDate, passportIssueDate) || other.passportIssueDate == passportIssueDate)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.bodySize, bodySize) || other.bodySize == bodySize)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.companionName, companionName) || other.companionName == companionName)&&(identical(other.relation, relation) || other.relation == relation)&&(identical(other.requestType, requestType) || other.requestType == requestType)&&(identical(other.housingType, housingType) || other.housingType == housingType)&&(identical(other.hadyStatus, hadyStatus) || other.hadyStatus == hadyStatus)&&(identical(other.residence, residence) || other.residence == residence)&&(identical(other.healthStatus, healthStatus) || other.healthStatus == healthStatus)&&(identical(other.needsWheelchair, needsWheelchair) || other.needsWheelchair == needsWheelchair)&&(identical(other.isSmoking, isSmoking) || other.isSmoking == isSmoking)&&(identical(other.healthCard, healthCard) || other.healthCard == healthCard)&&(identical(other.isVaccinated, isVaccinated) || other.isVaccinated == isVaccinated)&&(identical(other.makkahHotel, makkahHotel) || other.makkahHotel == makkahHotel)&&(identical(other.makkahFloor, makkahFloor) || other.makkahFloor == makkahFloor)&&(identical(other.makkahRoom, makkahRoom) || other.makkahRoom == makkahRoom)&&(identical(other.madinahTravelDate, madinahTravelDate) || other.madinahTravelDate == madinahTravelDate)&&(identical(other.madinahHotel, madinahHotel) || other.madinahHotel == madinahHotel)&&(identical(other.madinahFloor, madinahFloor) || other.madinahFloor == madinahFloor)&&(identical(other.madinahRoom, madinahRoom) || other.madinahRoom == madinahRoom)&&(identical(other.departureAirport, departureAirport) || other.departureAirport == departureAirport)&&(identical(other.departureAirline, departureAirline) || other.departureAirline == departureAirline)&&(identical(other.departureFlightNo, departureFlightNo) || other.departureFlightNo == departureFlightNo)&&(identical(other.departureDate, departureDate) || other.departureDate == departureDate)&&(identical(other.departureTime, departureTime) || other.departureTime == departureTime)&&(identical(other.returnAirport, returnAirport) || other.returnAirport == returnAirport)&&(identical(other.returnAirline, returnAirline) || other.returnAirline == returnAirline)&&(identical(other.returnFlightNo, returnFlightNo) || other.returnFlightNo == returnFlightNo)&&(identical(other.returnDate, returnDate) || other.returnDate == returnDate)&&(identical(other.returnTime, returnTime) || other.returnTime == returnTime)&&(identical(other.serviceCenterName, serviceCenterName) || other.serviceCenterName == serviceCenterName)&&(identical(other.serviceCenterArafat, serviceCenterArafat) || other.serviceCenterArafat == serviceCenterArafat)&&(identical(other.serviceCenterMina, serviceCenterMina) || other.serviceCenterMina == serviceCenterMina)&&(identical(other.busArafat, busArafat) || other.busArafat == busArafat)&&(identical(other.busMina, busMina) || other.busMina == busMina)&&(identical(other.tentArafat, tentArafat) || other.tentArafat == tentArafat)&&(identical(other.tentMina, tentMina) || other.tentMina == tentMina)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.whatsappNumber, whatsappNumber) || other.whatsappNumber == whatsappNumber)&&(identical(other.syrianPhoneNumber, syrianPhoneNumber) || other.syrianPhoneNumber == syrianPhoneNumber)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,profileId,displayName,fieldStatus,medicalTestStatus,travelDate,hotelName,hotelLocationUrl,transportationDetails,travelPermitNumber,id,koboId,enrollmentId,pilgrimId,tripId,tripType,groupId,sequence,cluster,coordinatorName,stickerNumber,visaNumber,barcodeNumber,fullNameAr,motherNameAr,birthDate,firstNameEn,lastNameEn,fatherNameEn,motherNameEn,passportNumber,passportExpiryDate,passportIssueDate,gender,bodySize,groupName,companionName,relation,requestType,housingType,hadyStatus,residence,healthStatus,needsWheelchair,isSmoking,healthCard,isVaccinated,makkahHotel,makkahFloor,makkahRoom,madinahTravelDate,madinahHotel,madinahFloor,madinahRoom,departureAirport,departureAirline,departureFlightNo,departureDate,departureTime,returnAirport,returnAirline,returnFlightNo,returnDate,returnTime,serviceCenterName,serviceCenterArafat,serviceCenterMina,busArafat,busMina,tentArafat,tentMina,phoneNumber,whatsappNumber,syrianPhoneNumber,notes]);

@override
String toString() {
  return 'Pilgrim(profileId: $profileId, displayName: $displayName, fieldStatus: $fieldStatus, medicalTestStatus: $medicalTestStatus, travelDate: $travelDate, hotelName: $hotelName, hotelLocationUrl: $hotelLocationUrl, transportationDetails: $transportationDetails, travelPermitNumber: $travelPermitNumber, id: $id, koboId: $koboId, enrollmentId: $enrollmentId, pilgrimId: $pilgrimId, tripId: $tripId, tripType: $tripType, groupId: $groupId, sequence: $sequence, cluster: $cluster, coordinatorName: $coordinatorName, stickerNumber: $stickerNumber, visaNumber: $visaNumber, barcodeNumber: $barcodeNumber, fullNameAr: $fullNameAr, motherNameAr: $motherNameAr, birthDate: $birthDate, firstNameEn: $firstNameEn, lastNameEn: $lastNameEn, fatherNameEn: $fatherNameEn, motherNameEn: $motherNameEn, passportNumber: $passportNumber, passportExpiryDate: $passportExpiryDate, passportIssueDate: $passportIssueDate, gender: $gender, bodySize: $bodySize, groupName: $groupName, companionName: $companionName, relation: $relation, requestType: $requestType, housingType: $housingType, hadyStatus: $hadyStatus, residence: $residence, healthStatus: $healthStatus, needsWheelchair: $needsWheelchair, isSmoking: $isSmoking, healthCard: $healthCard, isVaccinated: $isVaccinated, makkahHotel: $makkahHotel, makkahFloor: $makkahFloor, makkahRoom: $makkahRoom, madinahTravelDate: $madinahTravelDate, madinahHotel: $madinahHotel, madinahFloor: $madinahFloor, madinahRoom: $madinahRoom, departureAirport: $departureAirport, departureAirline: $departureAirline, departureFlightNo: $departureFlightNo, departureDate: $departureDate, departureTime: $departureTime, returnAirport: $returnAirport, returnAirline: $returnAirline, returnFlightNo: $returnFlightNo, returnDate: $returnDate, returnTime: $returnTime, serviceCenterName: $serviceCenterName, serviceCenterArafat: $serviceCenterArafat, serviceCenterMina: $serviceCenterMina, busArafat: $busArafat, busMina: $busMina, tentArafat: $tentArafat, tentMina: $tentMina, phoneNumber: $phoneNumber, whatsappNumber: $whatsappNumber, syrianPhoneNumber: $syrianPhoneNumber, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$PilgrimCopyWith<$Res> implements $PilgrimCopyWith<$Res> {
  factory _$PilgrimCopyWith(_Pilgrim value, $Res Function(_Pilgrim) _then) = __$PilgrimCopyWithImpl;
@override @useResult
$Res call({
 String? profileId, String? displayName, String? fieldStatus, String? medicalTestStatus, DateTime? travelDate, String? hotelName, String? hotelLocationUrl, String? transportationDetails, String? travelPermitNumber, int? id, String? koboId, String? enrollmentId, String? pilgrimId, String? tripId, String? tripType, String? groupId, String? sequence, String? cluster, String? coordinatorName, String? stickerNumber, String? visaNumber, String? barcodeNumber, String? fullNameAr, String? motherNameAr, String? birthDate, String? firstNameEn, String? lastNameEn, String? fatherNameEn, String? motherNameEn, String? passportNumber, String? passportExpiryDate, String? passportIssueDate, String? gender, String? bodySize, String? groupName, String? companionName, String? relation, String? requestType, String? housingType, String? hadyStatus, String? residence, String? healthStatus, bool? needsWheelchair, bool? isSmoking, bool? healthCard, bool? isVaccinated, String? makkahHotel, String? makkahFloor, String? makkahRoom, String? madinahTravelDate, String? madinahHotel, String? madinahFloor, String? madinahRoom, String? departureAirport, String? departureAirline, String? departureFlightNo, String? departureDate, String? departureTime, String? returnAirport, String? returnAirline, String? returnFlightNo, String? returnDate, String? returnTime, String? serviceCenterName, String? serviceCenterArafat, String? serviceCenterMina, String? busArafat, String? busMina, String? tentArafat, String? tentMina, String? phoneNumber, String? whatsappNumber, String? syrianPhoneNumber, String? notes
});




}
/// @nodoc
class __$PilgrimCopyWithImpl<$Res>
    implements _$PilgrimCopyWith<$Res> {
  __$PilgrimCopyWithImpl(this._self, this._then);

  final _Pilgrim _self;
  final $Res Function(_Pilgrim) _then;

/// Create a copy of Pilgrim
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileId = freezed,Object? displayName = freezed,Object? fieldStatus = freezed,Object? medicalTestStatus = freezed,Object? travelDate = freezed,Object? hotelName = freezed,Object? hotelLocationUrl = freezed,Object? transportationDetails = freezed,Object? travelPermitNumber = freezed,Object? id = freezed,Object? koboId = freezed,Object? enrollmentId = freezed,Object? pilgrimId = freezed,Object? tripId = freezed,Object? tripType = freezed,Object? groupId = freezed,Object? sequence = freezed,Object? cluster = freezed,Object? coordinatorName = freezed,Object? stickerNumber = freezed,Object? visaNumber = freezed,Object? barcodeNumber = freezed,Object? fullNameAr = freezed,Object? motherNameAr = freezed,Object? birthDate = freezed,Object? firstNameEn = freezed,Object? lastNameEn = freezed,Object? fatherNameEn = freezed,Object? motherNameEn = freezed,Object? passportNumber = freezed,Object? passportExpiryDate = freezed,Object? passportIssueDate = freezed,Object? gender = freezed,Object? bodySize = freezed,Object? groupName = freezed,Object? companionName = freezed,Object? relation = freezed,Object? requestType = freezed,Object? housingType = freezed,Object? hadyStatus = freezed,Object? residence = freezed,Object? healthStatus = freezed,Object? needsWheelchair = freezed,Object? isSmoking = freezed,Object? healthCard = freezed,Object? isVaccinated = freezed,Object? makkahHotel = freezed,Object? makkahFloor = freezed,Object? makkahRoom = freezed,Object? madinahTravelDate = freezed,Object? madinahHotel = freezed,Object? madinahFloor = freezed,Object? madinahRoom = freezed,Object? departureAirport = freezed,Object? departureAirline = freezed,Object? departureFlightNo = freezed,Object? departureDate = freezed,Object? departureTime = freezed,Object? returnAirport = freezed,Object? returnAirline = freezed,Object? returnFlightNo = freezed,Object? returnDate = freezed,Object? returnTime = freezed,Object? serviceCenterName = freezed,Object? serviceCenterArafat = freezed,Object? serviceCenterMina = freezed,Object? busArafat = freezed,Object? busMina = freezed,Object? tentArafat = freezed,Object? tentMina = freezed,Object? phoneNumber = freezed,Object? whatsappNumber = freezed,Object? syrianPhoneNumber = freezed,Object? notes = freezed,}) {
  return _then(_Pilgrim(
profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,fieldStatus: freezed == fieldStatus ? _self.fieldStatus : fieldStatus // ignore: cast_nullable_to_non_nullable
as String?,medicalTestStatus: freezed == medicalTestStatus ? _self.medicalTestStatus : medicalTestStatus // ignore: cast_nullable_to_non_nullable
as String?,travelDate: freezed == travelDate ? _self.travelDate : travelDate // ignore: cast_nullable_to_non_nullable
as DateTime?,hotelName: freezed == hotelName ? _self.hotelName : hotelName // ignore: cast_nullable_to_non_nullable
as String?,hotelLocationUrl: freezed == hotelLocationUrl ? _self.hotelLocationUrl : hotelLocationUrl // ignore: cast_nullable_to_non_nullable
as String?,transportationDetails: freezed == transportationDetails ? _self.transportationDetails : transportationDetails // ignore: cast_nullable_to_non_nullable
as String?,travelPermitNumber: freezed == travelPermitNumber ? _self.travelPermitNumber : travelPermitNumber // ignore: cast_nullable_to_non_nullable
as String?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,koboId: freezed == koboId ? _self.koboId : koboId // ignore: cast_nullable_to_non_nullable
as String?,enrollmentId: freezed == enrollmentId ? _self.enrollmentId : enrollmentId // ignore: cast_nullable_to_non_nullable
as String?,pilgrimId: freezed == pilgrimId ? _self.pilgrimId : pilgrimId // ignore: cast_nullable_to_non_nullable
as String?,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,tripType: freezed == tripType ? _self.tripType : tripType // ignore: cast_nullable_to_non_nullable
as String?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,sequence: freezed == sequence ? _self.sequence : sequence // ignore: cast_nullable_to_non_nullable
as String?,cluster: freezed == cluster ? _self.cluster : cluster // ignore: cast_nullable_to_non_nullable
as String?,coordinatorName: freezed == coordinatorName ? _self.coordinatorName : coordinatorName // ignore: cast_nullable_to_non_nullable
as String?,stickerNumber: freezed == stickerNumber ? _self.stickerNumber : stickerNumber // ignore: cast_nullable_to_non_nullable
as String?,visaNumber: freezed == visaNumber ? _self.visaNumber : visaNumber // ignore: cast_nullable_to_non_nullable
as String?,barcodeNumber: freezed == barcodeNumber ? _self.barcodeNumber : barcodeNumber // ignore: cast_nullable_to_non_nullable
as String?,fullNameAr: freezed == fullNameAr ? _self.fullNameAr : fullNameAr // ignore: cast_nullable_to_non_nullable
as String?,motherNameAr: freezed == motherNameAr ? _self.motherNameAr : motherNameAr // ignore: cast_nullable_to_non_nullable
as String?,birthDate: freezed == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String?,firstNameEn: freezed == firstNameEn ? _self.firstNameEn : firstNameEn // ignore: cast_nullable_to_non_nullable
as String?,lastNameEn: freezed == lastNameEn ? _self.lastNameEn : lastNameEn // ignore: cast_nullable_to_non_nullable
as String?,fatherNameEn: freezed == fatherNameEn ? _self.fatherNameEn : fatherNameEn // ignore: cast_nullable_to_non_nullable
as String?,motherNameEn: freezed == motherNameEn ? _self.motherNameEn : motherNameEn // ignore: cast_nullable_to_non_nullable
as String?,passportNumber: freezed == passportNumber ? _self.passportNumber : passportNumber // ignore: cast_nullable_to_non_nullable
as String?,passportExpiryDate: freezed == passportExpiryDate ? _self.passportExpiryDate : passportExpiryDate // ignore: cast_nullable_to_non_nullable
as String?,passportIssueDate: freezed == passportIssueDate ? _self.passportIssueDate : passportIssueDate // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,bodySize: freezed == bodySize ? _self.bodySize : bodySize // ignore: cast_nullable_to_non_nullable
as String?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,companionName: freezed == companionName ? _self.companionName : companionName // ignore: cast_nullable_to_non_nullable
as String?,relation: freezed == relation ? _self.relation : relation // ignore: cast_nullable_to_non_nullable
as String?,requestType: freezed == requestType ? _self.requestType : requestType // ignore: cast_nullable_to_non_nullable
as String?,housingType: freezed == housingType ? _self.housingType : housingType // ignore: cast_nullable_to_non_nullable
as String?,hadyStatus: freezed == hadyStatus ? _self.hadyStatus : hadyStatus // ignore: cast_nullable_to_non_nullable
as String?,residence: freezed == residence ? _self.residence : residence // ignore: cast_nullable_to_non_nullable
as String?,healthStatus: freezed == healthStatus ? _self.healthStatus : healthStatus // ignore: cast_nullable_to_non_nullable
as String?,needsWheelchair: freezed == needsWheelchair ? _self.needsWheelchair : needsWheelchair // ignore: cast_nullable_to_non_nullable
as bool?,isSmoking: freezed == isSmoking ? _self.isSmoking : isSmoking // ignore: cast_nullable_to_non_nullable
as bool?,healthCard: freezed == healthCard ? _self.healthCard : healthCard // ignore: cast_nullable_to_non_nullable
as bool?,isVaccinated: freezed == isVaccinated ? _self.isVaccinated : isVaccinated // ignore: cast_nullable_to_non_nullable
as bool?,makkahHotel: freezed == makkahHotel ? _self.makkahHotel : makkahHotel // ignore: cast_nullable_to_non_nullable
as String?,makkahFloor: freezed == makkahFloor ? _self.makkahFloor : makkahFloor // ignore: cast_nullable_to_non_nullable
as String?,makkahRoom: freezed == makkahRoom ? _self.makkahRoom : makkahRoom // ignore: cast_nullable_to_non_nullable
as String?,madinahTravelDate: freezed == madinahTravelDate ? _self.madinahTravelDate : madinahTravelDate // ignore: cast_nullable_to_non_nullable
as String?,madinahHotel: freezed == madinahHotel ? _self.madinahHotel : madinahHotel // ignore: cast_nullable_to_non_nullable
as String?,madinahFloor: freezed == madinahFloor ? _self.madinahFloor : madinahFloor // ignore: cast_nullable_to_non_nullable
as String?,madinahRoom: freezed == madinahRoom ? _self.madinahRoom : madinahRoom // ignore: cast_nullable_to_non_nullable
as String?,departureAirport: freezed == departureAirport ? _self.departureAirport : departureAirport // ignore: cast_nullable_to_non_nullable
as String?,departureAirline: freezed == departureAirline ? _self.departureAirline : departureAirline // ignore: cast_nullable_to_non_nullable
as String?,departureFlightNo: freezed == departureFlightNo ? _self.departureFlightNo : departureFlightNo // ignore: cast_nullable_to_non_nullable
as String?,departureDate: freezed == departureDate ? _self.departureDate : departureDate // ignore: cast_nullable_to_non_nullable
as String?,departureTime: freezed == departureTime ? _self.departureTime : departureTime // ignore: cast_nullable_to_non_nullable
as String?,returnAirport: freezed == returnAirport ? _self.returnAirport : returnAirport // ignore: cast_nullable_to_non_nullable
as String?,returnAirline: freezed == returnAirline ? _self.returnAirline : returnAirline // ignore: cast_nullable_to_non_nullable
as String?,returnFlightNo: freezed == returnFlightNo ? _self.returnFlightNo : returnFlightNo // ignore: cast_nullable_to_non_nullable
as String?,returnDate: freezed == returnDate ? _self.returnDate : returnDate // ignore: cast_nullable_to_non_nullable
as String?,returnTime: freezed == returnTime ? _self.returnTime : returnTime // ignore: cast_nullable_to_non_nullable
as String?,serviceCenterName: freezed == serviceCenterName ? _self.serviceCenterName : serviceCenterName // ignore: cast_nullable_to_non_nullable
as String?,serviceCenterArafat: freezed == serviceCenterArafat ? _self.serviceCenterArafat : serviceCenterArafat // ignore: cast_nullable_to_non_nullable
as String?,serviceCenterMina: freezed == serviceCenterMina ? _self.serviceCenterMina : serviceCenterMina // ignore: cast_nullable_to_non_nullable
as String?,busArafat: freezed == busArafat ? _self.busArafat : busArafat // ignore: cast_nullable_to_non_nullable
as String?,busMina: freezed == busMina ? _self.busMina : busMina // ignore: cast_nullable_to_non_nullable
as String?,tentArafat: freezed == tentArafat ? _self.tentArafat : tentArafat // ignore: cast_nullable_to_non_nullable
as String?,tentMina: freezed == tentMina ? _self.tentMina : tentMina // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,whatsappNumber: freezed == whatsappNumber ? _self.whatsappNumber : whatsappNumber // ignore: cast_nullable_to_non_nullable
as String?,syrianPhoneNumber: freezed == syrianPhoneNumber ? _self.syrianPhoneNumber : syrianPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

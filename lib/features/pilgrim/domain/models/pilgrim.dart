import 'package:freezed_annotation/freezed_annotation.dart';

part 'pilgrim.freezed.dart';
part 'pilgrim.g.dart';

@freezed
abstract class Pilgrim with _$Pilgrim {
  const factory Pilgrim({
  /// Auth profile id (Supabase `profiles.id`).
    String? profileId,
    String? displayName,
    String? fieldStatus,
    String? medicalTestStatus,
    DateTime? travelDate,
    String? hotelName,
    String? hotelLocationUrl,
    String? transportationDetails,
    String? travelPermitNumber,

    // بيانات التعريف والربط
    int? id,
    String? koboId,

    // ربط الحاج بالرحلة (النموذج الجديد)
    String? enrollmentId,
    String? pilgrimId,
    String? tripId,
    String? tripType,
    String? groupId,

    // البيانات الأساسية
    String? sequence,
    String? cluster,
    String? coordinatorName,
    String? stickerNumber,
    String? visaNumber,
    String? barcodeNumber,
    String? fullNameAr,
    String? motherNameAr,
    String? birthDate,

    // البيانات بالإنجليزية
    String? firstNameEn,
    String? lastNameEn,
    String? fatherNameEn,
    String? motherNameEn,

    // وثائق السفر
    String? passportNumber,
    String? passportExpiryDate,
    String? passportIssueDate,

    // معلومات شخصية
    String? gender,
    String? bodySize,
    String? groupName,
    String? companionName,
    String? relation,

    // تفاصيل الطلب والسكن
    String? requestType,
    String? housingType,
    String? hadyStatus,
    String? residence,

    // الحالة الصحية
    String? healthStatus,
    bool? needsWheelchair,
    bool? isSmoking,
    bool? healthCard,
    bool? isVaccinated,

    // تفاصيل مكة
    String? makkahHotel,
    String? makkahFloor,
    String? makkahRoom,

    // تفاصيل المدينة
    String? madinahTravelDate,
    String? madinahHotel,
    String? madinahFloor,
    String? madinahRoom,

    // تفاصيل رحلة الذهاب
    String? departureAirport,
    String? departureAirline,
    String? departureFlightNo,
    String? departureDate,
    String? departureTime,

    // تفاصيل رحلة العودة
    String? returnAirport,
    String? returnAirline,
    String? returnFlightNo,
    String? returnDate,
    String? returnTime,

    // المشاعر المقدسة
    String? serviceCenterName,
    String? serviceCenterArafat,
    String? serviceCenterMina,
    String? busArafat,
    String? busMina,
    String? tentArafat,
    String? tentMina,

    // التواصل
    String? phoneNumber,
    String? whatsappNumber,
    String? syrianPhoneNumber,
    String? notes,
  }) = _Pilgrim;

  factory Pilgrim.fromJson(Map<String, dynamic> json) => _$PilgrimFromJson(json);
}

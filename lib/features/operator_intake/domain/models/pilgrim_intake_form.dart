import 'package:freezed_annotation/freezed_annotation.dart';

part 'pilgrim_intake_form.freezed.dart';

@freezed
abstract class PilgrimIntakeForm with _$PilgrimIntakeForm {
  const factory PilgrimIntakeForm({
    required String fullName,
    required String email,
    String? passportNumber,
    String? travelPermitNumber,
    String? medicalTestStatus,
    DateTime? travelDate,
    String? hotelName,
    String? hotelLocationUrl,
    String? transportationDetails,
  }) = _PilgrimIntakeForm;
}

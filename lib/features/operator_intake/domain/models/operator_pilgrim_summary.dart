/// Pilgrim row in the operator registry list (US-09).
class OperatorPilgrimSummary {
  const OperatorPilgrimSummary({
    required this.profileId,
    required this.fullName,
    this.passportNumber,
    this.travelPermitNumber,
    this.medicalTestStatus,
    this.travelDate,
    this.hotelName,
  });

  final String profileId;
  final String fullName;
  final String? passportNumber;
  final String? travelPermitNumber;
  final String? medicalTestStatus;
  final DateTime? travelDate;
  final String? hotelName;
}

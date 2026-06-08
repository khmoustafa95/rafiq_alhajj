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
    this.gender,
    this.groupId,
    this.groupName,
  });

  final String profileId;
  final String fullName;
  final String? passportNumber;
  final String? travelPermitNumber;
  final String? medicalTestStatus;
  final DateTime? travelDate;
  final String? hotelName;
  final String? gender;
  final String? groupId;
  final String? groupName;
}

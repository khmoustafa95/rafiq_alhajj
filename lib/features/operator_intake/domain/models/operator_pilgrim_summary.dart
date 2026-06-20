/// Pilgrim row in the operator registry list (US-09).
///
/// Keyed by [pilgrimId] (stable person identity). [profileId] is only present
/// when the pilgrim has an app login; [enrollmentId] points at the row for the
/// scoped trip.
class OperatorPilgrimSummary {
  const OperatorPilgrimSummary({
    required this.pilgrimId,
    required this.fullName,
    this.profileId,
    this.enrollmentId,
    this.passportNumber,
    this.travelPermitNumber,
    this.medicalTestStatus,
    this.travelDate,
    this.hotelName,
    this.gender,
    this.groupId,
    this.groupName,
  });

  final String pilgrimId;
  final String fullName;
  final String? profileId;
  final String? enrollmentId;
  final String? passportNumber;
  final String? travelPermitNumber;
  final String? medicalTestStatus;
  final DateTime? travelDate;
  final String? hotelName;
  final String? gender;
  final String? groupId;
  final String? groupName;
}

/// Full pilgrim logistics for operator desk view/edit (US-09).
///
/// Keyed by [pilgrimId] (stable person identity); [enrollmentId] is the trip
/// enrollment whose logistics are shown.
class OperatorPilgrimRecord {
  const OperatorPilgrimRecord({
    required this.pilgrimId,
    required this.fullName,
    this.profileId,
    this.enrollmentId,
    this.passportNumber,
    this.travelPermitNumber,
    this.medicalTestStatus,
    this.travelDate,
    this.hotelName,
    this.hotelLocationUrl,
    this.transportationDetails,
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
  final String? hotelLocationUrl;
  final String? transportationDetails;
  final String? gender;
  final String? groupId;
  final String? groupName;
}

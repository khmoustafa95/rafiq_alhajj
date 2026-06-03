/// Full pilgrim logistics for operator desk view/edit (US-09).
class OperatorPilgrimRecord {
  const OperatorPilgrimRecord({
    required this.profileId,
    required this.fullName,
    this.passportNumber,
    this.travelPermitNumber,
    this.medicalTestStatus,
    this.travelDate,
    this.hotelName,
    this.hotelLocationUrl,
    this.transportationDetails,
  });

  final String profileId;
  final String fullName;
  final String? passportNumber;
  final String? travelPermitNumber;
  final String? medicalTestStatus;
  final DateTime? travelDate;
  final String? hotelName;
  final String? hotelLocationUrl;
  final String? transportationDetails;
}

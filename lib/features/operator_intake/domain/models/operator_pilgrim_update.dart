/// Logistics fields an operator may update (not auth email / full name).
class OperatorPilgrimUpdate {
  const OperatorPilgrimUpdate({
    this.passportNumber,
    this.travelPermitNumber,
    this.medicalTestStatus,
    this.travelDate,
    this.hotelName,
    this.hotelLocationUrl,
    this.transportationDetails,
  });

  final String? passportNumber;
  final String? travelPermitNumber;
  final String? medicalTestStatus;
  final DateTime? travelDate;
  final String? hotelName;
  final String? hotelLocationUrl;
  final String? transportationDetails;

  Map<String, dynamic> toDatabasePayload() {
    return {
      'passport_number': _emptyToNull(passportNumber),
      'travel_permit_number': _emptyToNull(travelPermitNumber),
      'medical_test_status': _emptyToNull(medicalTestStatus),
      'travel_date': travelDate?.toIso8601String().split('T').first,
      'hotel_name': _emptyToNull(hotelName),
      'hotel_location_url': _emptyToNull(hotelLocationUrl),
      'transportation_details': _emptyToNull(transportationDetails),
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };
  }

  static String? _emptyToNull(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }
}

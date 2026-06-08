/// Logistics and profile fields staff may update for a pilgrim.
class OperatorPilgrimUpdate {
  const OperatorPilgrimUpdate({
    this.fullName,
    this.groupId,
    this.gender,
    this.passportNumber,
    this.travelPermitNumber,
    this.medicalTestStatus,
    this.travelDate,
    this.hotelName,
    this.hotelLocationUrl,
    this.transportationDetails,
  });

  final String? fullName;
  final String? groupId;
  final String? gender;
  final String? passportNumber;
  final String? travelPermitNumber;
  final String? medicalTestStatus;
  final DateTime? travelDate;
  final String? hotelName;
  final String? hotelLocationUrl;
  final String? transportationDetails;

  Map<String, dynamic> toDetailsPayload() {
    return {
      'passport_number': _emptyToNull(passportNumber),
      'travel_permit_number': _emptyToNull(travelPermitNumber),
      'medical_test_status': _emptyToNull(medicalTestStatus),
      'travel_date': travelDate?.toIso8601String().split('T').first,
      'hotel_name': _emptyToNull(hotelName),
      'hotel_location_url': _emptyToNull(hotelLocationUrl),
      'transportation_details': _emptyToNull(transportationDetails),
      'gender': _emptyToNull(gender),
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };
  }

  Map<String, dynamic> toProfilePayload() {
    return {
      if (fullName != null) 'full_name': fullName!.trim(),
      'group_id': groupId,
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

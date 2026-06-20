/// Logistics and identity fields staff may update for a pilgrim enrollment.
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

  /// Person identity fields stored on `pilgrims`.
  Map<String, dynamic> toPersonPayload() {
    return {
      'passport_number': _emptyToNull(passportNumber),
      'gender': _emptyToNull(gender),
      if (fullName != null) 'full_name_ar': fullName!.trim(),
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };
  }

  /// Trip-specific logistics stored on `trip_enrollments`.
  Map<String, dynamic> toEnrollmentPayload({bool includeGroup = false}) {
    return {
      'travel_permit_number': _emptyToNull(travelPermitNumber),
      'medical_test_status': _emptyToNull(medicalTestStatus),
      'travel_date': travelDate?.toIso8601String().split('T').first,
      'hotel_name': _emptyToNull(hotelName),
      'hotel_location_url': _emptyToNull(hotelLocationUrl),
      'transportation_details': _emptyToNull(transportationDetails),
      if (includeGroup) 'group_id': groupId,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };
  }

  /// Profile fields stored on `profiles` (only when the pilgrim has a login).
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

/// Pilgrim row in the operator registry list, backed by a raw
/// `pilgrim_enrollment_view` row.
///
/// Keyed by [pilgrimId] (stable person identity). [profileId] is only present
/// when the pilgrim has an app login; [enrollmentId] points at the row for the
/// scoped trip.
class OperatorPilgrimSummary {
  const OperatorPilgrimSummary(this.raw);

  final Map<String, dynamic> raw;

  String get pilgrimId => raw['pilgrim_id'] as String;
  String? get profileId => raw['profile_id'] as String?;
  String? get enrollmentId => raw['enrollment_id'] as String?;
  String get fullName => (raw['full_name'] as String?) ?? '';
  String? get passportNumber => raw['passport_number'] as String?;
  String? get travelPermitNumber => raw['travel_permit_number'] as String?;
  String? get medicalTestStatus => raw['medical_test_status'] as String?;
  String? get hotelName => raw['hotel_name'] as String?;
  String? get makkahHotel => raw['makkah_hotel'] as String?;
  String? get gender => raw['gender'] as String?;
  String? get groupId => raw['group_id'] as String?;
  String? get groupName => raw['group_name'] as String?;
  String? get cluster => raw['cluster'] as String?;
  String? get stickerNumber => raw['sticker_number'] as String?;
  String? get fieldStatus => raw['field_status'] as String?;
  String? get phoneNumber => raw['phone_number'] as String?;
  String? get whatsappNumber => raw['whatsapp_number'] as String?;

  DateTime? get travelDate {
    final value = raw['travel_date'];
    return value == null ? null : DateTime.tryParse(value.toString());
  }
}

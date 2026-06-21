/// Full pilgrim record for the operator/admin edit view, backed by a raw
/// `pilgrim_enrollment_view` row so the shared field catalog can bind every
/// column without an explicit field-by-field model.
class OperatorPilgrimRecord {
  const OperatorPilgrimRecord(this.raw);

  final Map<String, dynamic> raw;

  String get pilgrimId => raw['pilgrim_id'] as String;
  String? get profileId => raw['profile_id'] as String?;
  String? get enrollmentId => raw['enrollment_id'] as String?;
  String get fullName => (raw['full_name'] as String?) ?? '';
  String? get gender => raw['gender'] as String?;
  String? get groupId => raw['group_id'] as String?;
  String? get groupName => raw['group_name'] as String?;
  String? get whatsappNumber => raw['whatsapp_number'] as String?;
}

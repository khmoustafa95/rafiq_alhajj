/// Person + enrollment field maps staff may update for a pilgrim.
///
/// [person] holds `pilgrims` columns and [enrollment] holds `trip_enrollments`
/// columns (both built from the shared pilgrim field catalog). [groupId] is the
/// admin-assigned group propagated to the enrollment and the login profile.
class OperatorPilgrimUpdate {
  const OperatorPilgrimUpdate({
    this.person = const {},
    this.enrollment = const {},
    this.groupId,
  });

  final Map<String, dynamic> person;
  final Map<String, dynamic> enrollment;
  final String? groupId;

  /// Person identity fields stored on `pilgrims`.
  Map<String, dynamic> toPersonPayload() {
    return {
      ...person,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };
  }

  /// Trip-specific logistics stored on `trip_enrollments`.
  Map<String, dynamic> toEnrollmentPayload({bool includeGroup = false}) {
    return {
      ...enrollment,
      if (includeGroup) 'group_id': groupId,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };
  }

  /// Profile fields stored on `profiles` (only when the pilgrim has a login).
  Map<String, dynamic> toProfilePayload() {
    final fullName = (person['full_name_ar'] as String?)?.trim();
    return {
      if (fullName != null && fullName.isNotEmpty) 'full_name': fullName,
      'group_id': groupId,
    };
  }
}

/// A travel office (`groups` row) participating in a trip via `trip_groups`.
class TripOffice {
  const TripOffice({
    required this.tripGroupId,
    required this.tripId,
    required this.groupId,
    required this.groupName,
    this.status = 'active',
    this.presidentName,
    this.joinedAt,
    this.withdrawnAt,
  });

  /// `trip_groups.id` (the participation row).
  final String tripGroupId;
  final String tripId;
  final String groupId;
  final String groupName;

  /// `active` or `withdrawn`.
  final String status;
  final String? presidentName;
  final DateTime? joinedAt;
  final DateTime? withdrawnAt;

  bool get isActive => status == 'active';
}

/// A lightweight office option used when adding a group to a trip.
class TripGroupOption {
  const TripGroupOption({required this.id, required this.name});

  final String id;
  final String name;
}

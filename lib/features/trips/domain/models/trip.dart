/// A seasonal journey (Hajj or Umrah) for a specific year.
///
/// Travel offices (`groups`) join a trip via `trip_groups`, and pilgrims are
/// enrolled in a trip via `trip_enrollments`. A pilgrim can take part in more
/// than one trip across seasons.
class Trip {
  const Trip({
    required this.id,
    required this.type,
    required this.seasonYear,
    required this.name,
    this.status = 'planning',
    this.startDate,
    this.endDate,
    this.officeCount = 0,
    this.pilgrimCount = 0,
    this.createdAt,
    this.updatedAt,
  });

  final String id;

  /// `hajj` or `umrah`.
  final String type;
  final int seasonYear;
  final String name;

  /// `planning`, `active`, `completed`, or `cancelled`.
  final String status;
  final DateTime? startDate;
  final DateTime? endDate;
  final int officeCount;
  final int pilgrimCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  bool get isHajj => type == 'hajj';
  bool get isUmrah => type == 'umrah';
}

/// Input payload for creating or updating a [Trip].
class TripEditorInput {
  const TripEditorInput({
    this.id,
    required this.type,
    required this.seasonYear,
    required this.name,
    required this.status,
    this.startDate,
    this.endDate,
  });

  /// Null when creating a new trip.
  final String? id;
  final String type;
  final int seasonYear;
  final String name;
  final String status;
  final DateTime? startDate;
  final DateTime? endDate;
}

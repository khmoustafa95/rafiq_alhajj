/// Stored in [pilgrim_details.field_status].
abstract final class FieldPilgrimStatus {
  static const pending = 'pending';
  static const medicalDone = 'medical_done';
  static const arrivedHotel = 'arrived_hotel';
  static const inTransit = 'in_transit';
  static const completed = 'completed';

  static const values = [
    pending,
    medicalDone,
    arrivedHotel,
    inTransit,
    completed,
  ];
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'pilgrim_intake_form.freezed.dart';

/// Payload for registering a new pilgrim.
///
/// [person] holds `pilgrims` columns and [enrollment] holds `trip_enrollments`
/// columns (both built from the shared pilgrim field catalog). [fullName] and
/// [email] drive the auth account; [tripId]/[groupId] scope the enrollment.
@freezed
abstract class PilgrimIntakeForm with _$PilgrimIntakeForm {
  const factory PilgrimIntakeForm({
    required String fullName,
    required String email,
    String? tripId,
    String? groupId,
    @Default(<String, dynamic>{}) Map<String, dynamic> person,
    @Default(<String, dynamic>{}) Map<String, dynamic> enrollment,
  }) = _PilgrimIntakeForm;
}

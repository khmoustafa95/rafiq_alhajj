import 'package:freezed_annotation/freezed_annotation.dart';

part 'sos_alert.freezed.dart';

enum SosStatus {
  active,
  resolved,
  cancelled;

  static SosStatus fromName(String? value) {
    return SosStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => SosStatus.active,
    );
  }
}

@freezed
abstract class SosAlert with _$SosAlert {
  const factory SosAlert({
    required String id,
    required String pilgrimProfileId,
    String? pilgrimName,
    String? groupId,
    String? groupName,
    @Default(SosStatus.active) SosStatus status,
    double? latitude,
    double? longitude,
    double? accuracy,
    String? note,
    required DateTime startedAt,
    DateTime? lastLocationAt,
  }) = _SosAlert;

  const SosAlert._();

  bool get hasLocation => latitude != null && longitude != null;
}

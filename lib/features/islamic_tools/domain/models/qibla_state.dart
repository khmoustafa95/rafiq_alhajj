import 'package:freezed_annotation/freezed_annotation.dart';

part 'qibla_state.freezed.dart';

@freezed
abstract class QiblaState with _$QiblaState {
  const factory QiblaState({
    required double qiblaBearing,
    required double? compassHeading,
    required double latitude,
    required double longitude,
    required bool fromCachedLocation,
  }) = _QiblaState;

  const QiblaState._();

  /// Degrees to rotate the Qibla indicator (0 = pointing up).
  double? get indicatorRotation {
    final heading = compassHeading;
    if (heading == null) {
      return null;
    }
    return (qiblaBearing - heading + 360) % 360;
  }
}

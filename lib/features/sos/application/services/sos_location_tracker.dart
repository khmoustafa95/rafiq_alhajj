import 'package:geolocator/geolocator.dart';

/// Throttles SOS foreground location pings to balance map freshness and battery.
abstract final class SosLocationTracker {
  /// Minimum time between server pings unless the pilgrim moved materially.
  static const minPingInterval = Duration(seconds: 30);

  /// When speed is below this threshold (m/s), use a wider distance filter.
  static const stationarySpeedThreshold = 0.5;

  static const movingDistanceFilter = 5;
  static const stationaryDistanceFilter = 20;

  /// Minimum movement (meters) since the last pushed ping to bypass the interval.
  static const minMovementMeters = 15;

  static int distanceFilterFor(Position position) {
    final speed = position.speed;
    if (speed.isFinite && speed.abs() < stationarySpeedThreshold) {
      return stationaryDistanceFilter;
    }
    return movingDistanceFilter;
  }

  static bool shouldPushPing({
    required Position position,
    required DateTime? lastPingAt,
    required Position? lastPingPosition,
  }) {
    if (lastPingAt == null || lastPingPosition == null) {
      return true;
    }

    final elapsed = DateTime.now().difference(lastPingAt);
    if (elapsed >= minPingInterval) {
      return true;
    }

    final moved = Geolocator.distanceBetween(
      lastPingPosition.latitude,
      lastPingPosition.longitude,
      position.latitude,
      position.longitude,
    );
    return moved >= minMovementMeters;
  }
}

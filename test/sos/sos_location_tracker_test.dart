import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rafiq_alhajj/features/sos/application/services/sos_location_tracker.dart';

Position _position({
  double speed = 0,
  double latitude = 21.4,
  double longitude = 39.8,
}) {
  return Position(
    latitude: latitude,
    longitude: longitude,
    timestamp: DateTime.now(),
    accuracy: 5,
    altitude: 0,
    altitudeAccuracy: 0,
    heading: 0,
    headingAccuracy: 0,
    speed: speed,
    speedAccuracy: 0,
  );
}

void main() {
  group('SosLocationTracker', () {
    test('uses wider distance filter when stationary', () {
      expect(
        SosLocationTracker.distanceFilterFor(_position(speed: 0)),
        SosLocationTracker.stationaryDistanceFilter,
      );
      expect(
        SosLocationTracker.distanceFilterFor(_position(speed: 2)),
        SosLocationTracker.movingDistanceFilter,
      );
    });

    test('allows first ping immediately', () {
      expect(
        SosLocationTracker.shouldPushPing(
          position: _position(),
          lastPingAt: null,
          lastPingPosition: null,
        ),
        isTrue,
      );
    });

    test('throttles pings inside the minimum interval', () {
      final now = DateTime.now();
      expect(
        SosLocationTracker.shouldPushPing(
          position: _position(),
          lastPingAt: now.subtract(const Duration(seconds: 10)),
          lastPingPosition: _position(),
        ),
        isFalse,
      );
    });

    test('allows ping after interval elapsed', () {
      final now = DateTime.now();
      expect(
        SosLocationTracker.shouldPushPing(
          position: _position(),
          lastPingAt: now.subtract(const Duration(seconds: 31)),
          lastPingPosition: _position(),
        ),
        isTrue,
      );
    });

    test('bypasses interval when pilgrim moved materially', () {
      final now = DateTime.now();
      expect(
        SosLocationTracker.shouldPushPing(
          position: _position(latitude: 21.5),
          lastPingAt: now.subtract(const Duration(seconds: 10)),
          lastPingPosition: _position(latitude: 21.4),
        ),
        isTrue,
      );
    });
  });
}

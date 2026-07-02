import 'package:geolocator/geolocator.dart';
import 'package:rafiq_alhajj/features/islamic_tools/data/location/location_cache.dart';
import 'package:rafiq_alhajj/features/islamic_tools/domain/models/geo_location.dart';

enum LocationFailure {
  serviceDisabled,
  permissionDenied,
  permissionDeniedForever,
  unavailable,
}

class LocationException implements Exception {
  const LocationException(this.failure);

  final LocationFailure failure;
}

class LocationRepository {
  Future<GeoLocation> resolveLocation({required bool preferGps}) async {
    if (preferGps) {
      try {
        final gps = await _readGps();
        await LocationCache.write(gps);
        return gps;
      } on LocationException {
        final cached = await LocationCache.read();
        if (cached != null) {
          return cached;
        }
        rethrow;
      }
    }

    final cached = await LocationCache.read();
    if (cached != null) {
      return cached;
    }

    final gps = await _readGps();
    await LocationCache.write(gps);
    return gps;
  }

  /// Returns whether location permission is granted for foreground tracking.
  Future<bool> ensureTrackingPermission({bool requestIfDenied = true}) async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return false;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied && requestIfDenied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// One-shot GPS read for SOS raise; returns null when unavailable.
  Future<Position?> readCurrentPositionOrNull() async {
    try {
      if (!await ensureTrackingPermission()) {
        return null;
      }
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
    } catch (_) {
      return null;
    }
  }

  Stream<Position> watchPosition({
    int distanceFilter = 5,
    LocationAccuracy accuracy = LocationAccuracy.high,
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter,
      ),
    );
  }

  Future<GeoLocation> _readGps() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationException(LocationFailure.serviceDisabled);
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw const LocationException(LocationFailure.permissionDenied);
    }
    if (permission == LocationPermission.deniedForever) {
      throw const LocationException(LocationFailure.permissionDeniedForever);
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 15),
      ),
    );

    return GeoLocation(
      latitude: position.latitude,
      longitude: position.longitude,
      capturedAt: DateTime.now(),
      fromCache: false,
    );
  }
}

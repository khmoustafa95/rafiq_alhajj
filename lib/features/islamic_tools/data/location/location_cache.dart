import 'package:rafiq_alhajj/features/islamic_tools/domain/models/geo_location.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class LocationCache {
  static const _latKey = 'geo_lat';
  static const _lngKey = 'geo_lng';
  static const _capturedKey = 'geo_captured_at';

  static Future<GeoLocation?> read() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble(_latKey);
    final lng = prefs.getDouble(_lngKey);
    final capturedMs = prefs.getInt(_capturedKey);

    if (lat == null || lng == null || capturedMs == null) {
      return null;
    }

    return GeoLocation(
      latitude: lat,
      longitude: lng,
      capturedAt: DateTime.fromMillisecondsSinceEpoch(capturedMs),
      fromCache: true,
    );
  }

  static Future<void> write(GeoLocation location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_latKey, location.latitude);
    await prefs.setDouble(_lngKey, location.longitude);
    await prefs.setInt(_capturedKey, location.capturedAt.millisecondsSinceEpoch);
  }
}

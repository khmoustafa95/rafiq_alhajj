import 'package:adhan/adhan.dart';
import 'package:rafiq_alhajj/features/islamic_tools/domain/models/geo_location.dart';
import 'package:rafiq_alhajj/features/islamic_tools/domain/models/qibla_state.dart';

class QiblaRepository {
  QiblaState buildState({
    required GeoLocation location,
    required double? compassHeading,
  }) {
    final qibla = Qibla(Coordinates(location.latitude, location.longitude));

    return QiblaState(
      qiblaBearing: qibla.direction,
      compassHeading: compassHeading,
      latitude: location.latitude,
      longitude: location.longitude,
      fromCachedLocation: location.fromCache,
    );
  }
}

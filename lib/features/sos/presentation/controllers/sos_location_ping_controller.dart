import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rafiq_alhajj/features/islamic_tools/presentation/providers/location_providers.dart';
import 'package:rafiq_alhajj/features/sos/application/services/sos_location_tracker.dart';
import 'package:rafiq_alhajj/features/sos/presentation/providers/sos_providers.dart';

/// Foreground-only SOS location ping loop with adaptive distance filter.
class SosLocationPingController {
  SosLocationPingController(this._ref);

  final WidgetRef _ref;
  StreamSubscription<Position>? _positionSub;
  String? _trackingAlertId;
  DateTime? _lastPingAt;
  Position? _lastPingPosition;
  int _activeDistanceFilter = SosLocationTracker.movingDistanceFilter;

  void start(String alertId) {
    if (_trackingAlertId == alertId && _positionSub != null) {
      return;
    }
    stop();
    _trackingAlertId = alertId;
    _lastPingAt = null;
    _lastPingPosition = null;
    _activeDistanceFilter = SosLocationTracker.movingDistanceFilter;
    _subscribe(alertId);
  }

  void _subscribe(String alertId) {
    _positionSub = _ref
        .read(locationRepositoryProvider)
        .watchPosition(distanceFilter: _activeDistanceFilter)
        .listen(
      (position) {
        final nextFilter = SosLocationTracker.distanceFilterFor(position);
        if (nextFilter != _activeDistanceFilter) {
          _activeDistanceFilter = nextFilter;
          unawaited(_positionSub?.cancel());
          _subscribe(alertId);
          return;
        }

        if (!SosLocationTracker.shouldPushPing(
          position: position,
          lastPingAt: _lastPingAt,
          lastPingPosition: _lastPingPosition,
        )) {
          return;
        }

        _lastPingAt = DateTime.now();
        _lastPingPosition = position;
        unawaited(
          _ref
              .read(sosServiceProvider)
              .pushLocation(
                alertId: alertId,
                latitude: position.latitude,
                longitude: position.longitude,
                accuracy: position.accuracy,
              )
              .catchError((_) {}),
        );
      },
      onError: (_) {},
    );
  }

  void stop() {
    unawaited(_positionSub?.cancel());
    _positionSub = null;
    _trackingAlertId = null;
    _lastPingAt = null;
    _lastPingPosition = null;
  }

  void dispose() {
    stop();
  }
}

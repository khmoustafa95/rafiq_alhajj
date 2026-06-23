import 'package:rafiq_alhajj/features/sos/presentation/providers/sos_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sos_controller.g.dart';

/// Raises / cancels the current pilgrim's SOS alert.
@riverpod
class SosRaise extends _$SosRaise {
  @override
  FutureOr<void> build() {}

  /// Returns the new alert id, or null on failure.
  Future<String?> raise({
    double? latitude,
    double? longitude,
    double? accuracy,
  }) async {
    state = const AsyncLoading();
    try {
      final id = await ref.read(sosServiceProvider).raiseAlert(
            latitude: latitude,
            longitude: longitude,
            accuracy: accuracy,
          );
      ref.invalidate(mySosAlertProvider);
      ref.invalidate(activeSosAlertsProvider);
      state = const AsyncData(null);
      return id;
    } catch (error, stackTrace) {
      state = AsyncError<void>(error, stackTrace);
      return null;
    }
  }

  Future<bool> cancel(String alertId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(sosServiceProvider).cancelByPilgrim(alertId);
      ref.invalidate(mySosAlertProvider);
      ref.invalidate(activeSosAlertsProvider);
    });
    return !state.hasError;
  }
}

/// Staff action: resolve an alert.
@riverpod
class SosResolve extends _$SosResolve {
  @override
  FutureOr<void> build() {}

  Future<bool> resolve(String alertId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(sosServiceProvider).resolveByStaff(alertId);
      ref.invalidate(activeSosAlertsProvider);
    });
    return !state.hasError;
  }
}

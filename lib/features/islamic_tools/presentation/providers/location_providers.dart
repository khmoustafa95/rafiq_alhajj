import 'package:rafiq_alhajj/features/islamic_tools/data/location/location_repository.dart';
import 'package:rafiq_alhajj/features/islamic_tools/domain/models/geo_location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_providers.g.dart';

@Riverpod(keepAlive: true)
LocationRepository locationRepository(Ref ref) => LocationRepository();

@riverpod
class DeviceLocation extends _$DeviceLocation {
  @override
  Future<GeoLocation> build() async {
    return ref.read(locationRepositoryProvider).resolveLocation(preferGps: true);
  }

  Future<void> refreshFromGps() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref
          .read(locationRepositoryProvider)
          .resolveLocation(preferGps: true);
    });
  }
}

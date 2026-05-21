// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(locationRepository)
final locationRepositoryProvider = LocationRepositoryProvider._();

final class LocationRepositoryProvider
    extends
        $FunctionalProvider<
          LocationRepository,
          LocationRepository,
          LocationRepository
        >
    with $Provider<LocationRepository> {
  LocationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationRepositoryHash();

  @$internal
  @override
  $ProviderElement<LocationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocationRepository create(Ref ref) {
    return locationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationRepository>(value),
    );
  }
}

String _$locationRepositoryHash() =>
    r'701f763eb006e149a46b998407de5207b9fe84a9';

@ProviderFor(DeviceLocation)
final deviceLocationProvider = DeviceLocationProvider._();

final class DeviceLocationProvider
    extends $AsyncNotifierProvider<DeviceLocation, GeoLocation> {
  DeviceLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceLocationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceLocationHash();

  @$internal
  @override
  DeviceLocation create() => DeviceLocation();
}

String _$deviceLocationHash() => r'967b69dc80c03f7e4559e94e8032fe56ca303ac8';

abstract class _$DeviceLocation extends $AsyncNotifier<GeoLocation> {
  FutureOr<GeoLocation> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<GeoLocation>, GeoLocation>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<GeoLocation>, GeoLocation>,
              AsyncValue<GeoLocation>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trips_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tripsService)
final tripsServiceProvider = TripsServiceProvider._();

final class TripsServiceProvider
    extends $FunctionalProvider<TripsService, TripsService, TripsService>
    with $Provider<TripsService> {
  TripsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tripsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tripsServiceHash();

  @$internal
  @override
  $ProviderElement<TripsService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TripsService create(Ref ref) {
    return tripsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TripsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TripsService>(value),
    );
  }
}

String _$tripsServiceHash() => r'3526102b3456969391b5bbd966afd9e688fdeef5';

@ProviderFor(tripsRepository)
final tripsRepositoryProvider = TripsRepositoryProvider._();

final class TripsRepositoryProvider
    extends
        $FunctionalProvider<TripsRepository, TripsRepository, TripsRepository>
    with $Provider<TripsRepository> {
  TripsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tripsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tripsRepositoryHash();

  @$internal
  @override
  $ProviderElement<TripsRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TripsRepository create(Ref ref) {
    return tripsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TripsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TripsRepository>(value),
    );
  }
}

String _$tripsRepositoryHash() => r'2dd4d90b6a6157948d915f868cca5481787281cc';

@ProviderFor(tripsList)
final tripsListProvider = TripsListProvider._();

final class TripsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Trip>>,
          List<Trip>,
          FutureOr<List<Trip>>
        >
    with $FutureModifier<List<Trip>>, $FutureProvider<List<Trip>> {
  TripsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tripsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tripsListHash();

  @$internal
  @override
  $FutureProviderElement<List<Trip>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Trip>> create(Ref ref) {
    return tripsList(ref);
  }
}

String _$tripsListHash() => r'cafe492c27b26c70270215944598e201b5807141';

@ProviderFor(tripDetail)
final tripDetailProvider = TripDetailFamily._();

final class TripDetailProvider
    extends $FunctionalProvider<AsyncValue<Trip>, Trip, FutureOr<Trip>>
    with $FutureModifier<Trip>, $FutureProvider<Trip> {
  TripDetailProvider._({
    required TripDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tripDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tripDetailHash();

  @override
  String toString() {
    return r'tripDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Trip> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Trip> create(Ref ref) {
    final argument = this.argument as String;
    return tripDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TripDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tripDetailHash() => r'cad910ede3138981050d155405a794e24ab8d9b2';

final class TripDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Trip>, String> {
  TripDetailFamily._()
    : super(
        retry: null,
        name: r'tripDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TripDetailProvider call(String id) =>
      TripDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'tripDetailProvider';
}

@ProviderFor(tripOffices)
final tripOfficesProvider = TripOfficesFamily._();

final class TripOfficesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TripOffice>>,
          List<TripOffice>,
          FutureOr<List<TripOffice>>
        >
    with $FutureModifier<List<TripOffice>>, $FutureProvider<List<TripOffice>> {
  TripOfficesProvider._({
    required TripOfficesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tripOfficesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tripOfficesHash();

  @override
  String toString() {
    return r'tripOfficesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TripOffice>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TripOffice>> create(Ref ref) {
    final argument = this.argument as String;
    return tripOffices(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TripOfficesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tripOfficesHash() => r'b4aa28636b17ef9fcd61a2189c2dd464a89e7e69';

final class TripOfficesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TripOffice>>, String> {
  TripOfficesFamily._()
    : super(
        retry: null,
        name: r'tripOfficesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TripOfficesProvider call(String tripId) =>
      TripOfficesProvider._(argument: tripId, from: this);

  @override
  String toString() => r'tripOfficesProvider';
}

@ProviderFor(tripAvailableGroups)
final tripAvailableGroupsProvider = TripAvailableGroupsFamily._();

final class TripAvailableGroupsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TripGroupOption>>,
          List<TripGroupOption>,
          FutureOr<List<TripGroupOption>>
        >
    with
        $FutureModifier<List<TripGroupOption>>,
        $FutureProvider<List<TripGroupOption>> {
  TripAvailableGroupsProvider._({
    required TripAvailableGroupsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tripAvailableGroupsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tripAvailableGroupsHash();

  @override
  String toString() {
    return r'tripAvailableGroupsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TripGroupOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TripGroupOption>> create(Ref ref) {
    final argument = this.argument as String;
    return tripAvailableGroups(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TripAvailableGroupsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tripAvailableGroupsHash() =>
    r'5d352091f4b14ed8658933d344119823fc5ead62';

final class TripAvailableGroupsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TripGroupOption>>, String> {
  TripAvailableGroupsFamily._()
    : super(
        retry: null,
        name: r'tripAvailableGroupsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TripAvailableGroupsProvider call(String tripId) =>
      TripAvailableGroupsProvider._(argument: tripId, from: this);

  @override
  String toString() => r'tripAvailableGroupsProvider';
}

/// Currently selected trip id used to scope pilgrim reads. Null = all trips.

@ProviderFor(ActiveTrip)
final activeTripProvider = ActiveTripProvider._();

/// Currently selected trip id used to scope pilgrim reads. Null = all trips.
final class ActiveTripProvider
    extends $AsyncNotifierProvider<ActiveTrip, String?> {
  /// Currently selected trip id used to scope pilgrim reads. Null = all trips.
  ActiveTripProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeTripProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeTripHash();

  @$internal
  @override
  ActiveTrip create() => ActiveTrip();
}

String _$activeTripHash() => r'b444837020b16c63010de4a8830895603f18e37a';

/// Currently selected trip id used to scope pilgrim reads. Null = all trips.

abstract class _$ActiveTrip extends $AsyncNotifier<String?> {
  FutureOr<String?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String?>, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String?>, String?>,
              AsyncValue<String?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(TripSave)
final tripSaveProvider = TripSaveProvider._();

final class TripSaveProvider extends $AsyncNotifierProvider<TripSave, void> {
  TripSaveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tripSaveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tripSaveHash();

  @$internal
  @override
  TripSave create() => TripSave();
}

String _$tripSaveHash() => r'4108a3895b0dbb709501151f695370e18dd9bbe1';

abstract class _$TripSave extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(TripDelete)
final tripDeleteProvider = TripDeleteProvider._();

final class TripDeleteProvider
    extends $AsyncNotifierProvider<TripDelete, void> {
  TripDeleteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tripDeleteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tripDeleteHash();

  @$internal
  @override
  TripDelete create() => TripDelete();
}

String _$tripDeleteHash() => r'fc3dde0e2a3f46eb358460704324fa5504c2fa77';

abstract class _$TripDelete extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(TripOfficeMutation)
final tripOfficeMutationProvider = TripOfficeMutationProvider._();

final class TripOfficeMutationProvider
    extends $AsyncNotifierProvider<TripOfficeMutation, void> {
  TripOfficeMutationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tripOfficeMutationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tripOfficeMutationHash();

  @$internal
  @override
  TripOfficeMutation create() => TripOfficeMutation();
}

String _$tripOfficeMutationHash() =>
    r'30becb70a6151ce0f80526b1db28871e550df4e4';

abstract class _$TripOfficeMutation extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

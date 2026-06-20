// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trips_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$tripsListHash() => r'b0e5312abd5b45babc3a144f87ee9a1b31c8de8f';

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

String _$tripDetailHash() => r'5722f50e47f3502a1e195376aa4eb13bf8128cfe';

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

String _$tripOfficesHash() => r'48196806d25cdc6af1dadf21b4be650fef339acd';

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
    r'7a198aa11888bb68690b9b8661a7caba3f98c76a';

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

String _$activeTripHash() => r'2f2e34f2a01689ce34da25e62e2c3552af43bd6f';

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

String _$tripSaveHash() => r'dd393cbb728ad835c1214ae68b30a294558ee3e4';

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

String _$tripDeleteHash() => r'cd4d13a4fddecbe4442f91c5837bdb4d91e37147';

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
    r'09b214b44efd562e832cfa3a287b4230e8a12f69';

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

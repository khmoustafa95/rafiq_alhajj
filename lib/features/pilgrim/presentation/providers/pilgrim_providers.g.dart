// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pilgrim_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pilgrimRemoteRepository)
final pilgrimRemoteRepositoryProvider = PilgrimRemoteRepositoryProvider._();

final class PilgrimRemoteRepositoryProvider
    extends
        $FunctionalProvider<
          PilgrimRemoteRepository,
          PilgrimRemoteRepository,
          PilgrimRemoteRepository
        >
    with $Provider<PilgrimRemoteRepository> {
  PilgrimRemoteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pilgrimRemoteRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pilgrimRemoteRepositoryHash();

  @$internal
  @override
  $ProviderElement<PilgrimRemoteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PilgrimRemoteRepository create(Ref ref) {
    return pilgrimRemoteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PilgrimRemoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PilgrimRemoteRepository>(value),
    );
  }
}

String _$pilgrimRemoteRepositoryHash() =>
    r'224a4d47d82c048d02c7f12e2fcc3fe2499ee1e3';

@ProviderFor(pilgrimRegistryRepository)
final pilgrimRegistryRepositoryProvider = PilgrimRegistryRepositoryProvider._();

final class PilgrimRegistryRepositoryProvider
    extends
        $FunctionalProvider<
          PilgrimRegistryRepository,
          PilgrimRegistryRepository,
          PilgrimRegistryRepository
        >
    with $Provider<PilgrimRegistryRepository> {
  PilgrimRegistryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pilgrimRegistryRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pilgrimRegistryRepositoryHash();

  @$internal
  @override
  $ProviderElement<PilgrimRegistryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PilgrimRegistryRepository create(Ref ref) {
    return pilgrimRegistryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PilgrimRegistryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PilgrimRegistryRepository>(value),
    );
  }
}

String _$pilgrimRegistryRepositoryHash() =>
    r'0e52bca9ea6be746061e04032d7cea0c9af54f9a';

@ProviderFor(pilgrimDashboardService)
final pilgrimDashboardServiceProvider = PilgrimDashboardServiceProvider._();

final class PilgrimDashboardServiceProvider
    extends
        $FunctionalProvider<
          PilgrimDashboardService,
          PilgrimDashboardService,
          PilgrimDashboardService
        >
    with $Provider<PilgrimDashboardService> {
  PilgrimDashboardServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pilgrimDashboardServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pilgrimDashboardServiceHash();

  @$internal
  @override
  $ProviderElement<PilgrimDashboardService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PilgrimDashboardService create(Ref ref) {
    return pilgrimDashboardService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PilgrimDashboardService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PilgrimDashboardService>(value),
    );
  }
}

String _$pilgrimDashboardServiceHash() =>
    r'bb357aa676ab4fa81ba759a8db7cdb2564f241a1';

@ProviderFor(pilgrimUserId)
final pilgrimUserIdProvider = PilgrimUserIdProvider._();

final class PilgrimUserIdProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  PilgrimUserIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pilgrimUserIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pilgrimUserIdHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return pilgrimUserId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$pilgrimUserIdHash() => r'ee0abd31bcf582155450881d51cdabbc7059d06d';

@ProviderFor(PilgrimDashboardState)
final pilgrimDashboardStateProvider = PilgrimDashboardStateProvider._();

final class PilgrimDashboardStateProvider
    extends $AsyncNotifierProvider<PilgrimDashboardState, PilgrimDashboard> {
  PilgrimDashboardStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pilgrimDashboardStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pilgrimDashboardStateHash();

  @$internal
  @override
  PilgrimDashboardState create() => PilgrimDashboardState();
}

String _$pilgrimDashboardStateHash() =>
    r'c5c7b037a0646cbac514cd88ba2fa1c7bac2d5a7';

abstract class _$PilgrimDashboardState
    extends $AsyncNotifier<PilgrimDashboard> {
  FutureOr<PilgrimDashboard> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<PilgrimDashboard>, PilgrimDashboard>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PilgrimDashboard>, PilgrimDashboard>,
              AsyncValue<PilgrimDashboard>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operator_registry_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(operatorRegistryRepository)
final operatorRegistryRepositoryProvider =
    OperatorRegistryRepositoryProvider._();

final class OperatorRegistryRepositoryProvider
    extends
        $FunctionalProvider<
          OperatorRegistryRepository,
          OperatorRegistryRepository,
          OperatorRegistryRepository
        >
    with $Provider<OperatorRegistryRepository> {
  OperatorRegistryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'operatorRegistryRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$operatorRegistryRepositoryHash();

  @$internal
  @override
  $ProviderElement<OperatorRegistryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OperatorRegistryRepository create(Ref ref) {
    return operatorRegistryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OperatorRegistryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OperatorRegistryRepository>(value),
    );
  }
}

String _$operatorRegistryRepositoryHash() =>
    r'620d635995ef9e79bf097353b9fc96099d4f5e0f';

@ProviderFor(operatorRegistryService)
final operatorRegistryServiceProvider = OperatorRegistryServiceProvider._();

final class OperatorRegistryServiceProvider
    extends
        $FunctionalProvider<
          OperatorRegistryService,
          OperatorRegistryService,
          OperatorRegistryService
        >
    with $Provider<OperatorRegistryService> {
  OperatorRegistryServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'operatorRegistryServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$operatorRegistryServiceHash();

  @$internal
  @override
  $ProviderElement<OperatorRegistryService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OperatorRegistryService create(Ref ref) {
    return operatorRegistryService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OperatorRegistryService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OperatorRegistryService>(value),
    );
  }
}

String _$operatorRegistryServiceHash() =>
    r'ca271565c452da087ea3a3a3482a8e595a90359a';

@ProviderFor(OperatorPilgrimRegistry)
final operatorPilgrimRegistryProvider = OperatorPilgrimRegistryProvider._();

final class OperatorPilgrimRegistryProvider
    extends
        $AsyncNotifierProvider<
          OperatorPilgrimRegistry,
          List<OperatorPilgrimSummary>
        > {
  OperatorPilgrimRegistryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'operatorPilgrimRegistryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$operatorPilgrimRegistryHash();

  @$internal
  @override
  OperatorPilgrimRegistry create() => OperatorPilgrimRegistry();
}

String _$operatorPilgrimRegistryHash() =>
    r'663d6668078ffc40b56e3c7b8a653e11e9731da5';

abstract class _$OperatorPilgrimRegistry
    extends $AsyncNotifier<List<OperatorPilgrimSummary>> {
  FutureOr<List<OperatorPilgrimSummary>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<OperatorPilgrimSummary>>,
              List<OperatorPilgrimSummary>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<OperatorPilgrimSummary>>,
                List<OperatorPilgrimSummary>
              >,
              AsyncValue<List<OperatorPilgrimSummary>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(OperatorPilgrimDetail)
final operatorPilgrimDetailProvider = OperatorPilgrimDetailFamily._();

final class OperatorPilgrimDetailProvider
    extends
        $AsyncNotifierProvider<OperatorPilgrimDetail, OperatorPilgrimRecord?> {
  OperatorPilgrimDetailProvider._({
    required OperatorPilgrimDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'operatorPilgrimDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$operatorPilgrimDetailHash();

  @override
  String toString() {
    return r'operatorPilgrimDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  OperatorPilgrimDetail create() => OperatorPilgrimDetail();

  @override
  bool operator ==(Object other) {
    return other is OperatorPilgrimDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$operatorPilgrimDetailHash() =>
    r'8c4bdb4825f32d9d131458b86dca974fcf2949ea';

final class OperatorPilgrimDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          OperatorPilgrimDetail,
          AsyncValue<OperatorPilgrimRecord?>,
          OperatorPilgrimRecord?,
          FutureOr<OperatorPilgrimRecord?>,
          String
        > {
  OperatorPilgrimDetailFamily._()
    : super(
        retry: null,
        name: r'operatorPilgrimDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OperatorPilgrimDetailProvider call(String profileId) =>
      OperatorPilgrimDetailProvider._(argument: profileId, from: this);

  @override
  String toString() => r'operatorPilgrimDetailProvider';
}

abstract class _$OperatorPilgrimDetail
    extends $AsyncNotifier<OperatorPilgrimRecord?> {
  late final _$args = ref.$arg as String;
  String get profileId => _$args;

  FutureOr<OperatorPilgrimRecord?> build(String profileId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<OperatorPilgrimRecord?>, OperatorPilgrimRecord?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<OperatorPilgrimRecord?>,
                OperatorPilgrimRecord?
              >,
              AsyncValue<OperatorPilgrimRecord?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

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

@ProviderFor(pilgrimGroupFilterOptions)
final pilgrimGroupFilterOptionsProvider = PilgrimGroupFilterOptionsProvider._();

final class PilgrimGroupFilterOptionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PilgrimGroupOption>>,
          List<PilgrimGroupOption>,
          FutureOr<List<PilgrimGroupOption>>
        >
    with
        $FutureModifier<List<PilgrimGroupOption>>,
        $FutureProvider<List<PilgrimGroupOption>> {
  PilgrimGroupFilterOptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pilgrimGroupFilterOptionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pilgrimGroupFilterOptionsHash();

  @$internal
  @override
  $FutureProviderElement<List<PilgrimGroupOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PilgrimGroupOption>> create(Ref ref) {
    return pilgrimGroupFilterOptions(ref);
  }
}

String _$pilgrimGroupFilterOptionsHash() =>
    r'e20c8f0e570d6e6878608325e8e746e4c9a78137';

@ProviderFor(operatorPilgrimRegistryPage)
final operatorPilgrimRegistryPageProvider =
    OperatorPilgrimRegistryPageFamily._();

final class OperatorPilgrimRegistryPageProvider
    extends
        $FunctionalProvider<
          AsyncValue<PaginatedResult<OperatorPilgrimSummary>>,
          PaginatedResult<OperatorPilgrimSummary>,
          FutureOr<PaginatedResult<OperatorPilgrimSummary>>
        >
    with
        $FutureModifier<PaginatedResult<OperatorPilgrimSummary>>,
        $FutureProvider<PaginatedResult<OperatorPilgrimSummary>> {
  OperatorPilgrimRegistryPageProvider._({
    required OperatorPilgrimRegistryPageFamily super.from,
    required StaffTableQuery super.argument,
  }) : super(
         retry: null,
         name: r'operatorPilgrimRegistryPageProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$operatorPilgrimRegistryPageHash();

  @override
  String toString() {
    return r'operatorPilgrimRegistryPageProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PaginatedResult<OperatorPilgrimSummary>>
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<PaginatedResult<OperatorPilgrimSummary>> create(Ref ref) {
    final argument = this.argument as StaffTableQuery;
    return operatorPilgrimRegistryPage(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OperatorPilgrimRegistryPageProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$operatorPilgrimRegistryPageHash() =>
    r'7eb8eae86e3fa28d0dc5389d31e145792c05c53f';

final class OperatorPilgrimRegistryPageFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<PaginatedResult<OperatorPilgrimSummary>>,
          StaffTableQuery
        > {
  OperatorPilgrimRegistryPageFamily._()
    : super(
        retry: null,
        name: r'operatorPilgrimRegistryPageProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OperatorPilgrimRegistryPageProvider call(StaffTableQuery query) =>
      OperatorPilgrimRegistryPageProvider._(argument: query, from: this);

  @override
  String toString() => r'operatorPilgrimRegistryPageProvider';
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
    r'ee3e827853be82b5b9976fa9226b859a6308f2f1';

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

@ProviderFor(PilgrimBulkAssignGroup)
final pilgrimBulkAssignGroupProvider = PilgrimBulkAssignGroupProvider._();

final class PilgrimBulkAssignGroupProvider
    extends $AsyncNotifierProvider<PilgrimBulkAssignGroup, void> {
  PilgrimBulkAssignGroupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pilgrimBulkAssignGroupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pilgrimBulkAssignGroupHash();

  @$internal
  @override
  PilgrimBulkAssignGroup create() => PilgrimBulkAssignGroup();
}

String _$pilgrimBulkAssignGroupHash() =>
    r'99097a00f789a7f68d1938075a93a04da7385244';

abstract class _$PilgrimBulkAssignGroup extends $AsyncNotifier<void> {
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

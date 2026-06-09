// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_operator_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fieldOperatorRepository)
final fieldOperatorRepositoryProvider = FieldOperatorRepositoryProvider._();

final class FieldOperatorRepositoryProvider
    extends
        $FunctionalProvider<
          FieldOperatorRepository,
          FieldOperatorRepository,
          FieldOperatorRepository
        >
    with $Provider<FieldOperatorRepository> {
  FieldOperatorRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fieldOperatorRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fieldOperatorRepositoryHash();

  @$internal
  @override
  $ProviderElement<FieldOperatorRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FieldOperatorRepository create(Ref ref) {
    return fieldOperatorRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FieldOperatorRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FieldOperatorRepository>(value),
    );
  }
}

String _$fieldOperatorRepositoryHash() =>
    r'4001b730135be6ffb7336ee128aea0b13526b69d';

@ProviderFor(fieldOperatorService)
final fieldOperatorServiceProvider = FieldOperatorServiceProvider._();

final class FieldOperatorServiceProvider
    extends
        $FunctionalProvider<
          FieldOperatorService,
          FieldOperatorService,
          FieldOperatorService
        >
    with $Provider<FieldOperatorService> {
  FieldOperatorServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fieldOperatorServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fieldOperatorServiceHash();

  @$internal
  @override
  $ProviderElement<FieldOperatorService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FieldOperatorService create(Ref ref) {
    return fieldOperatorService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FieldOperatorService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FieldOperatorService>(value),
    );
  }
}

String _$fieldOperatorServiceHash() =>
    r'0e0cf63ab7527bae9dcd68b1fef007c3221296bc';

@ProviderFor(fieldOperatorStats)
final fieldOperatorStatsProvider = FieldOperatorStatsProvider._();

final class FieldOperatorStatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<FieldOperatorStats>,
          FieldOperatorStats,
          FutureOr<FieldOperatorStats>
        >
    with
        $FutureModifier<FieldOperatorStats>,
        $FutureProvider<FieldOperatorStats> {
  FieldOperatorStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fieldOperatorStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fieldOperatorStatsHash();

  @$internal
  @override
  $FutureProviderElement<FieldOperatorStats> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<FieldOperatorStats> create(Ref ref) {
    return fieldOperatorStats(ref);
  }
}

String _$fieldOperatorStatsHash() =>
    r'4bf5b1e914f4e9c8d4815fd6768feee4744ce433';

@ProviderFor(FieldOperatorSearch)
final fieldOperatorSearchProvider = FieldOperatorSearchProvider._();

final class FieldOperatorSearchProvider
    extends
        $AsyncNotifierProvider<FieldOperatorSearch, List<PilgrimSearchItem>> {
  FieldOperatorSearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fieldOperatorSearchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fieldOperatorSearchHash();

  @$internal
  @override
  FieldOperatorSearch create() => FieldOperatorSearch();
}

String _$fieldOperatorSearchHash() =>
    r'124be61d416bb4dbc046137cb2d516a065a8d28a';

abstract class _$FieldOperatorSearch
    extends $AsyncNotifier<List<PilgrimSearchItem>> {
  FutureOr<List<PilgrimSearchItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<PilgrimSearchItem>>,
              List<PilgrimSearchItem>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<PilgrimSearchItem>>,
                List<PilgrimSearchItem>
              >,
              AsyncValue<List<PilgrimSearchItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(FieldOperatorPilgrimDetail)
final fieldOperatorPilgrimDetailProvider = FieldOperatorPilgrimDetailFamily._();

final class FieldOperatorPilgrimDetailProvider
    extends $AsyncNotifierProvider<FieldOperatorPilgrimDetail, Pilgrim?> {
  FieldOperatorPilgrimDetailProvider._({
    required FieldOperatorPilgrimDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'fieldOperatorPilgrimDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fieldOperatorPilgrimDetailHash();

  @override
  String toString() {
    return r'fieldOperatorPilgrimDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FieldOperatorPilgrimDetail create() => FieldOperatorPilgrimDetail();

  @override
  bool operator ==(Object other) {
    return other is FieldOperatorPilgrimDetailProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fieldOperatorPilgrimDetailHash() =>
    r'd6276163381c3224183c6ea5ade09b41ea34f05f';

final class FieldOperatorPilgrimDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          FieldOperatorPilgrimDetail,
          AsyncValue<Pilgrim?>,
          Pilgrim?,
          FutureOr<Pilgrim?>,
          String
        > {
  FieldOperatorPilgrimDetailFamily._()
    : super(
        retry: null,
        name: r'fieldOperatorPilgrimDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FieldOperatorPilgrimDetailProvider call(String profileId) =>
      FieldOperatorPilgrimDetailProvider._(argument: profileId, from: this);

  @override
  String toString() => r'fieldOperatorPilgrimDetailProvider';
}

abstract class _$FieldOperatorPilgrimDetail extends $AsyncNotifier<Pilgrim?> {
  late final _$args = ref.$arg as String;
  String get profileId => _$args;

  FutureOr<Pilgrim?> build(String profileId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Pilgrim?>, Pilgrim?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Pilgrim?>, Pilgrim?>,
              AsyncValue<Pilgrim?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

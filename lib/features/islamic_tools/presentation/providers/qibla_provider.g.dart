// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qibla_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(qiblaRepository)
final qiblaRepositoryProvider = QiblaRepositoryProvider._();

final class QiblaRepositoryProvider
    extends
        $FunctionalProvider<QiblaRepository, QiblaRepository, QiblaRepository>
    with $Provider<QiblaRepository> {
  QiblaRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'qiblaRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$qiblaRepositoryHash();

  @$internal
  @override
  $ProviderElement<QiblaRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  QiblaRepository create(Ref ref) {
    return qiblaRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(QiblaRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<QiblaRepository>(value),
    );
  }
}

String _$qiblaRepositoryHash() => r'd35521442f9a7a1a02ab9ac1351028878345bece';

@ProviderFor(qiblaState)
final qiblaStateProvider = QiblaStateProvider._();

final class QiblaStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<QiblaState>,
          QiblaState,
          Stream<QiblaState>
        >
    with $FutureModifier<QiblaState>, $StreamProvider<QiblaState> {
  QiblaStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'qiblaStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$qiblaStateHash();

  @$internal
  @override
  $StreamProviderElement<QiblaState> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<QiblaState> create(Ref ref) {
    return qiblaState(ref);
  }
}

String _$qiblaStateHash() => r'29d7c72ade4d0dc5c829927ab824a1ea49e5b7c2';

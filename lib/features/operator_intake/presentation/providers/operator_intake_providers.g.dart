// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operator_intake_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pilgrimIntakeService)
final pilgrimIntakeServiceProvider = PilgrimIntakeServiceProvider._();

final class PilgrimIntakeServiceProvider
    extends
        $FunctionalProvider<
          PilgrimIntakeService,
          PilgrimIntakeService,
          PilgrimIntakeService
        >
    with $Provider<PilgrimIntakeService> {
  PilgrimIntakeServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pilgrimIntakeServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pilgrimIntakeServiceHash();

  @$internal
  @override
  $ProviderElement<PilgrimIntakeService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PilgrimIntakeService create(Ref ref) {
    return pilgrimIntakeService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PilgrimIntakeService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PilgrimIntakeService>(value),
    );
  }
}

String _$pilgrimIntakeServiceHash() =>
    r'9c47d740f0c2d9723c71bdf5e06fd08dabfc89e2';

@ProviderFor(operatorUserId)
final operatorUserIdProvider = OperatorUserIdProvider._();

final class OperatorUserIdProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  OperatorUserIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'operatorUserIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$operatorUserIdHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return operatorUserId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$operatorUserIdHash() => r'eb220ff6ded42ca0ee31b9b8f57e90b73c67f6c0';

@ProviderFor(OperatorIntakeController)
final operatorIntakeControllerProvider = OperatorIntakeControllerProvider._();

final class OperatorIntakeControllerProvider
    extends $AsyncNotifierProvider<OperatorIntakeController, void> {
  OperatorIntakeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'operatorIntakeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$operatorIntakeControllerHash();

  @$internal
  @override
  OperatorIntakeController create() => OperatorIntakeController();
}

String _$operatorIntakeControllerHash() =>
    r'f0a33db4444971809715bf2f2b9506673d012e2a';

abstract class _$OperatorIntakeController extends $AsyncNotifier<void> {
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

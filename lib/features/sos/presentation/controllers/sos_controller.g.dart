// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Raises / cancels the current pilgrim's SOS alert.

@ProviderFor(SosRaise)
final sosRaiseProvider = SosRaiseProvider._();

/// Raises / cancels the current pilgrim's SOS alert.
final class SosRaiseProvider extends $AsyncNotifierProvider<SosRaise, void> {
  /// Raises / cancels the current pilgrim's SOS alert.
  SosRaiseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sosRaiseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sosRaiseHash();

  @$internal
  @override
  SosRaise create() => SosRaise();
}

String _$sosRaiseHash() => r'd7f5d923499e7c34b5f6513705d340032eb4d3a0';

/// Raises / cancels the current pilgrim's SOS alert.

abstract class _$SosRaise extends $AsyncNotifier<void> {
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

/// Staff action: resolve an alert.

@ProviderFor(SosResolve)
final sosResolveProvider = SosResolveProvider._();

/// Staff action: resolve an alert.
final class SosResolveProvider
    extends $AsyncNotifierProvider<SosResolve, void> {
  /// Staff action: resolve an alert.
  SosResolveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sosResolveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sosResolveHash();

  @$internal
  @override
  SosResolve create() => SosResolve();
}

String _$sosResolveHash() => r'2a726d0e6d14b7ee2d6594aac954017fafb0b0f9';

/// Staff action: resolve an alert.

abstract class _$SosResolve extends $AsyncNotifier<void> {
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

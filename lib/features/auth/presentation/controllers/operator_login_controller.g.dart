// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operator_login_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OperatorLoginController)
final operatorLoginControllerProvider = OperatorLoginControllerProvider._();

final class OperatorLoginControllerProvider
    extends $AsyncNotifierProvider<OperatorLoginController, void> {
  OperatorLoginControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'operatorLoginControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$operatorLoginControllerHash();

  @$internal
  @override
  OperatorLoginController create() => OperatorLoginController();
}

String _$operatorLoginControllerHash() =>
    r'a3faee9114180b31d94f82adf88f8d5160740d15';

abstract class _$OperatorLoginController extends $AsyncNotifier<void> {
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

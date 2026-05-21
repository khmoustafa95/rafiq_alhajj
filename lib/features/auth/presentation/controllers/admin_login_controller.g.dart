// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_login_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminLoginController)
final adminLoginControllerProvider = AdminLoginControllerProvider._();

final class AdminLoginControllerProvider
    extends $AsyncNotifierProvider<AdminLoginController, void> {
  AdminLoginControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminLoginControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminLoginControllerHash();

  @$internal
  @override
  AdminLoginController create() => AdminLoginController();
}

String _$adminLoginControllerHash() =>
    r'6e4a77d8d2c2e7e1b3256d36528a1728df902496';

abstract class _$AdminLoginController extends $AsyncNotifier<void> {
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

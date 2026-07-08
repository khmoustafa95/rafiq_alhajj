// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_account_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DeleteAccountController)
final deleteAccountControllerProvider = DeleteAccountControllerProvider._();

final class DeleteAccountControllerProvider
    extends $AsyncNotifierProvider<DeleteAccountController, void> {
  DeleteAccountControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteAccountControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteAccountControllerHash();

  @$internal
  @override
  DeleteAccountController create() => DeleteAccountController();
}

String _$deleteAccountControllerHash() =>
    r'4ffb745a024956fea48afe0bff88ff0f4f1a65d3';

abstract class _$DeleteAccountController extends $AsyncNotifier<void> {
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

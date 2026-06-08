// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_connectivity.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StaffConnectivity)
final staffConnectivityProvider = StaffConnectivityProvider._();

final class StaffConnectivityProvider
    extends $NotifierProvider<StaffConnectivity, bool> {
  StaffConnectivityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffConnectivityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffConnectivityHash();

  @$internal
  @override
  StaffConnectivity create() => StaffConnectivity();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$staffConnectivityHash() => r'1346b24340ff7048859f29db670d6b38ff7231f8';

abstract class _$StaffConnectivity extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

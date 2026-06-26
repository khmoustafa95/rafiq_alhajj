// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_sidebar_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Persisted collapse state for the staff web sidebar. When collapsed the
/// sidebar shows icon-only navigation (with hover tooltips) to give content
/// pages — especially wide data tables — more horizontal room.

@ProviderFor(StaffSidebarCollapsed)
final staffSidebarCollapsedProvider = StaffSidebarCollapsedProvider._();

/// Persisted collapse state for the staff web sidebar. When collapsed the
/// sidebar shows icon-only navigation (with hover tooltips) to give content
/// pages — especially wide data tables — more horizontal room.
final class StaffSidebarCollapsedProvider
    extends $NotifierProvider<StaffSidebarCollapsed, bool> {
  /// Persisted collapse state for the staff web sidebar. When collapsed the
  /// sidebar shows icon-only navigation (with hover tooltips) to give content
  /// pages — especially wide data tables — more horizontal room.
  StaffSidebarCollapsedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffSidebarCollapsedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffSidebarCollapsedHash();

  @$internal
  @override
  StaffSidebarCollapsed create() => StaffSidebarCollapsed();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$staffSidebarCollapsedHash() =>
    r'f9bc001dac7d809d1b22b3a0ab70ed6a3fe3d7fb';

/// Persisted collapse state for the staff web sidebar. When collapsed the
/// sidebar shows icon-only navigation (with hover tooltips) to give content
/// pages — especially wide data tables — more horizontal room.

abstract class _$StaffSidebarCollapsed extends $Notifier<bool> {
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

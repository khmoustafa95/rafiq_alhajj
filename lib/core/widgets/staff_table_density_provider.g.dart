// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_table_density_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Persisted row-density preference shared by every staff data table. When
/// `true` rows render compact (more rows per screen); otherwise comfortable.

@ProviderFor(StaffTableCompactDensity)
final staffTableCompactDensityProvider = StaffTableCompactDensityProvider._();

/// Persisted row-density preference shared by every staff data table. When
/// `true` rows render compact (more rows per screen); otherwise comfortable.
final class StaffTableCompactDensityProvider
    extends $NotifierProvider<StaffTableCompactDensity, bool> {
  /// Persisted row-density preference shared by every staff data table. When
  /// `true` rows render compact (more rows per screen); otherwise comfortable.
  StaffTableCompactDensityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'staffTableCompactDensityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$staffTableCompactDensityHash();

  @$internal
  @override
  StaffTableCompactDensity create() => StaffTableCompactDensity();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$staffTableCompactDensityHash() =>
    r'68ec3413b4b05c708301e87c0a646f764d09d535';

/// Persisted row-density preference shared by every staff data table. When
/// `true` rows render compact (more rows per screen); otherwise comfortable.

abstract class _$StaffTableCompactDensity extends $Notifier<bool> {
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

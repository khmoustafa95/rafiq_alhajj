// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pilgrim_table_column_visibility_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PilgrimTableColumnVisibility)
final pilgrimTableColumnVisibilityProvider =
    PilgrimTableColumnVisibilityProvider._();

final class PilgrimTableColumnVisibilityProvider
    extends $NotifierProvider<PilgrimTableColumnVisibility, Set<String>> {
  PilgrimTableColumnVisibilityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pilgrimTableColumnVisibilityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pilgrimTableColumnVisibilityHash();

  @$internal
  @override
  PilgrimTableColumnVisibility create() => PilgrimTableColumnVisibility();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$pilgrimTableColumnVisibilityHash() =>
    r'3818e407deb0817107acf75e1c46278e7ffc67df';

abstract class _$PilgrimTableColumnVisibility extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

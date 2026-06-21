// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pilgrim_shared_defaults_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Persisted map of shared logistics field values, keyed by catalog field key.

@ProviderFor(PilgrimSharedDefaults)
final pilgrimSharedDefaultsProvider = PilgrimSharedDefaultsProvider._();

/// Persisted map of shared logistics field values, keyed by catalog field key.
final class PilgrimSharedDefaultsProvider
    extends $NotifierProvider<PilgrimSharedDefaults, Map<String, dynamic>> {
  /// Persisted map of shared logistics field values, keyed by catalog field key.
  PilgrimSharedDefaultsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pilgrimSharedDefaultsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pilgrimSharedDefaultsHash();

  @$internal
  @override
  PilgrimSharedDefaults create() => PilgrimSharedDefaults();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, dynamic> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, dynamic>>(value),
    );
  }
}

String _$pilgrimSharedDefaultsHash() =>
    r'7bec7b7264bfca34ae4faad006545ad1c1aacab7';

/// Persisted map of shared logistics field values, keyed by catalog field key.

abstract class _$PilgrimSharedDefaults extends $Notifier<Map<String, dynamic>> {
  Map<String, dynamic> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Map<String, dynamic>, Map<String, dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, dynamic>, Map<String, dynamic>>,
              Map<String, dynamic>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pilgrim_import_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Drives the import wizard: pick -> map columns -> preview -> commit.

@ProviderFor(PilgrimImportController)
final pilgrimImportControllerProvider = PilgrimImportControllerProvider._();

/// Drives the import wizard: pick -> map columns -> preview -> commit.
final class PilgrimImportControllerProvider
    extends $NotifierProvider<PilgrimImportController, PilgrimImportState> {
  /// Drives the import wizard: pick -> map columns -> preview -> commit.
  PilgrimImportControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pilgrimImportControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pilgrimImportControllerHash();

  @$internal
  @override
  PilgrimImportController create() => PilgrimImportController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PilgrimImportState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PilgrimImportState>(value),
    );
  }
}

String _$pilgrimImportControllerHash() =>
    r'0b8eef6f2f36778aaafde6d5b02a6fdde9fdd2e7';

/// Drives the import wizard: pick -> map columns -> preview -> commit.

abstract class _$PilgrimImportController extends $Notifier<PilgrimImportState> {
  PilgrimImportState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PilgrimImportState, PilgrimImportState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PilgrimImportState, PilgrimImportState>,
              PilgrimImportState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

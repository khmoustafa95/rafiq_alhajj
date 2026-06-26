// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pilgrim_export_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Builds the workbook from the current trip's pilgrims and saves it via the
/// platform file helper.

@ProviderFor(PilgrimExportController)
final pilgrimExportControllerProvider = PilgrimExportControllerProvider._();

/// Builds the workbook from the current trip's pilgrims and saves it via the
/// platform file helper.
final class PilgrimExportControllerProvider
    extends $AsyncNotifierProvider<PilgrimExportController, void> {
  /// Builds the workbook from the current trip's pilgrims and saves it via the
  /// platform file helper.
  PilgrimExportControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pilgrimExportControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pilgrimExportControllerHash();

  @$internal
  @override
  PilgrimExportController create() => PilgrimExportController();
}

String _$pilgrimExportControllerHash() =>
    r'9ac9bdab13f90379891af95d29adf16951a3f4c6';

/// Builds the workbook from the current trip's pilgrims and saves it via the
/// platform file helper.

abstract class _$PilgrimExportController extends $AsyncNotifier<void> {
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

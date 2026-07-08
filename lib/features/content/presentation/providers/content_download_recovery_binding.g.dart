// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_download_recovery_binding.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Reconciles the encrypted media manifest when the app resumes.

@ProviderFor(contentDownloadRecoveryBinding)
final contentDownloadRecoveryBindingProvider =
    ContentDownloadRecoveryBindingProvider._();

/// Reconciles the encrypted media manifest when the app resumes.

final class ContentDownloadRecoveryBindingProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Reconciles the encrypted media manifest when the app resumes.
  ContentDownloadRecoveryBindingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentDownloadRecoveryBindingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentDownloadRecoveryBindingHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return contentDownloadRecoveryBinding(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$contentDownloadRecoveryBindingHash() =>
    r'58b3746c3bc5e0aed6bf84624f2570f8d5585850';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_catalog_refresh_binding.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Refreshes cached content catalogs when connectivity is restored.

@ProviderFor(contentCatalogRefreshBinding)
final contentCatalogRefreshBindingProvider =
    ContentCatalogRefreshBindingProvider._();

/// Refreshes cached content catalogs when connectivity is restored.

final class ContentCatalogRefreshBindingProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Refreshes cached content catalogs when connectivity is restored.
  ContentCatalogRefreshBindingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentCatalogRefreshBindingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentCatalogRefreshBindingHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return contentCatalogRefreshBinding(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$contentCatalogRefreshBindingHash() =>
    r'83f024e4b98bee10e1b522c1d1ba3b8dbb5900fa';

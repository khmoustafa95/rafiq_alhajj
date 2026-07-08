// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_catalog_prefetch_binding.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Prefetches catalog metadata on Wi-Fi after pilgrim/guest session is active.

@ProviderFor(contentCatalogPrefetchBinding)
final contentCatalogPrefetchBindingProvider =
    ContentCatalogPrefetchBindingProvider._();

/// Prefetches catalog metadata on Wi-Fi after pilgrim/guest session is active.

final class ContentCatalogPrefetchBindingProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Prefetches catalog metadata on Wi-Fi after pilgrim/guest session is active.
  ContentCatalogPrefetchBindingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentCatalogPrefetchBindingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentCatalogPrefetchBindingHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return contentCatalogPrefetchBinding(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$contentCatalogPrefetchBindingHash() =>
    r'fa3e1934f3558a1b9431d9132e165b2550b47993';

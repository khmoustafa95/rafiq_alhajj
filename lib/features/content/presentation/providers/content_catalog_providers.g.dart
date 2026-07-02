// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_catalog_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contentCatalogCache)
final contentCatalogCacheProvider = ContentCatalogCacheProvider._();

final class ContentCatalogCacheProvider
    extends
        $FunctionalProvider<
          AsyncValue<ContentCatalogCache>,
          ContentCatalogCache,
          FutureOr<ContentCatalogCache>
        >
    with
        $FutureModifier<ContentCatalogCache>,
        $FutureProvider<ContentCatalogCache> {
  ContentCatalogCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentCatalogCacheProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentCatalogCacheHash();

  @$internal
  @override
  $FutureProviderElement<ContentCatalogCache> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ContentCatalogCache> create(Ref ref) {
    return contentCatalogCache(ref);
  }
}

String _$contentCatalogCacheHash() =>
    r'02fa60fb022114e19678d8319eb4dd7a2b518d3a';

@ProviderFor(contentCatalogService)
final contentCatalogServiceProvider = ContentCatalogServiceProvider._();

final class ContentCatalogServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<ContentCatalogService>,
          ContentCatalogService,
          FutureOr<ContentCatalogService>
        >
    with
        $FutureModifier<ContentCatalogService>,
        $FutureProvider<ContentCatalogService> {
  ContentCatalogServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentCatalogServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentCatalogServiceHash();

  @$internal
  @override
  $FutureProviderElement<ContentCatalogService> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ContentCatalogService> create(Ref ref) {
    return contentCatalogService(ref);
  }
}

String _$contentCatalogServiceHash() =>
    r'512fd9123b227833ed76bf4b5a95c1addc3ecf65';

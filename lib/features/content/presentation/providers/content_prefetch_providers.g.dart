// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_prefetch_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Prefetches catalog metadata (and optionally media) for push deep-links.

@ProviderFor(contentPrefetchService)
final contentPrefetchServiceProvider = ContentPrefetchServiceProvider._();

/// Prefetches catalog metadata (and optionally media) for push deep-links.

final class ContentPrefetchServiceProvider
    extends
        $FunctionalProvider<
          ContentPrefetchService,
          ContentPrefetchService,
          ContentPrefetchService
        >
    with $Provider<ContentPrefetchService> {
  /// Prefetches catalog metadata (and optionally media) for push deep-links.
  ContentPrefetchServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentPrefetchServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentPrefetchServiceHash();

  @$internal
  @override
  $ProviderElement<ContentPrefetchService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContentPrefetchService create(Ref ref) {
    return contentPrefetchService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContentPrefetchService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContentPrefetchService>(value),
    );
  }
}

String _$contentPrefetchServiceHash() =>
    r'f83a79370cf4517458a7b370f0f2411d439b2e97';

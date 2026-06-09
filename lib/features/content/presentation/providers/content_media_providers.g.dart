// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_media_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contentMediaCacheStore)
final contentMediaCacheStoreProvider = ContentMediaCacheStoreProvider._();

final class ContentMediaCacheStoreProvider
    extends
        $FunctionalProvider<
          AsyncValue<ContentMediaCacheStore>,
          ContentMediaCacheStore,
          FutureOr<ContentMediaCacheStore>
        >
    with
        $FutureModifier<ContentMediaCacheStore>,
        $FutureProvider<ContentMediaCacheStore> {
  ContentMediaCacheStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentMediaCacheStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentMediaCacheStoreHash();

  @$internal
  @override
  $FutureProviderElement<ContentMediaCacheStore> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ContentMediaCacheStore> create(Ref ref) {
    return contentMediaCacheStore(ref);
  }
}

String _$contentMediaCacheStoreHash() =>
    r'83b4a5582dadf8087a8c2d09ccdd24355ff0854f';

@ProviderFor(contentMediaCacheService)
final contentMediaCacheServiceProvider = ContentMediaCacheServiceProvider._();

final class ContentMediaCacheServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<ContentMediaCacheService>,
          ContentMediaCacheService,
          FutureOr<ContentMediaCacheService>
        >
    with
        $FutureModifier<ContentMediaCacheService>,
        $FutureProvider<ContentMediaCacheService> {
  ContentMediaCacheServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentMediaCacheServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentMediaCacheServiceHash();

  @$internal
  @override
  $FutureProviderElement<ContentMediaCacheService> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ContentMediaCacheService> create(Ref ref) {
    return contentMediaCacheService(ref);
  }
}

String _$contentMediaCacheServiceHash() =>
    r'3b751dc52f6dc044c7cdb82f98465efd198ee92e';

@ProviderFor(contentMediaStorageService)
final contentMediaStorageServiceProvider =
    ContentMediaStorageServiceProvider._();

final class ContentMediaStorageServiceProvider
    extends
        $FunctionalProvider<
          ContentMediaStorageService,
          ContentMediaStorageService,
          ContentMediaStorageService
        >
    with $Provider<ContentMediaStorageService> {
  ContentMediaStorageServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentMediaStorageServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentMediaStorageServiceHash();

  @$internal
  @override
  $ProviderElement<ContentMediaStorageService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContentMediaStorageService create(Ref ref) {
    return contentMediaStorageService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContentMediaStorageService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContentMediaStorageService>(value),
    );
  }
}

String _$contentMediaStorageServiceHash() =>
    r'77d5cf8f83c7a93b1141fd1b611b0380b64de432';

@ProviderFor(ContentMediaDownloadController)
final contentMediaDownloadControllerProvider =
    ContentMediaDownloadControllerProvider._();

final class ContentMediaDownloadControllerProvider
    extends
        $AsyncNotifierProvider<
          ContentMediaDownloadController,
          ContentDownloadState
        > {
  ContentMediaDownloadControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentMediaDownloadControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentMediaDownloadControllerHash();

  @$internal
  @override
  ContentMediaDownloadController create() => ContentMediaDownloadController();
}

String _$contentMediaDownloadControllerHash() =>
    r'133e0455c43dd2f59fa18c1b6e3aa89dab6543cd';

abstract class _$ContentMediaDownloadController
    extends $AsyncNotifier<ContentDownloadState> {
  FutureOr<ContentDownloadState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<ContentDownloadState>, ContentDownloadState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ContentDownloadState>,
                ContentDownloadState
              >,
              AsyncValue<ContentDownloadState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(resolvedMediaPlaybackUrl)
final resolvedMediaPlaybackUrlProvider = ResolvedMediaPlaybackUrlFamily._();

final class ResolvedMediaPlaybackUrlProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  ResolvedMediaPlaybackUrlProvider._({
    required ResolvedMediaPlaybackUrlFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'resolvedMediaPlaybackUrlProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$resolvedMediaPlaybackUrlHash();

  @override
  String toString() {
    return r'resolvedMediaPlaybackUrlProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as (String, String);
    return resolvedMediaPlaybackUrl(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is ResolvedMediaPlaybackUrlProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$resolvedMediaPlaybackUrlHash() =>
    r'768e17ed3d1154c8d9ec9249b7dcacb80c4af354';

final class ResolvedMediaPlaybackUrlFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, (String, String)> {
  ResolvedMediaPlaybackUrlFamily._()
    : super(
        retry: null,
        name: r'resolvedMediaPlaybackUrlProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ResolvedMediaPlaybackUrlProvider call(String mediaId, String remoteUrl) =>
      ResolvedMediaPlaybackUrlProvider._(
        argument: (mediaId, remoteUrl),
        from: this,
      );

  @override
  String toString() => r'resolvedMediaPlaybackUrlProvider';
}

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
    r'36e9d1432e83f996542df16d3d496ddd76453ec0';

@ProviderFor(mediaEncryptionService)
final mediaEncryptionServiceProvider = MediaEncryptionServiceProvider._();

final class MediaEncryptionServiceProvider
    extends
        $FunctionalProvider<
          MediaEncryptionService,
          MediaEncryptionService,
          MediaEncryptionService
        >
    with $Provider<MediaEncryptionService> {
  MediaEncryptionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mediaEncryptionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mediaEncryptionServiceHash();

  @$internal
  @override
  $ProviderElement<MediaEncryptionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MediaEncryptionService create(Ref ref) {
    return mediaEncryptionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MediaEncryptionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MediaEncryptionService>(value),
    );
  }
}

String _$mediaEncryptionServiceHash() =>
    r'd6fc97966d457e5cb01b61ee681cff86feaec5ca';

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
    r'c9b88afbff6dabc752b3b572c16d5a470372372c';

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
    r'f2b62f02c7c0cf0c8f9ef4232362449faf2c968b';

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
    r'60a76e1fad9ae626aeb4bc8b168f2ff72767c1c1';

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

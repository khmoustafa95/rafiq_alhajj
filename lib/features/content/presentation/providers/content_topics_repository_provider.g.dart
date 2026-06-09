// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_topics_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contentTopicsRepository)
final contentTopicsRepositoryProvider = ContentTopicsRepositoryProvider._();

final class ContentTopicsRepositoryProvider
    extends
        $FunctionalProvider<
          ContentTopicsRepository,
          ContentTopicsRepository,
          ContentTopicsRepository
        >
    with $Provider<ContentTopicsRepository> {
  ContentTopicsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentTopicsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentTopicsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ContentTopicsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContentTopicsRepository create(Ref ref) {
    return contentTopicsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContentTopicsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContentTopicsRepository>(value),
    );
  }
}

String _$contentTopicsRepositoryHash() =>
    r'57bb91bd87ed583d068b6431f6e5539b7ed7d2dd';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_downloads_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contentDownloadsByTopic)
final contentDownloadsByTopicProvider = ContentDownloadsByTopicProvider._();

final class ContentDownloadsByTopicProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, List<CachedContentMediaEntry>>>,
          Map<String, List<CachedContentMediaEntry>>,
          FutureOr<Map<String, List<CachedContentMediaEntry>>>
        >
    with
        $FutureModifier<Map<String, List<CachedContentMediaEntry>>>,
        $FutureProvider<Map<String, List<CachedContentMediaEntry>>> {
  ContentDownloadsByTopicProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentDownloadsByTopicProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentDownloadsByTopicHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, List<CachedContentMediaEntry>>>
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, List<CachedContentMediaEntry>>> create(Ref ref) {
    return contentDownloadsByTopic(ref);
  }
}

String _$contentDownloadsByTopicHash() =>
    r'48027c74b19fbc9ccc3fd8bbe818c24d8b8668da';

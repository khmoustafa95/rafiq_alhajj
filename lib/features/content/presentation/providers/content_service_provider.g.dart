// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contentService)
final contentServiceProvider = ContentServiceProvider._();

final class ContentServiceProvider
    extends $FunctionalProvider<ContentService, ContentService, ContentService>
    with $Provider<ContentService> {
  ContentServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentServiceHash();

  @$internal
  @override
  $ProviderElement<ContentService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ContentService create(Ref ref) {
    return contentService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContentService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContentService>(value),
    );
  }
}

String _$contentServiceHash() => r'9a4810d9b2ea7504854f3d4b60d666229bd5f9e6';

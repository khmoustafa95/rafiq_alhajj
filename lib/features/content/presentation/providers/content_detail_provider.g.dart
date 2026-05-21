// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contentDetail)
final contentDetailProvider = ContentDetailFamily._();

final class ContentDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<ContentItem?>,
          ContentItem?,
          FutureOr<ContentItem?>
        >
    with $FutureModifier<ContentItem?>, $FutureProvider<ContentItem?> {
  ContentDetailProvider._({
    required ContentDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'contentDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$contentDetailHash();

  @override
  String toString() {
    return r'contentDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ContentItem?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ContentItem?> create(Ref ref) {
    final argument = this.argument as String;
    return contentDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ContentDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$contentDetailHash() => r'e072d3ca511fa6537be43242e104012bafd92627';

final class ContentDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ContentItem?>, String> {
  ContentDetailFamily._()
    : super(
        retry: null,
        name: r'contentDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ContentDetailProvider call(String contentId) =>
      ContentDetailProvider._(argument: contentId, from: this);

  @override
  String toString() => r'contentDetailProvider';
}

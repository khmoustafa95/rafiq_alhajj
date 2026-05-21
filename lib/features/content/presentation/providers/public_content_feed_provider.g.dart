// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_content_feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(homeContentFeed)
final homeContentFeedProvider = HomeContentFeedFamily._();

final class HomeContentFeedProvider
    extends
        $FunctionalProvider<
          AsyncValue<PublicContentFeed>,
          PublicContentFeed,
          FutureOr<PublicContentFeed>
        >
    with
        $FutureModifier<PublicContentFeed>,
        $FutureProvider<PublicContentFeed> {
  HomeContentFeedProvider._({
    required HomeContentFeedFamily super.from,
    required AppAccessMode super.argument,
  }) : super(
         retry: null,
         name: r'homeContentFeedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$homeContentFeedHash();

  @override
  String toString() {
    return r'homeContentFeedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PublicContentFeed> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PublicContentFeed> create(Ref ref) {
    final argument = this.argument as AppAccessMode;
    return homeContentFeed(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HomeContentFeedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$homeContentFeedHash() => r'f3f7cbc21196938c3ccf9307a45354c424ee0d47';

final class HomeContentFeedFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PublicContentFeed>, AppAccessMode> {
  HomeContentFeedFamily._()
    : super(
        retry: null,
        name: r'homeContentFeedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HomeContentFeedProvider call(AppAccessMode accessMode) =>
      HomeContentFeedProvider._(argument: accessMode, from: this);

  @override
  String toString() => r'homeContentFeedProvider';
}

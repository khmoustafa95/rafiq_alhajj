// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_content_feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeContentFeed)
final homeContentFeedProvider = HomeContentFeedFamily._();

final class HomeContentFeedProvider
    extends
        $AsyncNotifierProvider<
          HomeContentFeed,
          CatalogSnapshot<PublicContentFeed>
        > {
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
  HomeContentFeed create() => HomeContentFeed();

  @override
  bool operator ==(Object other) {
    return other is HomeContentFeedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$homeContentFeedHash() => r'd093e90445a0732500317e980aef0f11bd978fba';

final class HomeContentFeedFamily extends $Family
    with
        $ClassFamilyOverride<
          HomeContentFeed,
          AsyncValue<CatalogSnapshot<PublicContentFeed>>,
          CatalogSnapshot<PublicContentFeed>,
          FutureOr<CatalogSnapshot<PublicContentFeed>>,
          AppAccessMode
        > {
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

abstract class _$HomeContentFeed
    extends $AsyncNotifier<CatalogSnapshot<PublicContentFeed>> {
  late final _$args = ref.$arg as AppAccessMode;
  AppAccessMode get accessMode => _$args;

  FutureOr<CatalogSnapshot<PublicContentFeed>> build(AppAccessMode accessMode);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<CatalogSnapshot<PublicContentFeed>>,
              CatalogSnapshot<PublicContentFeed>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CatalogSnapshot<PublicContentFeed>>,
                CatalogSnapshot<PublicContentFeed>
              >,
              AsyncValue<CatalogSnapshot<PublicContentFeed>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

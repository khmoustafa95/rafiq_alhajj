// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_topics_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ContentTopicsList)
final contentTopicsListProvider = ContentTopicsListFamily._();

final class ContentTopicsListProvider
    extends
        $AsyncNotifierProvider<
          ContentTopicsList,
          CatalogSnapshot<List<ContentTopic>>
        > {
  ContentTopicsListProvider._({
    required ContentTopicsListFamily super.from,
    required AppAccessMode super.argument,
  }) : super(
         retry: null,
         name: r'contentTopicsListProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$contentTopicsListHash();

  @override
  String toString() {
    return r'contentTopicsListProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ContentTopicsList create() => ContentTopicsList();

  @override
  bool operator ==(Object other) {
    return other is ContentTopicsListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$contentTopicsListHash() => r'7679de54eab8c36aac32c1d689b4e7938171d67b';

final class ContentTopicsListFamily extends $Family
    with
        $ClassFamilyOverride<
          ContentTopicsList,
          AsyncValue<CatalogSnapshot<List<ContentTopic>>>,
          CatalogSnapshot<List<ContentTopic>>,
          FutureOr<CatalogSnapshot<List<ContentTopic>>>,
          AppAccessMode
        > {
  ContentTopicsListFamily._()
    : super(
        retry: null,
        name: r'contentTopicsListProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ContentTopicsListProvider call(AppAccessMode accessMode) =>
      ContentTopicsListProvider._(argument: accessMode, from: this);

  @override
  String toString() => r'contentTopicsListProvider';
}

abstract class _$ContentTopicsList
    extends $AsyncNotifier<CatalogSnapshot<List<ContentTopic>>> {
  late final _$args = ref.$arg as AppAccessMode;
  AppAccessMode get accessMode => _$args;

  FutureOr<CatalogSnapshot<List<ContentTopic>>> build(AppAccessMode accessMode);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<CatalogSnapshot<List<ContentTopic>>>,
              CatalogSnapshot<List<ContentTopic>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CatalogSnapshot<List<ContentTopic>>>,
                CatalogSnapshot<List<ContentTopic>>
              >,
              AsyncValue<CatalogSnapshot<List<ContentTopic>>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(contentTopicDetail)
final contentTopicDetailProvider = ContentTopicDetailFamily._();

final class ContentTopicDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<ContentTopic?>,
          ContentTopic?,
          FutureOr<ContentTopic?>
        >
    with $FutureModifier<ContentTopic?>, $FutureProvider<ContentTopic?> {
  ContentTopicDetailProvider._({
    required ContentTopicDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'contentTopicDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$contentTopicDetailHash();

  @override
  String toString() {
    return r'contentTopicDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ContentTopic?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ContentTopic?> create(Ref ref) {
    final argument = this.argument as String;
    return contentTopicDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ContentTopicDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$contentTopicDetailHash() =>
    r'92f6ceff7b252611719ca3ceae714ca731a7e972';

final class ContentTopicDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ContentTopic?>, String> {
  ContentTopicDetailFamily._()
    : super(
        retry: null,
        name: r'contentTopicDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ContentTopicDetailProvider call(String id) =>
      ContentTopicDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'contentTopicDetailProvider';
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_topics_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contentTopicsList)
final contentTopicsListProvider = ContentTopicsListFamily._();

final class ContentTopicsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ContentTopic>>,
          List<ContentTopic>,
          FutureOr<List<ContentTopic>>
        >
    with
        $FutureModifier<List<ContentTopic>>,
        $FutureProvider<List<ContentTopic>> {
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
  $FutureProviderElement<List<ContentTopic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ContentTopic>> create(Ref ref) {
    final argument = this.argument as AppAccessMode;
    return contentTopicsList(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ContentTopicsListProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$contentTopicsListHash() => r'e2c785582a39f48bfee70d6705d1a0eaae582e6f';

final class ContentTopicsListFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<ContentTopic>>, AppAccessMode> {
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contentLocalSearch)
final contentLocalSearchProvider = ContentLocalSearchFamily._();

final class ContentLocalSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CatalogSearchHit>>,
          List<CatalogSearchHit>,
          FutureOr<List<CatalogSearchHit>>
        >
    with
        $FutureModifier<List<CatalogSearchHit>>,
        $FutureProvider<List<CatalogSearchHit>> {
  ContentLocalSearchProvider._({
    required ContentLocalSearchFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'contentLocalSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$contentLocalSearchHash();

  @override
  String toString() {
    return r'contentLocalSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<CatalogSearchHit>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CatalogSearchHit>> create(Ref ref) {
    final argument = this.argument as String;
    return contentLocalSearch(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ContentLocalSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$contentLocalSearchHash() =>
    r'78668e4902bab81f607fa9047e70d9ab7d6ee2e4';

final class ContentLocalSearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<CatalogSearchHit>>, String> {
  ContentLocalSearchFamily._()
    : super(
        retry: null,
        name: r'contentLocalSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ContentLocalSearchProvider call(String query) =>
      ContentLocalSearchProvider._(argument: query, from: this);

  @override
  String toString() => r'contentLocalSearchProvider';
}

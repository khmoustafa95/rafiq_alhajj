// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_learning_progress_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(continueLearningProgress)
final continueLearningProgressProvider = ContinueLearningProgressProvider._();

final class ContinueLearningProgressProvider
    extends
        $FunctionalProvider<
          AsyncValue<ContentMediaProgress?>,
          ContentMediaProgress?,
          FutureOr<ContentMediaProgress?>
        >
    with
        $FutureModifier<ContentMediaProgress?>,
        $FutureProvider<ContentMediaProgress?> {
  ContinueLearningProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'continueLearningProgressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$continueLearningProgressHash();

  @$internal
  @override
  $FutureProviderElement<ContentMediaProgress?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ContentMediaProgress?> create(Ref ref) {
    return continueLearningProgress(ref);
  }
}

String _$continueLearningProgressHash() =>
    r'00085b2b40ff71c82eaa6a5366d2771e5267bdb7';

@ProviderFor(ContentLearningProgressRecorder)
final contentLearningProgressRecorderProvider =
    ContentLearningProgressRecorderProvider._();

final class ContentLearningProgressRecorderProvider
    extends $AsyncNotifierProvider<ContentLearningProgressRecorder, void> {
  ContentLearningProgressRecorderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentLearningProgressRecorderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentLearningProgressRecorderHash();

  @$internal
  @override
  ContentLearningProgressRecorder create() => ContentLearningProgressRecorder();
}

String _$contentLearningProgressRecorderHash() =>
    r'2be00099b6e5c4d460972c4ddc6fb0d072930ab4';

abstract class _$ContentLearningProgressRecorder extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

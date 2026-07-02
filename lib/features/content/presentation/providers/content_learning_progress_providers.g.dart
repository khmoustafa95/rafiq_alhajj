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

@ProviderFor(mediaResumePositionMs)
final mediaResumePositionMsProvider = MediaResumePositionMsFamily._();

final class MediaResumePositionMsProvider
    extends $FunctionalProvider<AsyncValue<int?>, int?, FutureOr<int?>>
    with $FutureModifier<int?>, $FutureProvider<int?> {
  MediaResumePositionMsProvider._({
    required MediaResumePositionMsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'mediaResumePositionMsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mediaResumePositionMsHash();

  @override
  String toString() {
    return r'mediaResumePositionMsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<int?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int?> create(Ref ref) {
    final argument = this.argument as String;
    return mediaResumePositionMs(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MediaResumePositionMsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mediaResumePositionMsHash() =>
    r'42429bfda78eae7e4223f0e11c0a1ceac78eab32';

final class MediaResumePositionMsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<int?>, String> {
  MediaResumePositionMsFamily._()
    : super(
        retry: null,
        name: r'mediaResumePositionMsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MediaResumePositionMsProvider call(String mediaId) =>
      MediaResumePositionMsProvider._(argument: mediaId, from: this);

  @override
  String toString() => r'mediaResumePositionMsProvider';
}

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

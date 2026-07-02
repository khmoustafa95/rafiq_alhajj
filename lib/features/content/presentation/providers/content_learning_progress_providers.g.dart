// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_learning_progress_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(contentLearningProgressRepository)
final contentLearningProgressRepositoryProvider =
    ContentLearningProgressRepositoryProvider._();

final class ContentLearningProgressRepositoryProvider
    extends
        $FunctionalProvider<
          ContentLearningProgressRepository,
          ContentLearningProgressRepository,
          ContentLearningProgressRepository
        >
    with $Provider<ContentLearningProgressRepository> {
  ContentLearningProgressRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentLearningProgressRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$contentLearningProgressRepositoryHash();

  @$internal
  @override
  $ProviderElement<ContentLearningProgressRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContentLearningProgressRepository create(Ref ref) {
    return contentLearningProgressRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContentLearningProgressRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContentLearningProgressRepository>(
        value,
      ),
    );
  }
}

String _$contentLearningProgressRepositoryHash() =>
    r'63ebf6294484f5af12a83e37a4e527ed41840ad6';

@ProviderFor(contentLearningProgressSyncService)
final contentLearningProgressSyncServiceProvider =
    ContentLearningProgressSyncServiceProvider._();

final class ContentLearningProgressSyncServiceProvider
    extends
        $FunctionalProvider<
          ContentLearningProgressSyncService,
          ContentLearningProgressSyncService,
          ContentLearningProgressSyncService
        >
    with $Provider<ContentLearningProgressSyncService> {
  ContentLearningProgressSyncServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentLearningProgressSyncServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$contentLearningProgressSyncServiceHash();

  @$internal
  @override
  $ProviderElement<ContentLearningProgressSyncService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContentLearningProgressSyncService create(Ref ref) {
    return contentLearningProgressSyncService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContentLearningProgressSyncService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContentLearningProgressSyncService>(
        value,
      ),
    );
  }
}

String _$contentLearningProgressSyncServiceHash() =>
    r'ab83680f99b27b8a63436e98bd989aad7f685671';

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

@ProviderFor(myLearningProgress)
final myLearningProgressProvider = MyLearningProgressProvider._();

final class MyLearningProgressProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ContentMediaProgress>>,
          List<ContentMediaProgress>,
          FutureOr<List<ContentMediaProgress>>
        >
    with
        $FutureModifier<List<ContentMediaProgress>>,
        $FutureProvider<List<ContentMediaProgress>> {
  MyLearningProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myLearningProgressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myLearningProgressHash();

  @$internal
  @override
  $FutureProviderElement<List<ContentMediaProgress>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ContentMediaProgress>> create(Ref ref) {
    return myLearningProgress(ref);
  }
}

String _$myLearningProgressHash() =>
    r'37dafa2bb8972caa9fb17a2be3ca77a3b82d865d';

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
    r'5c0c2154596f6a3e953f554267be93288bbc9de1';

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

@ProviderFor(ContentLearningProgressBootstrap)
final contentLearningProgressBootstrapProvider =
    ContentLearningProgressBootstrapProvider._();

final class ContentLearningProgressBootstrapProvider
    extends $AsyncNotifierProvider<ContentLearningProgressBootstrap, void> {
  ContentLearningProgressBootstrapProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentLearningProgressBootstrapProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentLearningProgressBootstrapHash();

  @$internal
  @override
  ContentLearningProgressBootstrap create() =>
      ContentLearningProgressBootstrap();
}

String _$contentLearningProgressBootstrapHash() =>
    r'8546073a9a7c7bf2ebde6a57a7d541f0932e0511';

abstract class _$ContentLearningProgressBootstrap extends $AsyncNotifier<void> {
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

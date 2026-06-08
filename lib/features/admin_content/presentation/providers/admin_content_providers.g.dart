// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_content_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminContentRepository)
final adminContentRepositoryProvider = AdminContentRepositoryProvider._();

final class AdminContentRepositoryProvider
    extends
        $FunctionalProvider<
          AdminContentRepository,
          AdminContentRepository,
          AdminContentRepository
        >
    with $Provider<AdminContentRepository> {
  AdminContentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminContentRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminContentRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdminContentRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminContentRepository create(Ref ref) {
    return adminContentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminContentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminContentRepository>(value),
    );
  }
}

String _$adminContentRepositoryHash() =>
    r'7eb5883de3dfa49d2becd12e920c9a295618e3da';

@ProviderFor(adminContentService)
final adminContentServiceProvider = AdminContentServiceProvider._();

final class AdminContentServiceProvider
    extends
        $FunctionalProvider<
          AdminContentService,
          AdminContentService,
          AdminContentService
        >
    with $Provider<AdminContentService> {
  AdminContentServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminContentServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminContentServiceHash();

  @$internal
  @override
  $ProviderElement<AdminContentService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminContentService create(Ref ref) {
    return adminContentService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminContentService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminContentService>(value),
    );
  }
}

String _$adminContentServiceHash() =>
    r'5bbb2677ad9b0c35749e3462fbd65c19adaf1027';

@ProviderFor(AdminContentList)
final adminContentListProvider = AdminContentListProvider._();

final class AdminContentListProvider
    extends $AsyncNotifierProvider<AdminContentList, List<ContentItem>> {
  AdminContentListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminContentListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminContentListHash();

  @$internal
  @override
  AdminContentList create() => AdminContentList();
}

String _$adminContentListHash() => r'c91dd091c193e906f2037399e3b79fd6f88ee9cf';

abstract class _$AdminContentList extends $AsyncNotifier<List<ContentItem>> {
  FutureOr<List<ContentItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ContentItem>>, List<ContentItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ContentItem>>, List<ContentItem>>,
              AsyncValue<List<ContentItem>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(AdminContentSave)
final adminContentSaveProvider = AdminContentSaveProvider._();

final class AdminContentSaveProvider
    extends $AsyncNotifierProvider<AdminContentSave, void> {
  AdminContentSaveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminContentSaveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminContentSaveHash();

  @$internal
  @override
  AdminContentSave create() => AdminContentSave();
}

String _$adminContentSaveHash() => r'1b34aec1d0ac5ec96df128acd501a2e9a309f700';

abstract class _$AdminContentSave extends $AsyncNotifier<void> {
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

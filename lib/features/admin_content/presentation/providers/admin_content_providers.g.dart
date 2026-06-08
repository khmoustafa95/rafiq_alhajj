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

@ProviderFor(adminContentListPage)
final adminContentListPageProvider = AdminContentListPageFamily._();

final class AdminContentListPageProvider
    extends
        $FunctionalProvider<
          AsyncValue<PaginatedResult<ContentItem>>,
          PaginatedResult<ContentItem>,
          FutureOr<PaginatedResult<ContentItem>>
        >
    with
        $FutureModifier<PaginatedResult<ContentItem>>,
        $FutureProvider<PaginatedResult<ContentItem>> {
  AdminContentListPageProvider._({
    required AdminContentListPageFamily super.from,
    required StaffTableQuery super.argument,
  }) : super(
         retry: null,
         name: r'adminContentListPageProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminContentListPageHash();

  @override
  String toString() {
    return r'adminContentListPageProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PaginatedResult<ContentItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PaginatedResult<ContentItem>> create(Ref ref) {
    final argument = this.argument as StaffTableQuery;
    return adminContentListPage(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminContentListPageProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminContentListPageHash() =>
    r'8870e165a6c69acdb3cf6b11cc45ea43753a35a9';

final class AdminContentListPageFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<PaginatedResult<ContentItem>>,
          StaffTableQuery
        > {
  AdminContentListPageFamily._()
    : super(
        retry: null,
        name: r'adminContentListPageProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminContentListPageProvider call(StaffTableQuery query) =>
      AdminContentListPageProvider._(argument: query, from: this);

  @override
  String toString() => r'adminContentListPageProvider';
}

@ProviderFor(adminContentDetail)
final adminContentDetailProvider = AdminContentDetailFamily._();

final class AdminContentDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<ContentItem?>,
          ContentItem?,
          FutureOr<ContentItem?>
        >
    with $FutureModifier<ContentItem?>, $FutureProvider<ContentItem?> {
  AdminContentDetailProvider._({
    required AdminContentDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'adminContentDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminContentDetailHash();

  @override
  String toString() {
    return r'adminContentDetailProvider'
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
    return adminContentDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminContentDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminContentDetailHash() =>
    r'f030464231739161388464f1616af3a346e389a9';

final class AdminContentDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ContentItem?>, String> {
  AdminContentDetailFamily._()
    : super(
        retry: null,
        name: r'adminContentDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminContentDetailProvider call(String id) =>
      AdminContentDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'adminContentDetailProvider';
}

@ProviderFor(AdminContentDelete)
final adminContentDeleteProvider = AdminContentDeleteProvider._();

final class AdminContentDeleteProvider
    extends $AsyncNotifierProvider<AdminContentDelete, void> {
  AdminContentDeleteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminContentDeleteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminContentDeleteHash();

  @$internal
  @override
  AdminContentDelete create() => AdminContentDelete();
}

String _$adminContentDeleteHash() =>
    r'e88b7c50fd8531026674b322e82b2ec4446fbe2d';

abstract class _$AdminContentDelete extends $AsyncNotifier<void> {
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

String _$adminContentSaveHash() => r'ea81c9454057c8360ab184f6f76dc1f74b1b2994';

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

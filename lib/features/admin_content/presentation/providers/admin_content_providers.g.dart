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

@ProviderFor(contentNotificationService)
final contentNotificationServiceProvider =
    ContentNotificationServiceProvider._();

final class ContentNotificationServiceProvider
    extends
        $FunctionalProvider<
          ContentNotificationService,
          ContentNotificationService,
          ContentNotificationService
        >
    with $Provider<ContentNotificationService> {
  ContentNotificationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'contentNotificationServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$contentNotificationServiceHash();

  @$internal
  @override
  $ProviderElement<ContentNotificationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ContentNotificationService create(Ref ref) {
    return contentNotificationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ContentNotificationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ContentNotificationService>(value),
    );
  }
}

String _$contentNotificationServiceHash() =>
    r'f699706096222e4af36665fa3a5f0d168bfcc337';

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
    r'58a83e11ea9d056466f8065774a9cbecf0bfdb8f';

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
    r'50e28d17bf99a38eb7f524ac69e882a71f05bf74';

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
    r'f97e9b6aba79796799c5430d0ea780cd5a416030';

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

String _$adminContentSaveHash() => r'6176798d578b7471dd630f607a86f85c9d57a133';

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

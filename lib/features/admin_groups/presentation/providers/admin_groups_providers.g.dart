// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_groups_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminGroupsRepository)
final adminGroupsRepositoryProvider = AdminGroupsRepositoryProvider._();

final class AdminGroupsRepositoryProvider
    extends
        $FunctionalProvider<
          AdminGroupsRepository,
          AdminGroupsRepository,
          AdminGroupsRepository
        >
    with $Provider<AdminGroupsRepository> {
  AdminGroupsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminGroupsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminGroupsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdminGroupsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminGroupsRepository create(Ref ref) {
    return adminGroupsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminGroupsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminGroupsRepository>(value),
    );
  }
}

String _$adminGroupsRepositoryHash() =>
    r'4c116b8bfaab12aa4ac2f882d01314df2a252051';

@ProviderFor(adminGroupsService)
final adminGroupsServiceProvider = AdminGroupsServiceProvider._();

final class AdminGroupsServiceProvider
    extends
        $FunctionalProvider<
          AdminGroupsService,
          AdminGroupsService,
          AdminGroupsService
        >
    with $Provider<AdminGroupsService> {
  AdminGroupsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminGroupsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminGroupsServiceHash();

  @$internal
  @override
  $ProviderElement<AdminGroupsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminGroupsService create(Ref ref) {
    return adminGroupsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminGroupsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminGroupsService>(value),
    );
  }
}

String _$adminGroupsServiceHash() =>
    r'f91083d79747305466773d994d4d8068a5b04eec';

@ProviderFor(adminGroupListPage)
final adminGroupListPageProvider = AdminGroupListPageFamily._();

final class AdminGroupListPageProvider
    extends
        $FunctionalProvider<
          AsyncValue<PaginatedResult<HajjGroup>>,
          PaginatedResult<HajjGroup>,
          FutureOr<PaginatedResult<HajjGroup>>
        >
    with
        $FutureModifier<PaginatedResult<HajjGroup>>,
        $FutureProvider<PaginatedResult<HajjGroup>> {
  AdminGroupListPageProvider._({
    required AdminGroupListPageFamily super.from,
    required StaffTableQuery super.argument,
  }) : super(
         retry: null,
         name: r'adminGroupListPageProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminGroupListPageHash();

  @override
  String toString() {
    return r'adminGroupListPageProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PaginatedResult<HajjGroup>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PaginatedResult<HajjGroup>> create(Ref ref) {
    final argument = this.argument as StaffTableQuery;
    return adminGroupListPage(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminGroupListPageProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminGroupListPageHash() =>
    r'cc49e62fe55e92ac254493c486a7a49fe5c25661';

final class AdminGroupListPageFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<PaginatedResult<HajjGroup>>,
          StaffTableQuery
        > {
  AdminGroupListPageFamily._()
    : super(
        retry: null,
        name: r'adminGroupListPageProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminGroupListPageProvider call(StaffTableQuery query) =>
      AdminGroupListPageProvider._(argument: query, from: this);

  @override
  String toString() => r'adminGroupListPageProvider';
}

@ProviderFor(adminGroupDetail)
final adminGroupDetailProvider = AdminGroupDetailFamily._();

final class AdminGroupDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<HajjGroup>,
          HajjGroup,
          FutureOr<HajjGroup>
        >
    with $FutureModifier<HajjGroup>, $FutureProvider<HajjGroup> {
  AdminGroupDetailProvider._({
    required AdminGroupDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'adminGroupDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminGroupDetailHash();

  @override
  String toString() {
    return r'adminGroupDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<HajjGroup> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<HajjGroup> create(Ref ref) {
    final argument = this.argument as String;
    return adminGroupDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminGroupDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminGroupDetailHash() => r'768bcbba8843ebfda72b524eb00d5e2bc48548d0';

final class AdminGroupDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<HajjGroup>, String> {
  AdminGroupDetailFamily._()
    : super(
        retry: null,
        name: r'adminGroupDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminGroupDetailProvider call(String id) =>
      AdminGroupDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'adminGroupDetailProvider';
}

@ProviderFor(AdminGroupSave)
final adminGroupSaveProvider = AdminGroupSaveProvider._();

final class AdminGroupSaveProvider
    extends $AsyncNotifierProvider<AdminGroupSave, void> {
  AdminGroupSaveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminGroupSaveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminGroupSaveHash();

  @$internal
  @override
  AdminGroupSave create() => AdminGroupSave();
}

String _$adminGroupSaveHash() => r'3fb7f0df8b9e6c1f4826b2e2ae7e53cf301e924e';

abstract class _$AdminGroupSave extends $AsyncNotifier<void> {
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

@ProviderFor(AdminGroupDelete)
final adminGroupDeleteProvider = AdminGroupDeleteProvider._();

final class AdminGroupDeleteProvider
    extends $AsyncNotifierProvider<AdminGroupDelete, void> {
  AdminGroupDeleteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminGroupDeleteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminGroupDeleteHash();

  @$internal
  @override
  AdminGroupDelete create() => AdminGroupDelete();
}

String _$adminGroupDeleteHash() => r'375334aa49b6b5fae689192e521ac09ee24f4ac7';

abstract class _$AdminGroupDelete extends $AsyncNotifier<void> {
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_accounts_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminAccountsRepository)
final adminAccountsRepositoryProvider = AdminAccountsRepositoryProvider._();

final class AdminAccountsRepositoryProvider
    extends
        $FunctionalProvider<
          AdminAccountsRepository,
          AdminAccountsRepository,
          AdminAccountsRepository
        >
    with $Provider<AdminAccountsRepository> {
  AdminAccountsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminAccountsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminAccountsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdminAccountsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminAccountsRepository create(Ref ref) {
    return adminAccountsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminAccountsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminAccountsRepository>(value),
    );
  }
}

String _$adminAccountsRepositoryHash() =>
    r'99eb09867064932b21cbb115a8d0c9e21b5a9618';

@ProviderFor(adminAccountsService)
final adminAccountsServiceProvider = AdminAccountsServiceProvider._();

final class AdminAccountsServiceProvider
    extends
        $FunctionalProvider<
          AdminAccountsService,
          AdminAccountsService,
          AdminAccountsService
        >
    with $Provider<AdminAccountsService> {
  AdminAccountsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminAccountsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminAccountsServiceHash();

  @$internal
  @override
  $ProviderElement<AdminAccountsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminAccountsService create(Ref ref) {
    return adminAccountsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminAccountsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminAccountsService>(value),
    );
  }
}

String _$adminAccountsServiceHash() =>
    r'9275e7e2d2d6b321c14f3af0769aa3a9bad5c781';

@ProviderFor(adminAccountListPage)
final adminAccountListPageProvider = AdminAccountListPageFamily._();

final class AdminAccountListPageProvider
    extends
        $FunctionalProvider<
          AsyncValue<PaginatedResult<AdminAccount>>,
          PaginatedResult<AdminAccount>,
          FutureOr<PaginatedResult<AdminAccount>>
        >
    with
        $FutureModifier<PaginatedResult<AdminAccount>>,
        $FutureProvider<PaginatedResult<AdminAccount>> {
  AdminAccountListPageProvider._({
    required AdminAccountListPageFamily super.from,
    required StaffTableQuery super.argument,
  }) : super(
         retry: null,
         name: r'adminAccountListPageProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminAccountListPageHash();

  @override
  String toString() {
    return r'adminAccountListPageProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PaginatedResult<AdminAccount>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PaginatedResult<AdminAccount>> create(Ref ref) {
    final argument = this.argument as StaffTableQuery;
    return adminAccountListPage(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminAccountListPageProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminAccountListPageHash() =>
    r'cba84a400438608c7d5c761adcc327aee5d42896';

final class AdminAccountListPageFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<PaginatedResult<AdminAccount>>,
          StaffTableQuery
        > {
  AdminAccountListPageFamily._()
    : super(
        retry: null,
        name: r'adminAccountListPageProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminAccountListPageProvider call(StaffTableQuery query) =>
      AdminAccountListPageProvider._(argument: query, from: this);

  @override
  String toString() => r'adminAccountListPageProvider';
}

@ProviderFor(AdminAccountPromote)
final adminAccountPromoteProvider = AdminAccountPromoteProvider._();

final class AdminAccountPromoteProvider
    extends $AsyncNotifierProvider<AdminAccountPromote, void> {
  AdminAccountPromoteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminAccountPromoteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminAccountPromoteHash();

  @$internal
  @override
  AdminAccountPromote create() => AdminAccountPromote();
}

String _$adminAccountPromoteHash() =>
    r'59cc5a7edcdea2a03bc9b01ce5c963723f62afc5';

abstract class _$AdminAccountPromote extends $AsyncNotifier<void> {
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

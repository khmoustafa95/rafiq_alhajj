// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_operators_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminOperatorsRepository)
final adminOperatorsRepositoryProvider = AdminOperatorsRepositoryProvider._();

final class AdminOperatorsRepositoryProvider
    extends
        $FunctionalProvider<
          AdminOperatorsRepository,
          AdminOperatorsRepository,
          AdminOperatorsRepository
        >
    with $Provider<AdminOperatorsRepository> {
  AdminOperatorsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminOperatorsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminOperatorsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdminOperatorsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminOperatorsRepository create(Ref ref) {
    return adminOperatorsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminOperatorsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminOperatorsRepository>(value),
    );
  }
}

String _$adminOperatorsRepositoryHash() =>
    r'2f5294cd2486d3145ca75f54dc1100a7b0e508f2';

@ProviderFor(adminOperatorsService)
final adminOperatorsServiceProvider = AdminOperatorsServiceProvider._();

final class AdminOperatorsServiceProvider
    extends
        $FunctionalProvider<
          AdminOperatorsService,
          AdminOperatorsService,
          AdminOperatorsService
        >
    with $Provider<AdminOperatorsService> {
  AdminOperatorsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminOperatorsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminOperatorsServiceHash();

  @$internal
  @override
  $ProviderElement<AdminOperatorsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminOperatorsService create(Ref ref) {
    return adminOperatorsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminOperatorsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminOperatorsService>(value),
    );
  }
}

String _$adminOperatorsServiceHash() =>
    r'814b88cd714b526cfdf12b94ccd10e8a7057aba1';

@ProviderFor(adminOperatorListPage)
final adminOperatorListPageProvider = AdminOperatorListPageFamily._();

final class AdminOperatorListPageProvider
    extends
        $FunctionalProvider<
          AsyncValue<PaginatedResult<OperatorAccount>>,
          PaginatedResult<OperatorAccount>,
          FutureOr<PaginatedResult<OperatorAccount>>
        >
    with
        $FutureModifier<PaginatedResult<OperatorAccount>>,
        $FutureProvider<PaginatedResult<OperatorAccount>> {
  AdminOperatorListPageProvider._({
    required AdminOperatorListPageFamily super.from,
    required StaffTableQuery super.argument,
  }) : super(
         retry: null,
         name: r'adminOperatorListPageProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminOperatorListPageHash();

  @override
  String toString() {
    return r'adminOperatorListPageProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PaginatedResult<OperatorAccount>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PaginatedResult<OperatorAccount>> create(Ref ref) {
    final argument = this.argument as StaffTableQuery;
    return adminOperatorListPage(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminOperatorListPageProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminOperatorListPageHash() =>
    r'36abaf66b5adedefad14f66dbacc946f13b20ac2';

final class AdminOperatorListPageFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<PaginatedResult<OperatorAccount>>,
          StaffTableQuery
        > {
  AdminOperatorListPageFamily._()
    : super(
        retry: null,
        name: r'adminOperatorListPageProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminOperatorListPageProvider call(StaffTableQuery query) =>
      AdminOperatorListPageProvider._(argument: query, from: this);

  @override
  String toString() => r'adminOperatorListPageProvider';
}

@ProviderFor(adminOperatorDetail)
final adminOperatorDetailProvider = AdminOperatorDetailFamily._();

final class AdminOperatorDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<OperatorAccount>,
          OperatorAccount,
          FutureOr<OperatorAccount>
        >
    with $FutureModifier<OperatorAccount>, $FutureProvider<OperatorAccount> {
  AdminOperatorDetailProvider._({
    required AdminOperatorDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'adminOperatorDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminOperatorDetailHash();

  @override
  String toString() {
    return r'adminOperatorDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<OperatorAccount> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<OperatorAccount> create(Ref ref) {
    final argument = this.argument as String;
    return adminOperatorDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminOperatorDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminOperatorDetailHash() =>
    r'7dc0ca9489280d9561eba67f0104fefe828de4e2';

final class AdminOperatorDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<OperatorAccount>, String> {
  AdminOperatorDetailFamily._()
    : super(
        retry: null,
        name: r'adminOperatorDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminOperatorDetailProvider call(String id) =>
      AdminOperatorDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'adminOperatorDetailProvider';
}

@ProviderFor(AdminOperatorSave)
final adminOperatorSaveProvider = AdminOperatorSaveProvider._();

final class AdminOperatorSaveProvider
    extends $AsyncNotifierProvider<AdminOperatorSave, void> {
  AdminOperatorSaveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminOperatorSaveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminOperatorSaveHash();

  @$internal
  @override
  AdminOperatorSave create() => AdminOperatorSave();
}

String _$adminOperatorSaveHash() => r'cec50d0509a3edf86686fad1f36ef5f49b94497e';

abstract class _$AdminOperatorSave extends $AsyncNotifier<void> {
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

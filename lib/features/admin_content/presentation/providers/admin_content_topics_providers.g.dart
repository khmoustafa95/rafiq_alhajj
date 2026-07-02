// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_content_topics_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminContentTopicsRepository)
final adminContentTopicsRepositoryProvider =
    AdminContentTopicsRepositoryProvider._();

final class AdminContentTopicsRepositoryProvider
    extends
        $FunctionalProvider<
          AdminContentTopicsRepository,
          AdminContentTopicsRepository,
          AdminContentTopicsRepository
        >
    with $Provider<AdminContentTopicsRepository> {
  AdminContentTopicsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminContentTopicsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminContentTopicsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdminContentTopicsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminContentTopicsRepository create(Ref ref) {
    return adminContentTopicsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminContentTopicsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminContentTopicsRepository>(value),
    );
  }
}

String _$adminContentTopicsRepositoryHash() =>
    r'0c91c9ba06ecb34eecb84a1756da598d1de8684d';

@ProviderFor(adminContentTopicsList)
final adminContentTopicsListProvider = AdminContentTopicsListProvider._();

final class AdminContentTopicsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ContentTopic>>,
          List<ContentTopic>,
          FutureOr<List<ContentTopic>>
        >
    with
        $FutureModifier<List<ContentTopic>>,
        $FutureProvider<List<ContentTopic>> {
  AdminContentTopicsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminContentTopicsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminContentTopicsListHash();

  @$internal
  @override
  $FutureProviderElement<List<ContentTopic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ContentTopic>> create(Ref ref) {
    return adminContentTopicsList(ref);
  }
}

String _$adminContentTopicsListHash() =>
    r'b72f422f5b2d0b56a821ad17c666f01c285d551c';

@ProviderFor(adminContentTopicsPage)
final adminContentTopicsPageProvider = AdminContentTopicsPageFamily._();

final class AdminContentTopicsPageProvider
    extends
        $FunctionalProvider<
          AsyncValue<PaginatedResult<ContentTopic>>,
          PaginatedResult<ContentTopic>,
          FutureOr<PaginatedResult<ContentTopic>>
        >
    with
        $FutureModifier<PaginatedResult<ContentTopic>>,
        $FutureProvider<PaginatedResult<ContentTopic>> {
  AdminContentTopicsPageProvider._({
    required AdminContentTopicsPageFamily super.from,
    required StaffTableQuery super.argument,
  }) : super(
         retry: null,
         name: r'adminContentTopicsPageProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminContentTopicsPageHash();

  @override
  String toString() {
    return r'adminContentTopicsPageProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PaginatedResult<ContentTopic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PaginatedResult<ContentTopic>> create(Ref ref) {
    final argument = this.argument as StaffTableQuery;
    return adminContentTopicsPage(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminContentTopicsPageProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminContentTopicsPageHash() =>
    r'9b70ac64f929b80b672b6683e8ba0655605458b2';

final class AdminContentTopicsPageFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<PaginatedResult<ContentTopic>>,
          StaffTableQuery
        > {
  AdminContentTopicsPageFamily._()
    : super(
        retry: null,
        name: r'adminContentTopicsPageProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminContentTopicsPageProvider call(StaffTableQuery query) =>
      AdminContentTopicsPageProvider._(argument: query, from: this);

  @override
  String toString() => r'adminContentTopicsPageProvider';
}

@ProviderFor(adminContentTopicDetail)
final adminContentTopicDetailProvider = AdminContentTopicDetailFamily._();

final class AdminContentTopicDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<ContentTopic?>,
          ContentTopic?,
          FutureOr<ContentTopic?>
        >
    with $FutureModifier<ContentTopic?>, $FutureProvider<ContentTopic?> {
  AdminContentTopicDetailProvider._({
    required AdminContentTopicDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'adminContentTopicDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminContentTopicDetailHash();

  @override
  String toString() {
    return r'adminContentTopicDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ContentTopic?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ContentTopic?> create(Ref ref) {
    final argument = this.argument as String;
    return adminContentTopicDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminContentTopicDetailProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminContentTopicDetailHash() =>
    r'd83974951400065fca054c07e822bd2b2d1b235d';

final class AdminContentTopicDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ContentTopic?>, String> {
  AdminContentTopicDetailFamily._()
    : super(
        retry: null,
        name: r'adminContentTopicDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminContentTopicDetailProvider call(String id) =>
      AdminContentTopicDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'adminContentTopicDetailProvider';
}

@ProviderFor(AdminContentTopicSave)
final adminContentTopicSaveProvider = AdminContentTopicSaveProvider._();

final class AdminContentTopicSaveProvider
    extends $AsyncNotifierProvider<AdminContentTopicSave, void> {
  AdminContentTopicSaveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminContentTopicSaveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminContentTopicSaveHash();

  @$internal
  @override
  AdminContentTopicSave create() => AdminContentTopicSave();
}

String _$adminContentTopicSaveHash() =>
    r'8cb6d9d2253663e27ada279b98fc2e33de0697b5';

abstract class _$AdminContentTopicSave extends $AsyncNotifier<void> {
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

@ProviderFor(AdminContentTopicDelete)
final adminContentTopicDeleteProvider = AdminContentTopicDeleteProvider._();

final class AdminContentTopicDeleteProvider
    extends $AsyncNotifierProvider<AdminContentTopicDelete, void> {
  AdminContentTopicDeleteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminContentTopicDeleteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminContentTopicDeleteHash();

  @$internal
  @override
  AdminContentTopicDelete create() => AdminContentTopicDelete();
}

String _$adminContentTopicDeleteHash() =>
    r'a307e153b546e71acdaf3e4a2949763db91b5230';

abstract class _$AdminContentTopicDelete extends $AsyncNotifier<void> {
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

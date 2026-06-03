// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'competitions_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(competitionsRepository)
final competitionsRepositoryProvider = CompetitionsRepositoryProvider._();

final class CompetitionsRepositoryProvider
    extends
        $FunctionalProvider<
          CompetitionsRepository,
          CompetitionsRepository,
          CompetitionsRepository
        >
    with $Provider<CompetitionsRepository> {
  CompetitionsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'competitionsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$competitionsRepositoryHash();

  @$internal
  @override
  $ProviderElement<CompetitionsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CompetitionsRepository create(Ref ref) {
    return competitionsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompetitionsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompetitionsRepository>(value),
    );
  }
}

String _$competitionsRepositoryHash() =>
    r'72924f7fec22edbd22623898bbdc32a438c4412b';

@ProviderFor(adminCompetitionsRepository)
final adminCompetitionsRepositoryProvider =
    AdminCompetitionsRepositoryProvider._();

final class AdminCompetitionsRepositoryProvider
    extends
        $FunctionalProvider<
          AdminCompetitionsRepository,
          AdminCompetitionsRepository,
          AdminCompetitionsRepository
        >
    with $Provider<AdminCompetitionsRepository> {
  AdminCompetitionsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminCompetitionsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminCompetitionsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdminCompetitionsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminCompetitionsRepository create(Ref ref) {
    return adminCompetitionsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminCompetitionsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminCompetitionsRepository>(value),
    );
  }
}

String _$adminCompetitionsRepositoryHash() =>
    r'baf4f83306a901e2a31e2e4af6ab47974d259ec8';

@ProviderFor(activeCompetitions)
final activeCompetitionsProvider = ActiveCompetitionsProvider._();

final class ActiveCompetitionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Competition>>,
          List<Competition>,
          FutureOr<List<Competition>>
        >
    with
        $FutureModifier<List<Competition>>,
        $FutureProvider<List<Competition>> {
  ActiveCompetitionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeCompetitionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeCompetitionsHash();

  @$internal
  @override
  $FutureProviderElement<List<Competition>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Competition>> create(Ref ref) {
    return activeCompetitions(ref);
  }
}

String _$activeCompetitionsHash() =>
    r'7f2af2d0ba4e41e7d2056d74c9328afae9566ac6';

@ProviderFor(CompetitionDetail)
final competitionDetailProvider = CompetitionDetailFamily._();

final class CompetitionDetailProvider
    extends $AsyncNotifierProvider<CompetitionDetail, CompetitionWithEntries?> {
  CompetitionDetailProvider._({
    required CompetitionDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'competitionDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$competitionDetailHash();

  @override
  String toString() {
    return r'competitionDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CompetitionDetail create() => CompetitionDetail();

  @override
  bool operator ==(Object other) {
    return other is CompetitionDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$competitionDetailHash() => r'94caf520e2812f28b4095b0f4f47d798ef40e57a';

final class CompetitionDetailFamily extends $Family
    with
        $ClassFamilyOverride<
          CompetitionDetail,
          AsyncValue<CompetitionWithEntries?>,
          CompetitionWithEntries?,
          FutureOr<CompetitionWithEntries?>,
          String
        > {
  CompetitionDetailFamily._()
    : super(
        retry: null,
        name: r'competitionDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CompetitionDetailProvider call(String competitionId) =>
      CompetitionDetailProvider._(argument: competitionId, from: this);

  @override
  String toString() => r'competitionDetailProvider';
}

abstract class _$CompetitionDetail
    extends $AsyncNotifier<CompetitionWithEntries?> {
  late final _$args = ref.$arg as String;
  String get competitionId => _$args;

  FutureOr<CompetitionWithEntries?> build(String competitionId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<CompetitionWithEntries?>,
              CompetitionWithEntries?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CompetitionWithEntries?>,
                CompetitionWithEntries?
              >,
              AsyncValue<CompetitionWithEntries?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(AdminCompetitionList)
final adminCompetitionListProvider = AdminCompetitionListProvider._();

final class AdminCompetitionListProvider
    extends $AsyncNotifierProvider<AdminCompetitionList, List<Competition>> {
  AdminCompetitionListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminCompetitionListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminCompetitionListHash();

  @$internal
  @override
  AdminCompetitionList create() => AdminCompetitionList();
}

String _$adminCompetitionListHash() =>
    r'ad1fc194a3ad15a7e8b7dbb5194adb889b5ebb2a';

abstract class _$AdminCompetitionList
    extends $AsyncNotifier<List<Competition>> {
  FutureOr<List<Competition>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<Competition>>, List<Competition>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Competition>>, List<Competition>>,
              AsyncValue<List<Competition>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(AdminCompetitionSave)
final adminCompetitionSaveProvider = AdminCompetitionSaveProvider._();

final class AdminCompetitionSaveProvider
    extends $AsyncNotifierProvider<AdminCompetitionSave, void> {
  AdminCompetitionSaveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminCompetitionSaveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminCompetitionSaveHash();

  @$internal
  @override
  AdminCompetitionSave create() => AdminCompetitionSave();
}

String _$adminCompetitionSaveHash() =>
    r'58e1d00b46fe9207a71f6ba749bf836b08c87c67';

abstract class _$AdminCompetitionSave extends $AsyncNotifier<void> {
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

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

@ProviderFor(competitionQuestionsRepository)
final competitionQuestionsRepositoryProvider =
    CompetitionQuestionsRepositoryProvider._();

final class CompetitionQuestionsRepositoryProvider
    extends
        $FunctionalProvider<
          CompetitionQuestionsRepository,
          CompetitionQuestionsRepository,
          CompetitionQuestionsRepository
        >
    with $Provider<CompetitionQuestionsRepository> {
  CompetitionQuestionsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'competitionQuestionsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$competitionQuestionsRepositoryHash();

  @$internal
  @override
  $ProviderElement<CompetitionQuestionsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CompetitionQuestionsRepository create(Ref ref) {
    return competitionQuestionsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompetitionQuestionsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompetitionQuestionsRepository>(
        value,
      ),
    );
  }
}

String _$competitionQuestionsRepositoryHash() =>
    r'20e7dd36f2d3e1a633f3438057108b34c0e12d2f';

@ProviderFor(adminCompetitionQuestionsRepository)
final adminCompetitionQuestionsRepositoryProvider =
    AdminCompetitionQuestionsRepositoryProvider._();

final class AdminCompetitionQuestionsRepositoryProvider
    extends
        $FunctionalProvider<
          AdminCompetitionQuestionsRepository,
          AdminCompetitionQuestionsRepository,
          AdminCompetitionQuestionsRepository
        >
    with $Provider<AdminCompetitionQuestionsRepository> {
  AdminCompetitionQuestionsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminCompetitionQuestionsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$adminCompetitionQuestionsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdminCompetitionQuestionsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminCompetitionQuestionsRepository create(Ref ref) {
    return adminCompetitionQuestionsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminCompetitionQuestionsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminCompetitionQuestionsRepository>(
        value,
      ),
    );
  }
}

String _$adminCompetitionQuestionsRepositoryHash() =>
    r'281005ecb127c5b563525d093951eff3ce4caded';

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
    r'5fee5ee9ac4f0260751c25f63700cefc84a762f9';

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

String _$competitionDetailHash() => r'fdb7cbda7e320a647852e9a89de3ba8ee8ae84d0';

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

@ProviderFor(competitionQuizProgress)
final competitionQuizProgressProvider = CompetitionQuizProgressFamily._();

final class CompetitionQuizProgressProvider
    extends
        $FunctionalProvider<
          AsyncValue<CompetitionQuizProgress>,
          CompetitionQuizProgress,
          FutureOr<CompetitionQuizProgress>
        >
    with
        $FutureModifier<CompetitionQuizProgress>,
        $FutureProvider<CompetitionQuizProgress> {
  CompetitionQuizProgressProvider._({
    required CompetitionQuizProgressFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'competitionQuizProgressProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$competitionQuizProgressHash();

  @override
  String toString() {
    return r'competitionQuizProgressProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CompetitionQuizProgress> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CompetitionQuizProgress> create(Ref ref) {
    final argument = this.argument as String;
    return competitionQuizProgress(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CompetitionQuizProgressProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$competitionQuizProgressHash() =>
    r'd8c60ebde3d369f175e28dec14f594d06e0c0441';

final class CompetitionQuizProgressFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CompetitionQuizProgress>, String> {
  CompetitionQuizProgressFamily._()
    : super(
        retry: null,
        name: r'competitionQuizProgressProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CompetitionQuizProgressProvider call(String competitionId) =>
      CompetitionQuizProgressProvider._(argument: competitionId, from: this);

  @override
  String toString() => r'competitionQuizProgressProvider';
}

@ProviderFor(CompetitionQuizSubmit)
final competitionQuizSubmitProvider = CompetitionQuizSubmitProvider._();

final class CompetitionQuizSubmitProvider
    extends
        $AsyncNotifierProvider<
          CompetitionQuizSubmit,
          CompetitionAnswerResult?
        > {
  CompetitionQuizSubmitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'competitionQuizSubmitProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$competitionQuizSubmitHash();

  @$internal
  @override
  CompetitionQuizSubmit create() => CompetitionQuizSubmit();
}

String _$competitionQuizSubmitHash() =>
    r'de24b8d283e7f5f637eb137469a4a13fac8426b7';

abstract class _$CompetitionQuizSubmit
    extends $AsyncNotifier<CompetitionAnswerResult?> {
  FutureOr<CompetitionAnswerResult?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<CompetitionAnswerResult?>,
              CompetitionAnswerResult?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CompetitionAnswerResult?>,
                CompetitionAnswerResult?
              >,
              AsyncValue<CompetitionAnswerResult?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(adminCompetitionQuestions)
final adminCompetitionQuestionsProvider = AdminCompetitionQuestionsFamily._();

final class AdminCompetitionQuestionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CompetitionQuestion>>,
          List<CompetitionQuestion>,
          FutureOr<List<CompetitionQuestion>>
        >
    with
        $FutureModifier<List<CompetitionQuestion>>,
        $FutureProvider<List<CompetitionQuestion>> {
  AdminCompetitionQuestionsProvider._({
    required AdminCompetitionQuestionsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'adminCompetitionQuestionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminCompetitionQuestionsHash();

  @override
  String toString() {
    return r'adminCompetitionQuestionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<CompetitionQuestion>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CompetitionQuestion>> create(Ref ref) {
    final argument = this.argument as String;
    return adminCompetitionQuestions(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminCompetitionQuestionsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminCompetitionQuestionsHash() =>
    r'44cea754e6e60dddbc3a1074dd5bae84d0047db1';

final class AdminCompetitionQuestionsFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<List<CompetitionQuestion>>, String> {
  AdminCompetitionQuestionsFamily._()
    : super(
        retry: null,
        name: r'adminCompetitionQuestionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminCompetitionQuestionsProvider call(String competitionId) =>
      AdminCompetitionQuestionsProvider._(argument: competitionId, from: this);

  @override
  String toString() => r'adminCompetitionQuestionsProvider';
}

@ProviderFor(AdminCompetitionQuestionSave)
final adminCompetitionQuestionSaveProvider =
    AdminCompetitionQuestionSaveProvider._();

final class AdminCompetitionQuestionSaveProvider
    extends $AsyncNotifierProvider<AdminCompetitionQuestionSave, void> {
  AdminCompetitionQuestionSaveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminCompetitionQuestionSaveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminCompetitionQuestionSaveHash();

  @$internal
  @override
  AdminCompetitionQuestionSave create() => AdminCompetitionQuestionSave();
}

String _$adminCompetitionQuestionSaveHash() =>
    r'021a1a07f08dca070b4cb89fb76fb236eebf730b';

abstract class _$AdminCompetitionQuestionSave extends $AsyncNotifier<void> {
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

@ProviderFor(AdminCompetitionQuestionDelete)
final adminCompetitionQuestionDeleteProvider =
    AdminCompetitionQuestionDeleteProvider._();

final class AdminCompetitionQuestionDeleteProvider
    extends $AsyncNotifierProvider<AdminCompetitionQuestionDelete, void> {
  AdminCompetitionQuestionDeleteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminCompetitionQuestionDeleteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminCompetitionQuestionDeleteHash();

  @$internal
  @override
  AdminCompetitionQuestionDelete create() => AdminCompetitionQuestionDelete();
}

String _$adminCompetitionQuestionDeleteHash() =>
    r'a29a570726b92cd221aeab73fc2acc94b97268e2';

abstract class _$AdminCompetitionQuestionDelete extends $AsyncNotifier<void> {
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
    r'3e47255891ba03f0c445f450fbf986c40e20211a';

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

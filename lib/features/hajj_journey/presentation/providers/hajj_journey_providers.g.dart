// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hajj_journey_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hajjJourneyRepository)
final hajjJourneyRepositoryProvider = HajjJourneyRepositoryProvider._();

final class HajjJourneyRepositoryProvider
    extends
        $FunctionalProvider<
          HajjJourneyRepository,
          HajjJourneyRepository,
          HajjJourneyRepository
        >
    with $Provider<HajjJourneyRepository> {
  HajjJourneyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hajjJourneyRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hajjJourneyRepositoryHash();

  @$internal
  @override
  $ProviderElement<HajjJourneyRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HajjJourneyRepository create(Ref ref) {
    return hajjJourneyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HajjJourneyRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HajjJourneyRepository>(value),
    );
  }
}

String _$hajjJourneyRepositoryHash() =>
    r'a860330b0c4dbc3f7aad261ac0eaa960899fd539';

@ProviderFor(adminHajjJourneyRepository)
final adminHajjJourneyRepositoryProvider =
    AdminHajjJourneyRepositoryProvider._();

final class AdminHajjJourneyRepositoryProvider
    extends
        $FunctionalProvider<
          AdminHajjJourneyRepository,
          AdminHajjJourneyRepository,
          AdminHajjJourneyRepository
        >
    with $Provider<AdminHajjJourneyRepository> {
  AdminHajjJourneyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminHajjJourneyRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminHajjJourneyRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdminHajjJourneyRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminHajjJourneyRepository create(Ref ref) {
    return adminHajjJourneyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminHajjJourneyRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminHajjJourneyRepository>(value),
    );
  }
}

String _$adminHajjJourneyRepositoryHash() =>
    r'd8a32a693c3ff76786396e89e7433bdf32dc1a18';

@ProviderFor(hajjJourneySteps)
final hajjJourneyStepsProvider = HajjJourneyStepsProvider._();

final class HajjJourneyStepsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HajjJourneyStep>>,
          List<HajjJourneyStep>,
          FutureOr<List<HajjJourneyStep>>
        >
    with
        $FutureModifier<List<HajjJourneyStep>>,
        $FutureProvider<List<HajjJourneyStep>> {
  HajjJourneyStepsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hajjJourneyStepsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hajjJourneyStepsHash();

  @$internal
  @override
  $FutureProviderElement<List<HajjJourneyStep>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HajjJourneyStep>> create(Ref ref) {
    return hajjJourneySteps(ref);
  }
}

String _$hajjJourneyStepsHash() => r'89c998f22a6b99ba4ad42bd448b844c2e8014277';

@ProviderFor(hajjJourneyStepByKey)
final hajjJourneyStepByKeyProvider = HajjJourneyStepByKeyFamily._();

final class HajjJourneyStepByKeyProvider
    extends
        $FunctionalProvider<
          AsyncValue<HajjJourneyStep?>,
          HajjJourneyStep?,
          FutureOr<HajjJourneyStep?>
        >
    with $FutureModifier<HajjJourneyStep?>, $FutureProvider<HajjJourneyStep?> {
  HajjJourneyStepByKeyProvider._({
    required HajjJourneyStepByKeyFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'hajjJourneyStepByKeyProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hajjJourneyStepByKeyHash();

  @override
  String toString() {
    return r'hajjJourneyStepByKeyProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<HajjJourneyStep?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HajjJourneyStep?> create(Ref ref) {
    final argument = this.argument as String;
    return hajjJourneyStepByKey(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HajjJourneyStepByKeyProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hajjJourneyStepByKeyHash() =>
    r'1d950359b4351e3bcc1ad17b9ddd6db5c78644ee';

final class HajjJourneyStepByKeyFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<HajjJourneyStep?>, String> {
  HajjJourneyStepByKeyFamily._()
    : super(
        retry: null,
        name: r'hajjJourneyStepByKeyProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HajjJourneyStepByKeyProvider call(String ritualKey) =>
      HajjJourneyStepByKeyProvider._(argument: ritualKey, from: this);

  @override
  String toString() => r'hajjJourneyStepByKeyProvider';
}

@ProviderFor(hajjJourneyState)
final hajjJourneyStateProvider = HajjJourneyStateProvider._();

final class HajjJourneyStateProvider
    extends
        $FunctionalProvider<
          AsyncValue<HajjJourneyState>,
          HajjJourneyState,
          FutureOr<HajjJourneyState>
        >
    with $FutureModifier<HajjJourneyState>, $FutureProvider<HajjJourneyState> {
  HajjJourneyStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hajjJourneyStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hajjJourneyStateHash();

  @$internal
  @override
  $FutureProviderElement<HajjJourneyState> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HajjJourneyState> create(Ref ref) {
    return hajjJourneyState(ref);
  }
}

String _$hajjJourneyStateHash() => r'82fd4eb3d1ba2a30e5ca13d459cd344806647fc5';

@ProviderFor(adminHajjJourneySteps)
final adminHajjJourneyStepsProvider = AdminHajjJourneyStepsProvider._();

final class AdminHajjJourneyStepsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HajjJourneyStep>>,
          List<HajjJourneyStep>,
          FutureOr<List<HajjJourneyStep>>
        >
    with
        $FutureModifier<List<HajjJourneyStep>>,
        $FutureProvider<List<HajjJourneyStep>> {
  AdminHajjJourneyStepsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminHajjJourneyStepsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminHajjJourneyStepsHash();

  @$internal
  @override
  $FutureProviderElement<List<HajjJourneyStep>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HajjJourneyStep>> create(Ref ref) {
    return adminHajjJourneySteps(ref);
  }
}

String _$adminHajjJourneyStepsHash() =>
    r'ec5d5a8bd78bd76329d7ac1a38de47e245d02f07';

@ProviderFor(adminHajjJourneyStep)
final adminHajjJourneyStepProvider = AdminHajjJourneyStepFamily._();

final class AdminHajjJourneyStepProvider
    extends
        $FunctionalProvider<
          AsyncValue<HajjJourneyStep?>,
          HajjJourneyStep?,
          FutureOr<HajjJourneyStep?>
        >
    with $FutureModifier<HajjJourneyStep?>, $FutureProvider<HajjJourneyStep?> {
  AdminHajjJourneyStepProvider._({
    required AdminHajjJourneyStepFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'adminHajjJourneyStepProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adminHajjJourneyStepHash();

  @override
  String toString() {
    return r'adminHajjJourneyStepProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<HajjJourneyStep?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HajjJourneyStep?> create(Ref ref) {
    final argument = this.argument as String;
    return adminHajjJourneyStep(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminHajjJourneyStepProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminHajjJourneyStepHash() =>
    r'e4a9216d9ebcd71684b12e6e2fd6bdeca424abf7';

final class AdminHajjJourneyStepFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<HajjJourneyStep?>, String> {
  AdminHajjJourneyStepFamily._()
    : super(
        retry: null,
        name: r'adminHajjJourneyStepProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AdminHajjJourneyStepProvider call(String ritualKey) =>
      AdminHajjJourneyStepProvider._(argument: ritualKey, from: this);

  @override
  String toString() => r'adminHajjJourneyStepProvider';
}

@ProviderFor(AdminHajjJourneySave)
final adminHajjJourneySaveProvider = AdminHajjJourneySaveProvider._();

final class AdminHajjJourneySaveProvider
    extends $AsyncNotifierProvider<AdminHajjJourneySave, void> {
  AdminHajjJourneySaveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminHajjJourneySaveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminHajjJourneySaveHash();

  @$internal
  @override
  AdminHajjJourneySave create() => AdminHajjJourneySave();
}

String _$adminHajjJourneySaveHash() =>
    r'd6bebb749144127ee38c7c04b48e4ae3e104cbc5';

abstract class _$AdminHajjJourneySave extends $AsyncNotifier<void> {
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

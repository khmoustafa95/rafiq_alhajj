// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationPreferencesRepository)
final notificationPreferencesRepositoryProvider =
    NotificationPreferencesRepositoryProvider._();

final class NotificationPreferencesRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationPreferencesRepository,
          NotificationPreferencesRepository,
          NotificationPreferencesRepository
        >
    with $Provider<NotificationPreferencesRepository> {
  NotificationPreferencesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPreferencesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$notificationPreferencesRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationPreferencesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationPreferencesRepository create(Ref ref) {
    return notificationPreferencesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationPreferencesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationPreferencesRepository>(
        value,
      ),
    );
  }
}

String _$notificationPreferencesRepositoryHash() =>
    r'0aa9555bc76b04b9356b7211b97b78761f5afdf2';

@ProviderFor(pushDispatchFailureRepository)
final pushDispatchFailureRepositoryProvider =
    PushDispatchFailureRepositoryProvider._();

final class PushDispatchFailureRepositoryProvider
    extends
        $FunctionalProvider<
          PushDispatchFailureRepository,
          PushDispatchFailureRepository,
          PushDispatchFailureRepository
        >
    with $Provider<PushDispatchFailureRepository> {
  PushDispatchFailureRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushDispatchFailureRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushDispatchFailureRepositoryHash();

  @$internal
  @override
  $ProviderElement<PushDispatchFailureRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PushDispatchFailureRepository create(Ref ref) {
    return pushDispatchFailureRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PushDispatchFailureRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PushDispatchFailureRepository>(
        value,
      ),
    );
  }
}

String _$pushDispatchFailureRepositoryHash() =>
    r'a4b0b0eacc6e66048cd07d487fb46dd8a1de0e12';

@ProviderFor(notificationPreferences)
final notificationPreferencesProvider = NotificationPreferencesProvider._();

final class NotificationPreferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<NotificationPreferences>,
          NotificationPreferences,
          FutureOr<NotificationPreferences>
        >
    with
        $FutureModifier<NotificationPreferences>,
        $FutureProvider<NotificationPreferences> {
  NotificationPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPreferencesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<NotificationPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NotificationPreferences> create(Ref ref) {
    return notificationPreferences(ref);
  }
}

String _$notificationPreferencesHash() =>
    r'27d148ef0376f8124dc6dcec014858503e7d64f7';

@ProviderFor(NotificationPreferencesSave)
final notificationPreferencesSaveProvider =
    NotificationPreferencesSaveProvider._();

final class NotificationPreferencesSaveProvider
    extends $AsyncNotifierProvider<NotificationPreferencesSave, void> {
  NotificationPreferencesSaveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationPreferencesSaveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationPreferencesSaveHash();

  @$internal
  @override
  NotificationPreferencesSave create() => NotificationPreferencesSave();
}

String _$notificationPreferencesSaveHash() =>
    r'a11797ebbe0a7d820bfe1cd3b5e11c07a5305d4a';

abstract class _$NotificationPreferencesSave extends $AsyncNotifier<void> {
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

@ProviderFor(adminPushDispatchFailures)
final adminPushDispatchFailuresProvider = AdminPushDispatchFailuresProvider._();

final class AdminPushDispatchFailuresProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PushDispatchFailure>>,
          List<PushDispatchFailure>,
          FutureOr<List<PushDispatchFailure>>
        >
    with
        $FutureModifier<List<PushDispatchFailure>>,
        $FutureProvider<List<PushDispatchFailure>> {
  AdminPushDispatchFailuresProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminPushDispatchFailuresProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminPushDispatchFailuresHash();

  @$internal
  @override
  $FutureProviderElement<List<PushDispatchFailure>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PushDispatchFailure>> create(Ref ref) {
    return adminPushDispatchFailures(ref);
  }
}

String _$adminPushDispatchFailuresHash() =>
    r'f47f1cd5ce2922608c684d48b3bbc3394b6c5ca9';

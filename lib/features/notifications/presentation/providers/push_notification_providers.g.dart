// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceTokenRepository)
final deviceTokenRepositoryProvider = DeviceTokenRepositoryProvider._();

final class DeviceTokenRepositoryProvider
    extends
        $FunctionalProvider<
          DeviceTokenRepository,
          DeviceTokenRepository,
          DeviceTokenRepository
        >
    with $Provider<DeviceTokenRepository> {
  DeviceTokenRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceTokenRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceTokenRepositoryHash();

  @$internal
  @override
  $ProviderElement<DeviceTokenRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceTokenRepository create(Ref ref) {
    return deviceTokenRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceTokenRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceTokenRepository>(value),
    );
  }
}

String _$deviceTokenRepositoryHash() =>
    r'54f9b106126873adaf5178676f946278f2f3273b';

@ProviderFor(pushNotificationService)
final pushNotificationServiceProvider = PushNotificationServiceProvider._();

final class PushNotificationServiceProvider
    extends
        $FunctionalProvider<
          PushNotificationService,
          PushNotificationService,
          PushNotificationService
        >
    with $Provider<PushNotificationService> {
  PushNotificationServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushNotificationServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushNotificationServiceHash();

  @$internal
  @override
  $ProviderElement<PushNotificationService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PushNotificationService create(Ref ref) {
    return pushNotificationService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PushNotificationService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PushNotificationService>(value),
    );
  }
}

String _$pushNotificationServiceHash() =>
    r'105afceba88357cc82f227e3b6d03edcbbf03f50';

@ProviderFor(pushNotificationInit)
final pushNotificationInitProvider = PushNotificationInitProvider._();

final class PushNotificationInitProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  PushNotificationInitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushNotificationInitProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushNotificationInitHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return pushNotificationInit(ref);
  }
}

String _$pushNotificationInitHash() =>
    r'a8df1e4e1b698f1b46631afeb6ea8002d98a2f9f';

/// Initializes FCM and syncs tokens with the signed-in user.

@ProviderFor(pushNotificationBinding)
final pushNotificationBindingProvider = PushNotificationBindingProvider._();

/// Initializes FCM and syncs tokens with the signed-in user.

final class PushNotificationBindingProvider
    extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Initializes FCM and syncs tokens with the signed-in user.
  PushNotificationBindingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushNotificationBindingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushNotificationBindingHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return pushNotificationBinding(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$pushNotificationBindingHash() =>
    r'f25a6cbfe6f0dce09e6888da3ffdcf0a454b4088';

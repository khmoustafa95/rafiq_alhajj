// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(notificationRepository)
final notificationRepositoryProvider = NotificationRepositoryProvider._();

final class NotificationRepositoryProvider
    extends
        $FunctionalProvider<
          NotificationRepository,
          NotificationRepository,
          NotificationRepository
        >
    with $Provider<NotificationRepository> {
  NotificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<NotificationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  NotificationRepository create(Ref ref) {
    return notificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NotificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NotificationRepository>(value),
    );
  }
}

String _$notificationRepositoryHash() =>
    r'b9c2d29fc769bc0ca48b5bfa6ec71fd6c956d5bb';

@ProviderFor(guestNotificationsSeenStore)
final guestNotificationsSeenStoreProvider =
    GuestNotificationsSeenStoreProvider._();

final class GuestNotificationsSeenStoreProvider
    extends
        $FunctionalProvider<
          GuestNotificationsSeenStore,
          GuestNotificationsSeenStore,
          GuestNotificationsSeenStore
        >
    with $Provider<GuestNotificationsSeenStore> {
  GuestNotificationsSeenStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guestNotificationsSeenStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guestNotificationsSeenStoreHash();

  @$internal
  @override
  $ProviderElement<GuestNotificationsSeenStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GuestNotificationsSeenStore create(Ref ref) {
    return guestNotificationsSeenStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GuestNotificationsSeenStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GuestNotificationsSeenStore>(value),
    );
  }
}

String _$guestNotificationsSeenStoreHash() =>
    r'040e23b08c5b756c67b51cf68b1cdac8054f5201';

@ProviderFor(unreadNotificationCount)
final unreadNotificationCountProvider = UnreadNotificationCountProvider._();

final class UnreadNotificationCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  UnreadNotificationCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unreadNotificationCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadNotificationCountHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return unreadNotificationCount(ref);
  }
}

String _$unreadNotificationCountHash() =>
    r'a8f3dd0b77071e7305fcacb9cd933f20399cd267';

@ProviderFor(NotificationInbox)
final notificationInboxProvider = NotificationInboxProvider._();

final class NotificationInboxProvider
    extends $AsyncNotifierProvider<NotificationInbox, List<InboxNotification>> {
  NotificationInboxProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationInboxProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationInboxHash();

  @$internal
  @override
  NotificationInbox create() => NotificationInbox();
}

String _$notificationInboxHash() => r'4dfafcf29086d310eb1c66695ee17387f2a69adf';

abstract class _$NotificationInbox
    extends $AsyncNotifier<List<InboxNotification>> {
  FutureOr<List<InboxNotification>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<InboxNotification>>,
              List<InboxNotification>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<InboxNotification>>,
                List<InboxNotification>
              >,
              AsyncValue<List<InboxNotification>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(notificationGroups)
final notificationGroupsProvider = NotificationGroupsProvider._();

final class NotificationGroupsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<NotificationGroupOption>>,
          List<NotificationGroupOption>,
          FutureOr<List<NotificationGroupOption>>
        >
    with
        $FutureModifier<List<NotificationGroupOption>>,
        $FutureProvider<List<NotificationGroupOption>> {
  NotificationGroupsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationGroupsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationGroupsHash();

  @$internal
  @override
  $FutureProviderElement<List<NotificationGroupOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<NotificationGroupOption>> create(Ref ref) {
    return notificationGroups(ref);
  }
}

String _$notificationGroupsHash() =>
    r'30705cea72e70b08ebc8958e86e8b7bb60813543';

@ProviderFor(notificationToastEvents)
final notificationToastEventsProvider = NotificationToastEventsProvider._();

final class NotificationToastEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<InboxNotification>,
          InboxNotification,
          Stream<InboxNotification>
        >
    with
        $FutureModifier<InboxNotification>,
        $StreamProvider<InboxNotification> {
  NotificationToastEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationToastEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationToastEventsHash();

  @$internal
  @override
  $StreamProviderElement<InboxNotification> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<InboxNotification> create(Ref ref) {
    return notificationToastEvents(ref);
  }
}

String _$notificationToastEventsHash() =>
    r'e08db4b4835000059f820af9a4858f2a98b95e29';

@ProviderFor(AdminNotificationBroadcast)
final adminNotificationBroadcastProvider =
    AdminNotificationBroadcastProvider._();

final class AdminNotificationBroadcastProvider
    extends $AsyncNotifierProvider<AdminNotificationBroadcast, void> {
  AdminNotificationBroadcastProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminNotificationBroadcastProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminNotificationBroadcastHash();

  @$internal
  @override
  AdminNotificationBroadcast create() => AdminNotificationBroadcast();
}

String _$adminNotificationBroadcastHash() =>
    r'fb9a7bb893bf1df729f051e16675ae42da6a4ea4';

abstract class _$AdminNotificationBroadcast extends $AsyncNotifier<void> {
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

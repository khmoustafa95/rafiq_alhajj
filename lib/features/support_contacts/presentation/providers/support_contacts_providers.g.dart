// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_contacts_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(supportContactsRepository)
final supportContactsRepositoryProvider = SupportContactsRepositoryProvider._();

final class SupportContactsRepositoryProvider
    extends
        $FunctionalProvider<
          SupportContactsRepository,
          SupportContactsRepository,
          SupportContactsRepository
        >
    with $Provider<SupportContactsRepository> {
  SupportContactsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supportContactsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supportContactsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SupportContactsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SupportContactsRepository create(Ref ref) {
    return supportContactsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupportContactsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupportContactsRepository>(value),
    );
  }
}

String _$supportContactsRepositoryHash() =>
    r'045f2b58d51e84e00d84507f0fb38ab9ddcbef5b';

@ProviderFor(supportContactsService)
final supportContactsServiceProvider = SupportContactsServiceProvider._();

final class SupportContactsServiceProvider
    extends
        $FunctionalProvider<
          SupportContactsService,
          SupportContactsService,
          SupportContactsService
        >
    with $Provider<SupportContactsService> {
  SupportContactsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supportContactsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supportContactsServiceHash();

  @$internal
  @override
  $ProviderElement<SupportContactsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SupportContactsService create(Ref ref) {
    return supportContactsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupportContactsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupportContactsService>(value),
    );
  }
}

String _$supportContactsServiceHash() =>
    r'5061e6a079cb5b3bbfd8affe1321809c3f1ae43d';

/// Contacts visible to the current pilgrim / guest.

@ProviderFor(supportContacts)
final supportContactsProvider = SupportContactsProvider._();

/// Contacts visible to the current pilgrim / guest.

final class SupportContactsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SupportContact>>,
          List<SupportContact>,
          FutureOr<List<SupportContact>>
        >
    with
        $FutureModifier<List<SupportContact>>,
        $FutureProvider<List<SupportContact>> {
  /// Contacts visible to the current pilgrim / guest.
  SupportContactsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supportContactsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supportContactsHash();

  @$internal
  @override
  $FutureProviderElement<List<SupportContact>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SupportContact>> create(Ref ref) {
    return supportContacts(ref);
  }
}

String _$supportContactsHash() => r'f0c55001805f41c6e5251fc4ad2986318d2b4897';

/// Every contact (admin management view).

@ProviderFor(adminSupportContacts)
final adminSupportContactsProvider = AdminSupportContactsProvider._();

/// Every contact (admin management view).

final class AdminSupportContactsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SupportContact>>,
          List<SupportContact>,
          FutureOr<List<SupportContact>>
        >
    with
        $FutureModifier<List<SupportContact>>,
        $FutureProvider<List<SupportContact>> {
  /// Every contact (admin management view).
  AdminSupportContactsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminSupportContactsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminSupportContactsHash();

  @$internal
  @override
  $FutureProviderElement<List<SupportContact>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SupportContact>> create(Ref ref) {
    return adminSupportContacts(ref);
  }
}

String _$adminSupportContactsHash() =>
    r'a71d8624b057f0503aed5c7911c70fa8ca914c06';

@ProviderFor(SupportContactSave)
final supportContactSaveProvider = SupportContactSaveProvider._();

final class SupportContactSaveProvider
    extends $AsyncNotifierProvider<SupportContactSave, void> {
  SupportContactSaveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supportContactSaveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supportContactSaveHash();

  @$internal
  @override
  SupportContactSave create() => SupportContactSave();
}

String _$supportContactSaveHash() =>
    r'8289769a3308f5a4b2fc6a58ccdc81367765cf6f';

abstract class _$SupportContactSave extends $AsyncNotifier<void> {
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

@ProviderFor(SupportContactDelete)
final supportContactDeleteProvider = SupportContactDeleteProvider._();

final class SupportContactDeleteProvider
    extends $AsyncNotifierProvider<SupportContactDelete, void> {
  SupportContactDeleteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supportContactDeleteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supportContactDeleteHash();

  @$internal
  @override
  SupportContactDelete create() => SupportContactDelete();
}

String _$supportContactDeleteHash() =>
    r'2695ee7f6e120c737e204bcc8adac11d5590ee6f';

abstract class _$SupportContactDelete extends $AsyncNotifier<void> {
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

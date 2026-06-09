// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'system_settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(systemSettingsRepository)
final systemSettingsRepositoryProvider = SystemSettingsRepositoryProvider._();

final class SystemSettingsRepositoryProvider
    extends
        $FunctionalProvider<
          SystemSettingsRepository,
          SystemSettingsRepository,
          SystemSettingsRepository
        >
    with $Provider<SystemSettingsRepository> {
  SystemSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemSettingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemSettingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SystemSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SystemSettingsRepository create(Ref ref) {
    return systemSettingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SystemSettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SystemSettingsRepository>(value),
    );
  }
}

String _$systemSettingsRepositoryHash() =>
    r'ba59d4b5c96b16fee35748bc67960da9ad70b2fa';

@ProviderFor(systemSettingsService)
final systemSettingsServiceProvider = SystemSettingsServiceProvider._();

final class SystemSettingsServiceProvider
    extends
        $FunctionalProvider<
          SystemSettingsService,
          SystemSettingsService,
          SystemSettingsService
        >
    with $Provider<SystemSettingsService> {
  SystemSettingsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemSettingsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemSettingsServiceHash();

  @$internal
  @override
  $ProviderElement<SystemSettingsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SystemSettingsService create(Ref ref) {
    return systemSettingsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SystemSettingsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SystemSettingsService>(value),
    );
  }
}

String _$systemSettingsServiceHash() =>
    r'555ff300c54761bd1687fd26b1552eb0643c1c9a';

@ProviderFor(systemSettings)
final systemSettingsProvider = SystemSettingsProvider._();

final class SystemSettingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<SystemSettings>,
          SystemSettings,
          FutureOr<SystemSettings>
        >
    with $FutureModifier<SystemSettings>, $FutureProvider<SystemSettings> {
  SystemSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemSettingsHash();

  @$internal
  @override
  $FutureProviderElement<SystemSettings> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SystemSettings> create(Ref ref) {
    return systemSettings(ref);
  }
}

String _$systemSettingsHash() => r'057268730e54999ace0f5b17219aea4f1edd70b8';

@ProviderFor(SystemSettingsSave)
final systemSettingsSaveProvider = SystemSettingsSaveProvider._();

final class SystemSettingsSaveProvider
    extends $AsyncNotifierProvider<SystemSettingsSave, void> {
  SystemSettingsSaveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemSettingsSaveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemSettingsSaveHash();

  @$internal
  @override
  SystemSettingsSave create() => SystemSettingsSave();
}

String _$systemSettingsSaveHash() =>
    r'9d80d3be9f62db7d35278c2b85248c918be8d2c0';

abstract class _$SystemSettingsSave extends $AsyncNotifier<void> {
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

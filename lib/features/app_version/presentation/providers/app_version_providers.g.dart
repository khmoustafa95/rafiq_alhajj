// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appVersionRepository)
final appVersionRepositoryProvider = AppVersionRepositoryProvider._();

final class AppVersionRepositoryProvider
    extends
        $FunctionalProvider<
          AppVersionRepository,
          AppVersionRepository,
          AppVersionRepository
        >
    with $Provider<AppVersionRepository> {
  AppVersionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionRepositoryHash();

  @$internal
  @override
  $ProviderElement<AppVersionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppVersionRepository create(Ref ref) {
    return appVersionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppVersionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppVersionRepository>(value),
    );
  }
}

String _$appVersionRepositoryHash() =>
    r'93e2de66e9e39cd6adc55ba3d770e4dfdb6d8445';

@ProviderFor(appVersionService)
final appVersionServiceProvider = AppVersionServiceProvider._();

final class AppVersionServiceProvider
    extends
        $FunctionalProvider<
          AppVersionService,
          AppVersionService,
          AppVersionService
        >
    with $Provider<AppVersionService> {
  AppVersionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionServiceHash();

  @$internal
  @override
  $ProviderElement<AppVersionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppVersionService create(Ref ref) {
    return appVersionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppVersionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppVersionService>(value),
    );
  }
}

String _$appVersionServiceHash() => r'58c5bbe7e48490940b5d8725d538d972cdb11ecc';

@ProviderFor(appVersionCheck)
final appVersionCheckProvider = AppVersionCheckProvider._();

final class AppVersionCheckProvider
    extends
        $FunctionalProvider<
          AsyncValue<VersionCheckResult>,
          VersionCheckResult,
          FutureOr<VersionCheckResult>
        >
    with
        $FutureModifier<VersionCheckResult>,
        $FutureProvider<VersionCheckResult> {
  AppVersionCheckProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionCheckProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionCheckHash();

  @$internal
  @override
  $FutureProviderElement<VersionCheckResult> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<VersionCheckResult> create(Ref ref) {
    return appVersionCheck(ref);
  }
}

String _$appVersionCheckHash() => r'84a6b2d8c44b752e07e08c0f82c8e5db800b9058';

@ProviderFor(appVersionPolicies)
final appVersionPoliciesProvider = AppVersionPoliciesProvider._();

final class AppVersionPoliciesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AppVersionPolicy>>,
          List<AppVersionPolicy>,
          FutureOr<List<AppVersionPolicy>>
        >
    with
        $FutureModifier<List<AppVersionPolicy>>,
        $FutureProvider<List<AppVersionPolicy>> {
  AppVersionPoliciesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionPoliciesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionPoliciesHash();

  @$internal
  @override
  $FutureProviderElement<List<AppVersionPolicy>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AppVersionPolicy>> create(Ref ref) {
    return appVersionPolicies(ref);
  }
}

String _$appVersionPoliciesHash() =>
    r'13ddbe79e0f721c0aa8cd9a0a86ec829c2e30dac';

@ProviderFor(appCurrentVersion)
final appCurrentVersionProvider = AppCurrentVersionProvider._();

final class AppCurrentVersionProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  AppCurrentVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appCurrentVersionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appCurrentVersionHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return appCurrentVersion(ref);
  }
}

String _$appCurrentVersionHash() => r'f13a6c37f48b5d21f57af256c06ab9e098f0372f';

@ProviderFor(AppVersionPolicySave)
final appVersionPolicySaveProvider = AppVersionPolicySaveProvider._();

final class AppVersionPolicySaveProvider
    extends $AsyncNotifierProvider<AppVersionPolicySave, void> {
  AppVersionPolicySaveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionPolicySaveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionPolicySaveHash();

  @$internal
  @override
  AppVersionPolicySave create() => AppVersionPolicySave();
}

String _$appVersionPolicySaveHash() =>
    r'c04d10743cb625ea5228433397a658082b9eea70';

abstract class _$AppVersionPolicySave extends $AsyncNotifier<void> {
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

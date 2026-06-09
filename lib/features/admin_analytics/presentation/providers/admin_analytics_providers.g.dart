// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_analytics_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(adminAnalyticsRepository)
final adminAnalyticsRepositoryProvider = AdminAnalyticsRepositoryProvider._();

final class AdminAnalyticsRepositoryProvider
    extends
        $FunctionalProvider<
          AdminAnalyticsRepository,
          AdminAnalyticsRepository,
          AdminAnalyticsRepository
        >
    with $Provider<AdminAnalyticsRepository> {
  AdminAnalyticsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminAnalyticsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminAnalyticsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AdminAnalyticsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminAnalyticsRepository create(Ref ref) {
    return adminAnalyticsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminAnalyticsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminAnalyticsRepository>(value),
    );
  }
}

String _$adminAnalyticsRepositoryHash() =>
    r'515674aabe3a5d1664bd40f00f9cc5480894d713';

@ProviderFor(adminAnalyticsService)
final adminAnalyticsServiceProvider = AdminAnalyticsServiceProvider._();

final class AdminAnalyticsServiceProvider
    extends
        $FunctionalProvider<
          AdminAnalyticsService,
          AdminAnalyticsService,
          AdminAnalyticsService
        >
    with $Provider<AdminAnalyticsService> {
  AdminAnalyticsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminAnalyticsServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminAnalyticsServiceHash();

  @$internal
  @override
  $ProviderElement<AdminAnalyticsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AdminAnalyticsService create(Ref ref) {
    return adminAnalyticsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdminAnalyticsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdminAnalyticsService>(value),
    );
  }
}

String _$adminAnalyticsServiceHash() =>
    r'6748d23e02b34aa204f688b8c1d599c8e2a1fba1';

@ProviderFor(AdminDashboard)
final adminDashboardProvider = AdminDashboardProvider._();

final class AdminDashboardProvider
    extends $AsyncNotifierProvider<AdminDashboard, AdminDashboardStats> {
  AdminDashboardProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adminDashboardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adminDashboardHash();

  @$internal
  @override
  AdminDashboard create() => AdminDashboard();
}

String _$adminDashboardHash() => r'92537bc8320439c13658926e719ea27bd715a674';

abstract class _$AdminDashboard extends $AsyncNotifier<AdminDashboardStats> {
  FutureOr<AdminDashboardStats> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AdminDashboardStats>, AdminDashboardStats>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AdminDashboardStats>, AdminDashboardStats>,
              AsyncValue<AdminDashboardStats>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

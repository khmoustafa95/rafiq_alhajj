// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_refresh_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifies [GoRouter] when auth session changes.

@ProviderFor(appRouterRefresh)
final appRouterRefreshProvider = AppRouterRefreshProvider._();

/// Notifies [GoRouter] when auth session changes.

final class AppRouterRefreshProvider
    extends
        $FunctionalProvider<
          AppRouterRefresh,
          AppRouterRefresh,
          AppRouterRefresh
        >
    with $Provider<AppRouterRefresh> {
  /// Notifies [GoRouter] when auth session changes.
  AppRouterRefreshProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appRouterRefreshProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appRouterRefreshHash();

  @$internal
  @override
  $ProviderElement<AppRouterRefresh> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppRouterRefresh create(Ref ref) {
    return appRouterRefresh(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppRouterRefresh value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppRouterRefresh>(value),
    );
  }
}

String _$appRouterRefreshHash() => r'8a94a4d4776d3f58413b91d74eb4753fea784434';

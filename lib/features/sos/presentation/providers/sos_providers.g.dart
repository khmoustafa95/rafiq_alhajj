// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sos_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sosRepository)
final sosRepositoryProvider = SosRepositoryProvider._();

final class SosRepositoryProvider
    extends $FunctionalProvider<SosRepository, SosRepository, SosRepository>
    with $Provider<SosRepository> {
  SosRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sosRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sosRepositoryHash();

  @$internal
  @override
  $ProviderElement<SosRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SosRepository create(Ref ref) {
    return sosRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SosRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SosRepository>(value),
    );
  }
}

String _$sosRepositoryHash() => r'edcae036c8a069ef7c5f97cd5bc073a31d21f967';

@ProviderFor(sosService)
final sosServiceProvider = SosServiceProvider._();

final class SosServiceProvider
    extends $FunctionalProvider<SosService, SosService, SosService>
    with $Provider<SosService> {
  SosServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sosServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sosServiceHash();

  @$internal
  @override
  $ProviderElement<SosService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SosService create(Ref ref) {
    return sosService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SosService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SosService>(value),
    );
  }
}

String _$sosServiceHash() => r'f49a8a17c0183b26edb5419ba0a371cc4067429a';

/// The current pilgrim's active alert (if any).

@ProviderFor(mySosAlert)
final mySosAlertProvider = MySosAlertProvider._();

/// The current pilgrim's active alert (if any).

final class MySosAlertProvider
    extends
        $FunctionalProvider<
          AsyncValue<SosAlert?>,
          SosAlert?,
          FutureOr<SosAlert?>
        >
    with $FutureModifier<SosAlert?>, $FutureProvider<SosAlert?> {
  /// The current pilgrim's active alert (if any).
  MySosAlertProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mySosAlertProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mySosAlertHash();

  @$internal
  @override
  $FutureProviderElement<SosAlert?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<SosAlert?> create(Ref ref) {
    return mySosAlert(ref);
  }
}

String _$mySosAlertHash() => r'c121e3ffdf73fa2b80efc3c3d1b70fdb5f095ff2';

/// All active alerts visible to the signed-in staff member (RLS-scoped by group).

@ProviderFor(activeSosAlerts)
final activeSosAlertsProvider = ActiveSosAlertsProvider._();

/// All active alerts visible to the signed-in staff member (RLS-scoped by group).

final class ActiveSosAlertsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SosAlert>>,
          List<SosAlert>,
          FutureOr<List<SosAlert>>
        >
    with $FutureModifier<List<SosAlert>>, $FutureProvider<List<SosAlert>> {
  /// All active alerts visible to the signed-in staff member (RLS-scoped by group).
  ActiveSosAlertsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeSosAlertsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeSosAlertsHash();

  @$internal
  @override
  $FutureProviderElement<List<SosAlert>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SosAlert>> create(Ref ref) {
    return activeSosAlerts(ref);
  }
}

String _$activeSosAlertsHash() => r'99cb3a4591a98ce494c3042ab66545b2c96b3ec2';

/// Breadcrumb trail for a single alert.

@ProviderFor(sosAlertPings)
final sosAlertPingsProvider = SosAlertPingsFamily._();

/// Breadcrumb trail for a single alert.

final class SosAlertPingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SosPing>>,
          List<SosPing>,
          FutureOr<List<SosPing>>
        >
    with $FutureModifier<List<SosPing>>, $FutureProvider<List<SosPing>> {
  /// Breadcrumb trail for a single alert.
  SosAlertPingsProvider._({
    required SosAlertPingsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'sosAlertPingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sosAlertPingsHash();

  @override
  String toString() {
    return r'sosAlertPingsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<SosPing>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SosPing>> create(Ref ref) {
    final argument = this.argument as String;
    return sosAlertPings(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SosAlertPingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sosAlertPingsHash() => r'2455248db164d89af122d2c0edba5f8448ee8874';

/// Breadcrumb trail for a single alert.

final class SosAlertPingsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<SosPing>>, String> {
  SosAlertPingsFamily._()
    : super(
        retry: null,
        name: r'sosAlertPingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Breadcrumb trail for a single alert.

  SosAlertPingsProvider call(String alertId) =>
      SosAlertPingsProvider._(argument: alertId, from: this);

  @override
  String toString() => r'sosAlertPingsProvider';
}

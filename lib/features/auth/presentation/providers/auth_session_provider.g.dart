// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authSession)
final authSessionProvider = AuthSessionProvider._();

final class AuthSessionProvider
    extends
        $FunctionalProvider<
          AsyncValue<AuthSessionState>,
          AuthSessionState,
          Stream<AuthSessionState>
        >
    with $FutureModifier<AuthSessionState>, $StreamProvider<AuthSessionState> {
  AuthSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSessionHash();

  @$internal
  @override
  $StreamProviderElement<AuthSessionState> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<AuthSessionState> create(Ref ref) {
    return authSession(ref);
  }
}

String _$authSessionHash() => r'400f813f7826789f9be3b82b26bcc08f93a8bbd0';

/// Redirect-relevant access mode; downstream rebuilds only when the value changes.

@ProviderFor(authAccessMode)
final authAccessModeProvider = AuthAccessModeProvider._();

/// Redirect-relevant access mode; downstream rebuilds only when the value changes.

final class AuthAccessModeProvider
    extends $FunctionalProvider<AppAccessMode, AppAccessMode, AppAccessMode>
    with $Provider<AppAccessMode> {
  /// Redirect-relevant access mode; downstream rebuilds only when the value changes.
  AuthAccessModeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authAccessModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authAccessModeHash();

  @$internal
  @override
  $ProviderElement<AppAccessMode> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppAccessMode create(Ref ref) {
    return authAccessMode(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppAccessMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppAccessMode>(value),
    );
  }
}

String _$authAccessModeHash() => r'735b188d20ca65e3f98dfedf91b4d44d69a84948';

/// Signed-in profile id; downstream rebuilds only when sign-in/out changes id.

@ProviderFor(authProfileId)
final authProfileIdProvider = AuthProfileIdProvider._();

/// Signed-in profile id; downstream rebuilds only when sign-in/out changes id.

final class AuthProfileIdProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  /// Signed-in profile id; downstream rebuilds only when sign-in/out changes id.
  AuthProfileIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProfileIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authProfileIdHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return authProfileId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$authProfileIdHash() => r'628b4a5606d19bc8365ca3e515d07c0103695937';

/// Whether the signed-in admin may promote staff to admin.

@ProviderFor(authCanManageAdmins)
final authCanManageAdminsProvider = AuthCanManageAdminsProvider._();

/// Whether the signed-in admin may promote staff to admin.

final class AuthCanManageAdminsProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Whether the signed-in admin may promote staff to admin.
  AuthCanManageAdminsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authCanManageAdminsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authCanManageAdminsHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return authCanManageAdmins(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$authCanManageAdminsHash() =>
    r'928c182da99205f5daa92b9919f787737f8b4c58';

/// Pilgrim display name; isolated from unrelated auth token refreshes when unchanged.

@ProviderFor(authProfileFullName)
final authProfileFullNameProvider = AuthProfileFullNameProvider._();

/// Pilgrim display name; isolated from unrelated auth token refreshes when unchanged.

final class AuthProfileFullNameProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  /// Pilgrim display name; isolated from unrelated auth token refreshes when unchanged.
  AuthProfileFullNameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authProfileFullNameProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authProfileFullNameHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return authProfileFullName(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$authProfileFullNameHash() =>
    r'7c0973b722df5dfc7761e6424bd9fac5bd0f9088';

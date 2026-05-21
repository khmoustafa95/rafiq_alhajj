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

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthSessionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSessionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthSessionState()';
}


}

/// @nodoc
class $AuthSessionStateCopyWith<$Res>  {
$AuthSessionStateCopyWith(AuthSessionState _, $Res Function(AuthSessionState) __);
}


/// Adds pattern-matching-related methods to [AuthSessionState].
extension AuthSessionStatePatterns on AuthSessionState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GuestAuthSession value)?  guest,TResult Function( AuthenticatedAuthSession value)?  authenticated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GuestAuthSession() when guest != null:
return guest(_that);case AuthenticatedAuthSession() when authenticated != null:
return authenticated(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GuestAuthSession value)  guest,required TResult Function( AuthenticatedAuthSession value)  authenticated,}){
final _that = this;
switch (_that) {
case GuestAuthSession():
return guest(_that);case AuthenticatedAuthSession():
return authenticated(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GuestAuthSession value)?  guest,TResult? Function( AuthenticatedAuthSession value)?  authenticated,}){
final _that = this;
switch (_that) {
case GuestAuthSession() when guest != null:
return guest(_that);case AuthenticatedAuthSession() when authenticated != null:
return authenticated(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  guest,TResult Function( UserProfile profile)?  authenticated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GuestAuthSession() when guest != null:
return guest();case AuthenticatedAuthSession() when authenticated != null:
return authenticated(_that.profile);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  guest,required TResult Function( UserProfile profile)  authenticated,}) {final _that = this;
switch (_that) {
case GuestAuthSession():
return guest();case AuthenticatedAuthSession():
return authenticated(_that.profile);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  guest,TResult? Function( UserProfile profile)?  authenticated,}) {final _that = this;
switch (_that) {
case GuestAuthSession() when guest != null:
return guest();case AuthenticatedAuthSession() when authenticated != null:
return authenticated(_that.profile);case _:
  return null;

}
}

}

/// @nodoc


class GuestAuthSession extends AuthSessionState {
  const GuestAuthSession(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuestAuthSession);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthSessionState.guest()';
}


}




/// @nodoc


class AuthenticatedAuthSession extends AuthSessionState {
  const AuthenticatedAuthSession({required this.profile}): super._();
  

 final  UserProfile profile;

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticatedAuthSessionCopyWith<AuthenticatedAuthSession> get copyWith => _$AuthenticatedAuthSessionCopyWithImpl<AuthenticatedAuthSession>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticatedAuthSession&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'AuthSessionState.authenticated(profile: $profile)';
}


}

/// @nodoc
abstract mixin class $AuthenticatedAuthSessionCopyWith<$Res> implements $AuthSessionStateCopyWith<$Res> {
  factory $AuthenticatedAuthSessionCopyWith(AuthenticatedAuthSession value, $Res Function(AuthenticatedAuthSession) _then) = _$AuthenticatedAuthSessionCopyWithImpl;
@useResult
$Res call({
 UserProfile profile
});


$UserProfileCopyWith<$Res> get profile;

}
/// @nodoc
class _$AuthenticatedAuthSessionCopyWithImpl<$Res>
    implements $AuthenticatedAuthSessionCopyWith<$Res> {
  _$AuthenticatedAuthSessionCopyWithImpl(this._self, this._then);

  final AuthenticatedAuthSession _self;
  final $Res Function(AuthenticatedAuthSession) _then;

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(AuthenticatedAuthSession(
profile: null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile,
  ));
}

/// Create a copy of AuthSessionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileCopyWith<$Res> get profile {
  
  return $UserProfileCopyWith<$Res>(_self.profile, (value) {
    return _then(_self.copyWith(profile: value));
  });
}
}

// dart format on

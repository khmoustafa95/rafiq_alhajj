// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'created_pilgrim_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreatedPilgrimAccount {

 String get profileId; String get email; String get password;
/// Create a copy of CreatedPilgrimAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatedPilgrimAccountCopyWith<CreatedPilgrimAccount> get copyWith => _$CreatedPilgrimAccountCopyWithImpl<CreatedPilgrimAccount>(this as CreatedPilgrimAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatedPilgrimAccount&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,profileId,email,password);

@override
String toString() {
  return 'CreatedPilgrimAccount(profileId: $profileId, email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $CreatedPilgrimAccountCopyWith<$Res>  {
  factory $CreatedPilgrimAccountCopyWith(CreatedPilgrimAccount value, $Res Function(CreatedPilgrimAccount) _then) = _$CreatedPilgrimAccountCopyWithImpl;
@useResult
$Res call({
 String profileId, String email, String password
});




}
/// @nodoc
class _$CreatedPilgrimAccountCopyWithImpl<$Res>
    implements $CreatedPilgrimAccountCopyWith<$Res> {
  _$CreatedPilgrimAccountCopyWithImpl(this._self, this._then);

  final CreatedPilgrimAccount _self;
  final $Res Function(CreatedPilgrimAccount) _then;

/// Create a copy of CreatedPilgrimAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileId = null,Object? email = null,Object? password = null,}) {
  return _then(_self.copyWith(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreatedPilgrimAccount].
extension CreatedPilgrimAccountPatterns on CreatedPilgrimAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatedPilgrimAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatedPilgrimAccount() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatedPilgrimAccount value)  $default,){
final _that = this;
switch (_that) {
case _CreatedPilgrimAccount():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatedPilgrimAccount value)?  $default,){
final _that = this;
switch (_that) {
case _CreatedPilgrimAccount() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String profileId,  String email,  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatedPilgrimAccount() when $default != null:
return $default(_that.profileId,_that.email,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String profileId,  String email,  String password)  $default,) {final _that = this;
switch (_that) {
case _CreatedPilgrimAccount():
return $default(_that.profileId,_that.email,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String profileId,  String email,  String password)?  $default,) {final _that = this;
switch (_that) {
case _CreatedPilgrimAccount() when $default != null:
return $default(_that.profileId,_that.email,_that.password);case _:
  return null;

}
}

}

/// @nodoc


class _CreatedPilgrimAccount implements CreatedPilgrimAccount {
  const _CreatedPilgrimAccount({required this.profileId, required this.email, required this.password});
  

@override final  String profileId;
@override final  String email;
@override final  String password;

/// Create a copy of CreatedPilgrimAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatedPilgrimAccountCopyWith<_CreatedPilgrimAccount> get copyWith => __$CreatedPilgrimAccountCopyWithImpl<_CreatedPilgrimAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatedPilgrimAccount&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,profileId,email,password);

@override
String toString() {
  return 'CreatedPilgrimAccount(profileId: $profileId, email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$CreatedPilgrimAccountCopyWith<$Res> implements $CreatedPilgrimAccountCopyWith<$Res> {
  factory _$CreatedPilgrimAccountCopyWith(_CreatedPilgrimAccount value, $Res Function(_CreatedPilgrimAccount) _then) = __$CreatedPilgrimAccountCopyWithImpl;
@override @useResult
$Res call({
 String profileId, String email, String password
});




}
/// @nodoc
class __$CreatedPilgrimAccountCopyWithImpl<$Res>
    implements _$CreatedPilgrimAccountCopyWith<$Res> {
  __$CreatedPilgrimAccountCopyWithImpl(this._self, this._then);

  final _CreatedPilgrimAccount _self;
  final $Res Function(_CreatedPilgrimAccount) _then;

/// Create a copy of CreatedPilgrimAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileId = null,Object? email = null,Object? password = null,}) {
  return _then(_CreatedPilgrimAccount(
profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

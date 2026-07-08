// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_account.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminAccount {

 String get id; String get fullName; String get email; bool get canManageAdmins; bool get isActive; DateTime? get updatedAt;
/// Create a copy of AdminAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminAccountCopyWith<AdminAccount> get copyWith => _$AdminAccountCopyWithImpl<AdminAccount>(this as AdminAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.canManageAdmins, canManageAdmins) || other.canManageAdmins == canManageAdmins)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,canManageAdmins,isActive,updatedAt);

@override
String toString() {
  return 'AdminAccount(id: $id, fullName: $fullName, email: $email, canManageAdmins: $canManageAdmins, isActive: $isActive, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $AdminAccountCopyWith<$Res>  {
  factory $AdminAccountCopyWith(AdminAccount value, $Res Function(AdminAccount) _then) = _$AdminAccountCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String email, bool canManageAdmins, bool isActive, DateTime? updatedAt
});




}
/// @nodoc
class _$AdminAccountCopyWithImpl<$Res>
    implements $AdminAccountCopyWith<$Res> {
  _$AdminAccountCopyWithImpl(this._self, this._then);

  final AdminAccount _self;
  final $Res Function(AdminAccount) _then;

/// Create a copy of AdminAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? email = null,Object? canManageAdmins = null,Object? isActive = null,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,canManageAdmins: null == canManageAdmins ? _self.canManageAdmins : canManageAdmins // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminAccount].
extension AdminAccountPatterns on AdminAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminAccount value)  $default,){
final _that = this;
switch (_that) {
case _AdminAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminAccount value)?  $default,){
final _that = this;
switch (_that) {
case _AdminAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String email,  bool canManageAdmins,  bool isActive,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminAccount() when $default != null:
return $default(_that.id,_that.fullName,_that.email,_that.canManageAdmins,_that.isActive,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String email,  bool canManageAdmins,  bool isActive,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _AdminAccount():
return $default(_that.id,_that.fullName,_that.email,_that.canManageAdmins,_that.isActive,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String email,  bool canManageAdmins,  bool isActive,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _AdminAccount() when $default != null:
return $default(_that.id,_that.fullName,_that.email,_that.canManageAdmins,_that.isActive,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _AdminAccount implements AdminAccount {
  const _AdminAccount({required this.id, required this.fullName, required this.email, required this.canManageAdmins, required this.isActive, this.updatedAt});
  

@override final  String id;
@override final  String fullName;
@override final  String email;
@override final  bool canManageAdmins;
@override final  bool isActive;
@override final  DateTime? updatedAt;

/// Create a copy of AdminAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminAccountCopyWith<_AdminAccount> get copyWith => __$AdminAccountCopyWithImpl<_AdminAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.canManageAdmins, canManageAdmins) || other.canManageAdmins == canManageAdmins)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,canManageAdmins,isActive,updatedAt);

@override
String toString() {
  return 'AdminAccount(id: $id, fullName: $fullName, email: $email, canManageAdmins: $canManageAdmins, isActive: $isActive, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AdminAccountCopyWith<$Res> implements $AdminAccountCopyWith<$Res> {
  factory _$AdminAccountCopyWith(_AdminAccount value, $Res Function(_AdminAccount) _then) = __$AdminAccountCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String email, bool canManageAdmins, bool isActive, DateTime? updatedAt
});




}
/// @nodoc
class __$AdminAccountCopyWithImpl<$Res>
    implements _$AdminAccountCopyWith<$Res> {
  __$AdminAccountCopyWithImpl(this._self, this._then);

  final _AdminAccount _self;
  final $Res Function(_AdminAccount) _then;

/// Create a copy of AdminAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? email = null,Object? canManageAdmins = null,Object? isActive = null,Object? updatedAt = freezed,}) {
  return _then(_AdminAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,canManageAdmins: null == canManageAdmins ? _self.canManageAdmins : canManageAdmins // ignore: cast_nullable_to_non_nullable
as bool,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

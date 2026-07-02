// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operator_editor_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OperatorEditorInput {

 String? get id; String get fullName; String get email; String? get password; bool get isActive; OperatorPermissions get permissions; List<OperatorGroupGrant> get groupAccess;
/// Create a copy of OperatorEditorInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OperatorEditorInputCopyWith<OperatorEditorInput> get copyWith => _$OperatorEditorInputCopyWithImpl<OperatorEditorInput>(this as OperatorEditorInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OperatorEditorInput&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.permissions, permissions) || other.permissions == permissions)&&const DeepCollectionEquality().equals(other.groupAccess, groupAccess));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,password,isActive,permissions,const DeepCollectionEquality().hash(groupAccess));

@override
String toString() {
  return 'OperatorEditorInput(id: $id, fullName: $fullName, email: $email, password: $password, isActive: $isActive, permissions: $permissions, groupAccess: $groupAccess)';
}


}

/// @nodoc
abstract mixin class $OperatorEditorInputCopyWith<$Res>  {
  factory $OperatorEditorInputCopyWith(OperatorEditorInput value, $Res Function(OperatorEditorInput) _then) = _$OperatorEditorInputCopyWithImpl;
@useResult
$Res call({
 String? id, String fullName, String email, String? password, bool isActive, OperatorPermissions permissions, List<OperatorGroupGrant> groupAccess
});




}
/// @nodoc
class _$OperatorEditorInputCopyWithImpl<$Res>
    implements $OperatorEditorInputCopyWith<$Res> {
  _$OperatorEditorInputCopyWithImpl(this._self, this._then);

  final OperatorEditorInput _self;
  final $Res Function(OperatorEditorInput) _then;

/// Create a copy of OperatorEditorInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? fullName = null,Object? email = null,Object? password = freezed,Object? isActive = null,Object? permissions = null,Object? groupAccess = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as OperatorPermissions,groupAccess: null == groupAccess ? _self.groupAccess : groupAccess // ignore: cast_nullable_to_non_nullable
as List<OperatorGroupGrant>,
  ));
}

}


/// Adds pattern-matching-related methods to [OperatorEditorInput].
extension OperatorEditorInputPatterns on OperatorEditorInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OperatorEditorInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OperatorEditorInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OperatorEditorInput value)  $default,){
final _that = this;
switch (_that) {
case _OperatorEditorInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OperatorEditorInput value)?  $default,){
final _that = this;
switch (_that) {
case _OperatorEditorInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String fullName,  String email,  String? password,  bool isActive,  OperatorPermissions permissions,  List<OperatorGroupGrant> groupAccess)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OperatorEditorInput() when $default != null:
return $default(_that.id,_that.fullName,_that.email,_that.password,_that.isActive,_that.permissions,_that.groupAccess);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String fullName,  String email,  String? password,  bool isActive,  OperatorPermissions permissions,  List<OperatorGroupGrant> groupAccess)  $default,) {final _that = this;
switch (_that) {
case _OperatorEditorInput():
return $default(_that.id,_that.fullName,_that.email,_that.password,_that.isActive,_that.permissions,_that.groupAccess);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String fullName,  String email,  String? password,  bool isActive,  OperatorPermissions permissions,  List<OperatorGroupGrant> groupAccess)?  $default,) {final _that = this;
switch (_that) {
case _OperatorEditorInput() when $default != null:
return $default(_that.id,_that.fullName,_that.email,_that.password,_that.isActive,_that.permissions,_that.groupAccess);case _:
  return null;

}
}

}

/// @nodoc


class _OperatorEditorInput extends OperatorEditorInput {
  const _OperatorEditorInput({this.id, required this.fullName, required this.email, this.password, this.isActive = true, required this.permissions, final  List<OperatorGroupGrant> groupAccess = const []}): _groupAccess = groupAccess,super._();
  

@override final  String? id;
@override final  String fullName;
@override final  String email;
@override final  String? password;
@override@JsonKey() final  bool isActive;
@override final  OperatorPermissions permissions;
 final  List<OperatorGroupGrant> _groupAccess;
@override@JsonKey() List<OperatorGroupGrant> get groupAccess {
  if (_groupAccess is EqualUnmodifiableListView) return _groupAccess;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groupAccess);
}


/// Create a copy of OperatorEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OperatorEditorInputCopyWith<_OperatorEditorInput> get copyWith => __$OperatorEditorInputCopyWithImpl<_OperatorEditorInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OperatorEditorInput&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.permissions, permissions) || other.permissions == permissions)&&const DeepCollectionEquality().equals(other._groupAccess, _groupAccess));
}


@override
int get hashCode => Object.hash(runtimeType,id,fullName,email,password,isActive,permissions,const DeepCollectionEquality().hash(_groupAccess));

@override
String toString() {
  return 'OperatorEditorInput(id: $id, fullName: $fullName, email: $email, password: $password, isActive: $isActive, permissions: $permissions, groupAccess: $groupAccess)';
}


}

/// @nodoc
abstract mixin class _$OperatorEditorInputCopyWith<$Res> implements $OperatorEditorInputCopyWith<$Res> {
  factory _$OperatorEditorInputCopyWith(_OperatorEditorInput value, $Res Function(_OperatorEditorInput) _then) = __$OperatorEditorInputCopyWithImpl;
@override @useResult
$Res call({
 String? id, String fullName, String email, String? password, bool isActive, OperatorPermissions permissions, List<OperatorGroupGrant> groupAccess
});




}
/// @nodoc
class __$OperatorEditorInputCopyWithImpl<$Res>
    implements _$OperatorEditorInputCopyWith<$Res> {
  __$OperatorEditorInputCopyWithImpl(this._self, this._then);

  final _OperatorEditorInput _self;
  final $Res Function(_OperatorEditorInput) _then;

/// Create a copy of OperatorEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? fullName = null,Object? email = null,Object? password = freezed,Object? isActive = null,Object? permissions = null,Object? groupAccess = null,}) {
  return _then(_OperatorEditorInput(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as OperatorPermissions,groupAccess: null == groupAccess ? _self._groupAccess : groupAccess // ignore: cast_nullable_to_non_nullable
as List<OperatorGroupGrant>,
  ));
}


}

// dart format on

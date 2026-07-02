// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_office.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TripOffice {

 String get tripGroupId; String get tripId; String get groupId; String get groupName; String get status; String? get presidentName; DateTime? get joinedAt; DateTime? get withdrawnAt;
/// Create a copy of TripOffice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripOfficeCopyWith<TripOffice> get copyWith => _$TripOfficeCopyWithImpl<TripOffice>(this as TripOffice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripOffice&&(identical(other.tripGroupId, tripGroupId) || other.tripGroupId == tripGroupId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.status, status) || other.status == status)&&(identical(other.presidentName, presidentName) || other.presidentName == presidentName)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.withdrawnAt, withdrawnAt) || other.withdrawnAt == withdrawnAt));
}


@override
int get hashCode => Object.hash(runtimeType,tripGroupId,tripId,groupId,groupName,status,presidentName,joinedAt,withdrawnAt);

@override
String toString() {
  return 'TripOffice(tripGroupId: $tripGroupId, tripId: $tripId, groupId: $groupId, groupName: $groupName, status: $status, presidentName: $presidentName, joinedAt: $joinedAt, withdrawnAt: $withdrawnAt)';
}


}

/// @nodoc
abstract mixin class $TripOfficeCopyWith<$Res>  {
  factory $TripOfficeCopyWith(TripOffice value, $Res Function(TripOffice) _then) = _$TripOfficeCopyWithImpl;
@useResult
$Res call({
 String tripGroupId, String tripId, String groupId, String groupName, String status, String? presidentName, DateTime? joinedAt, DateTime? withdrawnAt
});




}
/// @nodoc
class _$TripOfficeCopyWithImpl<$Res>
    implements $TripOfficeCopyWith<$Res> {
  _$TripOfficeCopyWithImpl(this._self, this._then);

  final TripOffice _self;
  final $Res Function(TripOffice) _then;

/// Create a copy of TripOffice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tripGroupId = null,Object? tripId = null,Object? groupId = null,Object? groupName = null,Object? status = null,Object? presidentName = freezed,Object? joinedAt = freezed,Object? withdrawnAt = freezed,}) {
  return _then(_self.copyWith(
tripGroupId: null == tripGroupId ? _self.tripGroupId : tripGroupId // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,groupName: null == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,presidentName: freezed == presidentName ? _self.presidentName : presidentName // ignore: cast_nullable_to_non_nullable
as String?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,withdrawnAt: freezed == withdrawnAt ? _self.withdrawnAt : withdrawnAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripOffice].
extension TripOfficePatterns on TripOffice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripOffice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripOffice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripOffice value)  $default,){
final _that = this;
switch (_that) {
case _TripOffice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripOffice value)?  $default,){
final _that = this;
switch (_that) {
case _TripOffice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tripGroupId,  String tripId,  String groupId,  String groupName,  String status,  String? presidentName,  DateTime? joinedAt,  DateTime? withdrawnAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripOffice() when $default != null:
return $default(_that.tripGroupId,_that.tripId,_that.groupId,_that.groupName,_that.status,_that.presidentName,_that.joinedAt,_that.withdrawnAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tripGroupId,  String tripId,  String groupId,  String groupName,  String status,  String? presidentName,  DateTime? joinedAt,  DateTime? withdrawnAt)  $default,) {final _that = this;
switch (_that) {
case _TripOffice():
return $default(_that.tripGroupId,_that.tripId,_that.groupId,_that.groupName,_that.status,_that.presidentName,_that.joinedAt,_that.withdrawnAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tripGroupId,  String tripId,  String groupId,  String groupName,  String status,  String? presidentName,  DateTime? joinedAt,  DateTime? withdrawnAt)?  $default,) {final _that = this;
switch (_that) {
case _TripOffice() when $default != null:
return $default(_that.tripGroupId,_that.tripId,_that.groupId,_that.groupName,_that.status,_that.presidentName,_that.joinedAt,_that.withdrawnAt);case _:
  return null;

}
}

}

/// @nodoc


class _TripOffice extends TripOffice {
  const _TripOffice({required this.tripGroupId, required this.tripId, required this.groupId, required this.groupName, this.status = 'active', this.presidentName, this.joinedAt, this.withdrawnAt}): super._();
  

@override final  String tripGroupId;
@override final  String tripId;
@override final  String groupId;
@override final  String groupName;
@override@JsonKey() final  String status;
@override final  String? presidentName;
@override final  DateTime? joinedAt;
@override final  DateTime? withdrawnAt;

/// Create a copy of TripOffice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripOfficeCopyWith<_TripOffice> get copyWith => __$TripOfficeCopyWithImpl<_TripOffice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripOffice&&(identical(other.tripGroupId, tripGroupId) || other.tripGroupId == tripGroupId)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.status, status) || other.status == status)&&(identical(other.presidentName, presidentName) || other.presidentName == presidentName)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.withdrawnAt, withdrawnAt) || other.withdrawnAt == withdrawnAt));
}


@override
int get hashCode => Object.hash(runtimeType,tripGroupId,tripId,groupId,groupName,status,presidentName,joinedAt,withdrawnAt);

@override
String toString() {
  return 'TripOffice(tripGroupId: $tripGroupId, tripId: $tripId, groupId: $groupId, groupName: $groupName, status: $status, presidentName: $presidentName, joinedAt: $joinedAt, withdrawnAt: $withdrawnAt)';
}


}

/// @nodoc
abstract mixin class _$TripOfficeCopyWith<$Res> implements $TripOfficeCopyWith<$Res> {
  factory _$TripOfficeCopyWith(_TripOffice value, $Res Function(_TripOffice) _then) = __$TripOfficeCopyWithImpl;
@override @useResult
$Res call({
 String tripGroupId, String tripId, String groupId, String groupName, String status, String? presidentName, DateTime? joinedAt, DateTime? withdrawnAt
});




}
/// @nodoc
class __$TripOfficeCopyWithImpl<$Res>
    implements _$TripOfficeCopyWith<$Res> {
  __$TripOfficeCopyWithImpl(this._self, this._then);

  final _TripOffice _self;
  final $Res Function(_TripOffice) _then;

/// Create a copy of TripOffice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tripGroupId = null,Object? tripId = null,Object? groupId = null,Object? groupName = null,Object? status = null,Object? presidentName = freezed,Object? joinedAt = freezed,Object? withdrawnAt = freezed,}) {
  return _then(_TripOffice(
tripGroupId: null == tripGroupId ? _self.tripGroupId : tripGroupId // ignore: cast_nullable_to_non_nullable
as String,tripId: null == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,groupName: null == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,presidentName: freezed == presidentName ? _self.presidentName : presidentName // ignore: cast_nullable_to_non_nullable
as String?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,withdrawnAt: freezed == withdrawnAt ? _self.withdrawnAt : withdrawnAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$TripGroupOption {

 String get id; String get name;
/// Create a copy of TripGroupOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripGroupOptionCopyWith<TripGroupOption> get copyWith => _$TripGroupOptionCopyWithImpl<TripGroupOption>(this as TripGroupOption, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripGroupOption&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'TripGroupOption(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $TripGroupOptionCopyWith<$Res>  {
  factory $TripGroupOptionCopyWith(TripGroupOption value, $Res Function(TripGroupOption) _then) = _$TripGroupOptionCopyWithImpl;
@useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class _$TripGroupOptionCopyWithImpl<$Res>
    implements $TripGroupOptionCopyWith<$Res> {
  _$TripGroupOptionCopyWithImpl(this._self, this._then);

  final TripGroupOption _self;
  final $Res Function(TripGroupOption) _then;

/// Create a copy of TripGroupOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TripGroupOption].
extension TripGroupOptionPatterns on TripGroupOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripGroupOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripGroupOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripGroupOption value)  $default,){
final _that = this;
switch (_that) {
case _TripGroupOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripGroupOption value)?  $default,){
final _that = this;
switch (_that) {
case _TripGroupOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripGroupOption() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name)  $default,) {final _that = this;
switch (_that) {
case _TripGroupOption():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name)?  $default,) {final _that = this;
switch (_that) {
case _TripGroupOption() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _TripGroupOption implements TripGroupOption {
  const _TripGroupOption({required this.id, required this.name});
  

@override final  String id;
@override final  String name;

/// Create a copy of TripGroupOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripGroupOptionCopyWith<_TripGroupOption> get copyWith => __$TripGroupOptionCopyWithImpl<_TripGroupOption>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripGroupOption&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'TripGroupOption(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$TripGroupOptionCopyWith<$Res> implements $TripGroupOptionCopyWith<$Res> {
  factory _$TripGroupOptionCopyWith(_TripGroupOption value, $Res Function(_TripGroupOption) _then) = __$TripGroupOptionCopyWithImpl;
@override @useResult
$Res call({
 String id, String name
});




}
/// @nodoc
class __$TripGroupOptionCopyWithImpl<$Res>
    implements _$TripGroupOptionCopyWith<$Res> {
  __$TripGroupOptionCopyWithImpl(this._self, this._then);

  final _TripGroupOption _self;
  final $Res Function(_TripGroupOption) _then;

/// Create a copy of TripGroupOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,}) {
  return _then(_TripGroupOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SosAlert {

 String get id; String get pilgrimProfileId; String? get pilgrimName; String? get groupId; String? get groupName; SosStatus get status; double? get latitude; double? get longitude; double? get accuracy; String? get note; DateTime get startedAt; DateTime? get lastLocationAt;
/// Create a copy of SosAlert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SosAlertCopyWith<SosAlert> get copyWith => _$SosAlertCopyWithImpl<SosAlert>(this as SosAlert, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SosAlert&&(identical(other.id, id) || other.id == id)&&(identical(other.pilgrimProfileId, pilgrimProfileId) || other.pilgrimProfileId == pilgrimProfileId)&&(identical(other.pilgrimName, pilgrimName) || other.pilgrimName == pilgrimName)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.status, status) || other.status == status)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.note, note) || other.note == note)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.lastLocationAt, lastLocationAt) || other.lastLocationAt == lastLocationAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,pilgrimProfileId,pilgrimName,groupId,groupName,status,latitude,longitude,accuracy,note,startedAt,lastLocationAt);

@override
String toString() {
  return 'SosAlert(id: $id, pilgrimProfileId: $pilgrimProfileId, pilgrimName: $pilgrimName, groupId: $groupId, groupName: $groupName, status: $status, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, note: $note, startedAt: $startedAt, lastLocationAt: $lastLocationAt)';
}


}

/// @nodoc
abstract mixin class $SosAlertCopyWith<$Res>  {
  factory $SosAlertCopyWith(SosAlert value, $Res Function(SosAlert) _then) = _$SosAlertCopyWithImpl;
@useResult
$Res call({
 String id, String pilgrimProfileId, String? pilgrimName, String? groupId, String? groupName, SosStatus status, double? latitude, double? longitude, double? accuracy, String? note, DateTime startedAt, DateTime? lastLocationAt
});




}
/// @nodoc
class _$SosAlertCopyWithImpl<$Res>
    implements $SosAlertCopyWith<$Res> {
  _$SosAlertCopyWithImpl(this._self, this._then);

  final SosAlert _self;
  final $Res Function(SosAlert) _then;

/// Create a copy of SosAlert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? pilgrimProfileId = null,Object? pilgrimName = freezed,Object? groupId = freezed,Object? groupName = freezed,Object? status = null,Object? latitude = freezed,Object? longitude = freezed,Object? accuracy = freezed,Object? note = freezed,Object? startedAt = null,Object? lastLocationAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,pilgrimProfileId: null == pilgrimProfileId ? _self.pilgrimProfileId : pilgrimProfileId // ignore: cast_nullable_to_non_nullable
as String,pilgrimName: freezed == pilgrimName ? _self.pilgrimName : pilgrimName // ignore: cast_nullable_to_non_nullable
as String?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SosStatus,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLocationAt: freezed == lastLocationAt ? _self.lastLocationAt : lastLocationAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SosAlert].
extension SosAlertPatterns on SosAlert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SosAlert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SosAlert() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SosAlert value)  $default,){
final _that = this;
switch (_that) {
case _SosAlert():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SosAlert value)?  $default,){
final _that = this;
switch (_that) {
case _SosAlert() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String pilgrimProfileId,  String? pilgrimName,  String? groupId,  String? groupName,  SosStatus status,  double? latitude,  double? longitude,  double? accuracy,  String? note,  DateTime startedAt,  DateTime? lastLocationAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SosAlert() when $default != null:
return $default(_that.id,_that.pilgrimProfileId,_that.pilgrimName,_that.groupId,_that.groupName,_that.status,_that.latitude,_that.longitude,_that.accuracy,_that.note,_that.startedAt,_that.lastLocationAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String pilgrimProfileId,  String? pilgrimName,  String? groupId,  String? groupName,  SosStatus status,  double? latitude,  double? longitude,  double? accuracy,  String? note,  DateTime startedAt,  DateTime? lastLocationAt)  $default,) {final _that = this;
switch (_that) {
case _SosAlert():
return $default(_that.id,_that.pilgrimProfileId,_that.pilgrimName,_that.groupId,_that.groupName,_that.status,_that.latitude,_that.longitude,_that.accuracy,_that.note,_that.startedAt,_that.lastLocationAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String pilgrimProfileId,  String? pilgrimName,  String? groupId,  String? groupName,  SosStatus status,  double? latitude,  double? longitude,  double? accuracy,  String? note,  DateTime startedAt,  DateTime? lastLocationAt)?  $default,) {final _that = this;
switch (_that) {
case _SosAlert() when $default != null:
return $default(_that.id,_that.pilgrimProfileId,_that.pilgrimName,_that.groupId,_that.groupName,_that.status,_that.latitude,_that.longitude,_that.accuracy,_that.note,_that.startedAt,_that.lastLocationAt);case _:
  return null;

}
}

}

/// @nodoc


class _SosAlert extends SosAlert {
  const _SosAlert({required this.id, required this.pilgrimProfileId, this.pilgrimName, this.groupId, this.groupName, this.status = SosStatus.active, this.latitude, this.longitude, this.accuracy, this.note, required this.startedAt, this.lastLocationAt}): super._();
  

@override final  String id;
@override final  String pilgrimProfileId;
@override final  String? pilgrimName;
@override final  String? groupId;
@override final  String? groupName;
@override@JsonKey() final  SosStatus status;
@override final  double? latitude;
@override final  double? longitude;
@override final  double? accuracy;
@override final  String? note;
@override final  DateTime startedAt;
@override final  DateTime? lastLocationAt;

/// Create a copy of SosAlert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SosAlertCopyWith<_SosAlert> get copyWith => __$SosAlertCopyWithImpl<_SosAlert>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SosAlert&&(identical(other.id, id) || other.id == id)&&(identical(other.pilgrimProfileId, pilgrimProfileId) || other.pilgrimProfileId == pilgrimProfileId)&&(identical(other.pilgrimName, pilgrimName) || other.pilgrimName == pilgrimName)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.status, status) || other.status == status)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.note, note) || other.note == note)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.lastLocationAt, lastLocationAt) || other.lastLocationAt == lastLocationAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,pilgrimProfileId,pilgrimName,groupId,groupName,status,latitude,longitude,accuracy,note,startedAt,lastLocationAt);

@override
String toString() {
  return 'SosAlert(id: $id, pilgrimProfileId: $pilgrimProfileId, pilgrimName: $pilgrimName, groupId: $groupId, groupName: $groupName, status: $status, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, note: $note, startedAt: $startedAt, lastLocationAt: $lastLocationAt)';
}


}

/// @nodoc
abstract mixin class _$SosAlertCopyWith<$Res> implements $SosAlertCopyWith<$Res> {
  factory _$SosAlertCopyWith(_SosAlert value, $Res Function(_SosAlert) _then) = __$SosAlertCopyWithImpl;
@override @useResult
$Res call({
 String id, String pilgrimProfileId, String? pilgrimName, String? groupId, String? groupName, SosStatus status, double? latitude, double? longitude, double? accuracy, String? note, DateTime startedAt, DateTime? lastLocationAt
});




}
/// @nodoc
class __$SosAlertCopyWithImpl<$Res>
    implements _$SosAlertCopyWith<$Res> {
  __$SosAlertCopyWithImpl(this._self, this._then);

  final _SosAlert _self;
  final $Res Function(_SosAlert) _then;

/// Create a copy of SosAlert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? pilgrimProfileId = null,Object? pilgrimName = freezed,Object? groupId = freezed,Object? groupName = freezed,Object? status = null,Object? latitude = freezed,Object? longitude = freezed,Object? accuracy = freezed,Object? note = freezed,Object? startedAt = null,Object? lastLocationAt = freezed,}) {
  return _then(_SosAlert(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,pilgrimProfileId: null == pilgrimProfileId ? _self.pilgrimProfileId : pilgrimProfileId // ignore: cast_nullable_to_non_nullable
as String,pilgrimName: freezed == pilgrimName ? _self.pilgrimName : pilgrimName // ignore: cast_nullable_to_non_nullable
as String?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SosStatus,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLocationAt: freezed == lastLocationAt ? _self.lastLocationAt : lastLocationAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

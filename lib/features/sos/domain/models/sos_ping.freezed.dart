// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sos_ping.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SosPing {

 String get id; String get alertId; double get latitude; double get longitude; double? get accuracy; DateTime get createdAt;
/// Create a copy of SosPing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SosPingCopyWith<SosPing> get copyWith => _$SosPingCopyWithImpl<SosPing>(this as SosPing, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SosPing&&(identical(other.id, id) || other.id == id)&&(identical(other.alertId, alertId) || other.alertId == alertId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,alertId,latitude,longitude,accuracy,createdAt);

@override
String toString() {
  return 'SosPing(id: $id, alertId: $alertId, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $SosPingCopyWith<$Res>  {
  factory $SosPingCopyWith(SosPing value, $Res Function(SosPing) _then) = _$SosPingCopyWithImpl;
@useResult
$Res call({
 String id, String alertId, double latitude, double longitude, double? accuracy, DateTime createdAt
});




}
/// @nodoc
class _$SosPingCopyWithImpl<$Res>
    implements $SosPingCopyWith<$Res> {
  _$SosPingCopyWithImpl(this._self, this._then);

  final SosPing _self;
  final $Res Function(SosPing) _then;

/// Create a copy of SosPing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? alertId = null,Object? latitude = null,Object? longitude = null,Object? accuracy = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,alertId: null == alertId ? _self.alertId : alertId // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SosPing].
extension SosPingPatterns on SosPing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SosPing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SosPing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SosPing value)  $default,){
final _that = this;
switch (_that) {
case _SosPing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SosPing value)?  $default,){
final _that = this;
switch (_that) {
case _SosPing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String alertId,  double latitude,  double longitude,  double? accuracy,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SosPing() when $default != null:
return $default(_that.id,_that.alertId,_that.latitude,_that.longitude,_that.accuracy,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String alertId,  double latitude,  double longitude,  double? accuracy,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _SosPing():
return $default(_that.id,_that.alertId,_that.latitude,_that.longitude,_that.accuracy,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String alertId,  double latitude,  double longitude,  double? accuracy,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _SosPing() when $default != null:
return $default(_that.id,_that.alertId,_that.latitude,_that.longitude,_that.accuracy,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _SosPing implements SosPing {
  const _SosPing({required this.id, required this.alertId, required this.latitude, required this.longitude, this.accuracy, required this.createdAt});
  

@override final  String id;
@override final  String alertId;
@override final  double latitude;
@override final  double longitude;
@override final  double? accuracy;
@override final  DateTime createdAt;

/// Create a copy of SosPing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SosPingCopyWith<_SosPing> get copyWith => __$SosPingCopyWithImpl<_SosPing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SosPing&&(identical(other.id, id) || other.id == id)&&(identical(other.alertId, alertId) || other.alertId == alertId)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.accuracy, accuracy) || other.accuracy == accuracy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,alertId,latitude,longitude,accuracy,createdAt);

@override
String toString() {
  return 'SosPing(id: $id, alertId: $alertId, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$SosPingCopyWith<$Res> implements $SosPingCopyWith<$Res> {
  factory _$SosPingCopyWith(_SosPing value, $Res Function(_SosPing) _then) = __$SosPingCopyWithImpl;
@override @useResult
$Res call({
 String id, String alertId, double latitude, double longitude, double? accuracy, DateTime createdAt
});




}
/// @nodoc
class __$SosPingCopyWithImpl<$Res>
    implements _$SosPingCopyWith<$Res> {
  __$SosPingCopyWithImpl(this._self, this._then);

  final _SosPing _self;
  final $Res Function(_SosPing) _then;

/// Create a copy of SosPing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? alertId = null,Object? latitude = null,Object? longitude = null,Object? accuracy = freezed,Object? createdAt = null,}) {
  return _then(_SosPing(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,alertId: null == alertId ? _self.alertId : alertId // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,accuracy: freezed == accuracy ? _self.accuracy : accuracy // ignore: cast_nullable_to_non_nullable
as double?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

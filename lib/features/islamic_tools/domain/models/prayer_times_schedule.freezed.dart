// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'prayer_times_schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PrayerTimesSchedule {

 DateTime get date; String get fajr; String get sunrise; String get dhuhr; String get asr; String get maghrib; String get isha; double get latitude; double get longitude; bool get fromCachedLocation;
/// Create a copy of PrayerTimesSchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrayerTimesScheduleCopyWith<PrayerTimesSchedule> get copyWith => _$PrayerTimesScheduleCopyWithImpl<PrayerTimesSchedule>(this as PrayerTimesSchedule, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrayerTimesSchedule&&(identical(other.date, date) || other.date == date)&&(identical(other.fajr, fajr) || other.fajr == fajr)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.dhuhr, dhuhr) || other.dhuhr == dhuhr)&&(identical(other.asr, asr) || other.asr == asr)&&(identical(other.maghrib, maghrib) || other.maghrib == maghrib)&&(identical(other.isha, isha) || other.isha == isha)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.fromCachedLocation, fromCachedLocation) || other.fromCachedLocation == fromCachedLocation));
}


@override
int get hashCode => Object.hash(runtimeType,date,fajr,sunrise,dhuhr,asr,maghrib,isha,latitude,longitude,fromCachedLocation);

@override
String toString() {
  return 'PrayerTimesSchedule(date: $date, fajr: $fajr, sunrise: $sunrise, dhuhr: $dhuhr, asr: $asr, maghrib: $maghrib, isha: $isha, latitude: $latitude, longitude: $longitude, fromCachedLocation: $fromCachedLocation)';
}


}

/// @nodoc
abstract mixin class $PrayerTimesScheduleCopyWith<$Res>  {
  factory $PrayerTimesScheduleCopyWith(PrayerTimesSchedule value, $Res Function(PrayerTimesSchedule) _then) = _$PrayerTimesScheduleCopyWithImpl;
@useResult
$Res call({
 DateTime date, String fajr, String sunrise, String dhuhr, String asr, String maghrib, String isha, double latitude, double longitude, bool fromCachedLocation
});




}
/// @nodoc
class _$PrayerTimesScheduleCopyWithImpl<$Res>
    implements $PrayerTimesScheduleCopyWith<$Res> {
  _$PrayerTimesScheduleCopyWithImpl(this._self, this._then);

  final PrayerTimesSchedule _self;
  final $Res Function(PrayerTimesSchedule) _then;

/// Create a copy of PrayerTimesSchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? fajr = null,Object? sunrise = null,Object? dhuhr = null,Object? asr = null,Object? maghrib = null,Object? isha = null,Object? latitude = null,Object? longitude = null,Object? fromCachedLocation = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,fajr: null == fajr ? _self.fajr : fajr // ignore: cast_nullable_to_non_nullable
as String,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as String,dhuhr: null == dhuhr ? _self.dhuhr : dhuhr // ignore: cast_nullable_to_non_nullable
as String,asr: null == asr ? _self.asr : asr // ignore: cast_nullable_to_non_nullable
as String,maghrib: null == maghrib ? _self.maghrib : maghrib // ignore: cast_nullable_to_non_nullable
as String,isha: null == isha ? _self.isha : isha // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,fromCachedLocation: null == fromCachedLocation ? _self.fromCachedLocation : fromCachedLocation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PrayerTimesSchedule].
extension PrayerTimesSchedulePatterns on PrayerTimesSchedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrayerTimesSchedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrayerTimesSchedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrayerTimesSchedule value)  $default,){
final _that = this;
switch (_that) {
case _PrayerTimesSchedule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrayerTimesSchedule value)?  $default,){
final _that = this;
switch (_that) {
case _PrayerTimesSchedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  String fajr,  String sunrise,  String dhuhr,  String asr,  String maghrib,  String isha,  double latitude,  double longitude,  bool fromCachedLocation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrayerTimesSchedule() when $default != null:
return $default(_that.date,_that.fajr,_that.sunrise,_that.dhuhr,_that.asr,_that.maghrib,_that.isha,_that.latitude,_that.longitude,_that.fromCachedLocation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  String fajr,  String sunrise,  String dhuhr,  String asr,  String maghrib,  String isha,  double latitude,  double longitude,  bool fromCachedLocation)  $default,) {final _that = this;
switch (_that) {
case _PrayerTimesSchedule():
return $default(_that.date,_that.fajr,_that.sunrise,_that.dhuhr,_that.asr,_that.maghrib,_that.isha,_that.latitude,_that.longitude,_that.fromCachedLocation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  String fajr,  String sunrise,  String dhuhr,  String asr,  String maghrib,  String isha,  double latitude,  double longitude,  bool fromCachedLocation)?  $default,) {final _that = this;
switch (_that) {
case _PrayerTimesSchedule() when $default != null:
return $default(_that.date,_that.fajr,_that.sunrise,_that.dhuhr,_that.asr,_that.maghrib,_that.isha,_that.latitude,_that.longitude,_that.fromCachedLocation);case _:
  return null;

}
}

}

/// @nodoc


class _PrayerTimesSchedule implements PrayerTimesSchedule {
  const _PrayerTimesSchedule({required this.date, required this.fajr, required this.sunrise, required this.dhuhr, required this.asr, required this.maghrib, required this.isha, required this.latitude, required this.longitude, required this.fromCachedLocation});
  

@override final  DateTime date;
@override final  String fajr;
@override final  String sunrise;
@override final  String dhuhr;
@override final  String asr;
@override final  String maghrib;
@override final  String isha;
@override final  double latitude;
@override final  double longitude;
@override final  bool fromCachedLocation;

/// Create a copy of PrayerTimesSchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrayerTimesScheduleCopyWith<_PrayerTimesSchedule> get copyWith => __$PrayerTimesScheduleCopyWithImpl<_PrayerTimesSchedule>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrayerTimesSchedule&&(identical(other.date, date) || other.date == date)&&(identical(other.fajr, fajr) || other.fajr == fajr)&&(identical(other.sunrise, sunrise) || other.sunrise == sunrise)&&(identical(other.dhuhr, dhuhr) || other.dhuhr == dhuhr)&&(identical(other.asr, asr) || other.asr == asr)&&(identical(other.maghrib, maghrib) || other.maghrib == maghrib)&&(identical(other.isha, isha) || other.isha == isha)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.fromCachedLocation, fromCachedLocation) || other.fromCachedLocation == fromCachedLocation));
}


@override
int get hashCode => Object.hash(runtimeType,date,fajr,sunrise,dhuhr,asr,maghrib,isha,latitude,longitude,fromCachedLocation);

@override
String toString() {
  return 'PrayerTimesSchedule(date: $date, fajr: $fajr, sunrise: $sunrise, dhuhr: $dhuhr, asr: $asr, maghrib: $maghrib, isha: $isha, latitude: $latitude, longitude: $longitude, fromCachedLocation: $fromCachedLocation)';
}


}

/// @nodoc
abstract mixin class _$PrayerTimesScheduleCopyWith<$Res> implements $PrayerTimesScheduleCopyWith<$Res> {
  factory _$PrayerTimesScheduleCopyWith(_PrayerTimesSchedule value, $Res Function(_PrayerTimesSchedule) _then) = __$PrayerTimesScheduleCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, String fajr, String sunrise, String dhuhr, String asr, String maghrib, String isha, double latitude, double longitude, bool fromCachedLocation
});




}
/// @nodoc
class __$PrayerTimesScheduleCopyWithImpl<$Res>
    implements _$PrayerTimesScheduleCopyWith<$Res> {
  __$PrayerTimesScheduleCopyWithImpl(this._self, this._then);

  final _PrayerTimesSchedule _self;
  final $Res Function(_PrayerTimesSchedule) _then;

/// Create a copy of PrayerTimesSchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? fajr = null,Object? sunrise = null,Object? dhuhr = null,Object? asr = null,Object? maghrib = null,Object? isha = null,Object? latitude = null,Object? longitude = null,Object? fromCachedLocation = null,}) {
  return _then(_PrayerTimesSchedule(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,fajr: null == fajr ? _self.fajr : fajr // ignore: cast_nullable_to_non_nullable
as String,sunrise: null == sunrise ? _self.sunrise : sunrise // ignore: cast_nullable_to_non_nullable
as String,dhuhr: null == dhuhr ? _self.dhuhr : dhuhr // ignore: cast_nullable_to_non_nullable
as String,asr: null == asr ? _self.asr : asr // ignore: cast_nullable_to_non_nullable
as String,maghrib: null == maghrib ? _self.maghrib : maghrib // ignore: cast_nullable_to_non_nullable
as String,isha: null == isha ? _self.isha : isha // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,fromCachedLocation: null == fromCachedLocation ? _self.fromCachedLocation : fromCachedLocation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

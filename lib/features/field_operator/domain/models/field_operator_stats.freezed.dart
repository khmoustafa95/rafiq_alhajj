// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_operator_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FieldOperatorStats {

 int get total; int get pending; int get medicalDone; int get arrivedHotel; int get inTransit; int get completed; int get needsWheelchair; int get vaccinated;
/// Create a copy of FieldOperatorStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldOperatorStatsCopyWith<FieldOperatorStats> get copyWith => _$FieldOperatorStatsCopyWithImpl<FieldOperatorStats>(this as FieldOperatorStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldOperatorStats&&(identical(other.total, total) || other.total == total)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.medicalDone, medicalDone) || other.medicalDone == medicalDone)&&(identical(other.arrivedHotel, arrivedHotel) || other.arrivedHotel == arrivedHotel)&&(identical(other.inTransit, inTransit) || other.inTransit == inTransit)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.needsWheelchair, needsWheelchair) || other.needsWheelchair == needsWheelchair)&&(identical(other.vaccinated, vaccinated) || other.vaccinated == vaccinated));
}


@override
int get hashCode => Object.hash(runtimeType,total,pending,medicalDone,arrivedHotel,inTransit,completed,needsWheelchair,vaccinated);

@override
String toString() {
  return 'FieldOperatorStats(total: $total, pending: $pending, medicalDone: $medicalDone, arrivedHotel: $arrivedHotel, inTransit: $inTransit, completed: $completed, needsWheelchair: $needsWheelchair, vaccinated: $vaccinated)';
}


}

/// @nodoc
abstract mixin class $FieldOperatorStatsCopyWith<$Res>  {
  factory $FieldOperatorStatsCopyWith(FieldOperatorStats value, $Res Function(FieldOperatorStats) _then) = _$FieldOperatorStatsCopyWithImpl;
@useResult
$Res call({
 int total, int pending, int medicalDone, int arrivedHotel, int inTransit, int completed, int needsWheelchair, int vaccinated
});




}
/// @nodoc
class _$FieldOperatorStatsCopyWithImpl<$Res>
    implements $FieldOperatorStatsCopyWith<$Res> {
  _$FieldOperatorStatsCopyWithImpl(this._self, this._then);

  final FieldOperatorStats _self;
  final $Res Function(FieldOperatorStats) _then;

/// Create a copy of FieldOperatorStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? pending = null,Object? medicalDone = null,Object? arrivedHotel = null,Object? inTransit = null,Object? completed = null,Object? needsWheelchair = null,Object? vaccinated = null,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,medicalDone: null == medicalDone ? _self.medicalDone : medicalDone // ignore: cast_nullable_to_non_nullable
as int,arrivedHotel: null == arrivedHotel ? _self.arrivedHotel : arrivedHotel // ignore: cast_nullable_to_non_nullable
as int,inTransit: null == inTransit ? _self.inTransit : inTransit // ignore: cast_nullable_to_non_nullable
as int,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,needsWheelchair: null == needsWheelchair ? _self.needsWheelchair : needsWheelchair // ignore: cast_nullable_to_non_nullable
as int,vaccinated: null == vaccinated ? _self.vaccinated : vaccinated // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FieldOperatorStats].
extension FieldOperatorStatsPatterns on FieldOperatorStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FieldOperatorStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FieldOperatorStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FieldOperatorStats value)  $default,){
final _that = this;
switch (_that) {
case _FieldOperatorStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FieldOperatorStats value)?  $default,){
final _that = this;
switch (_that) {
case _FieldOperatorStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total,  int pending,  int medicalDone,  int arrivedHotel,  int inTransit,  int completed,  int needsWheelchair,  int vaccinated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FieldOperatorStats() when $default != null:
return $default(_that.total,_that.pending,_that.medicalDone,_that.arrivedHotel,_that.inTransit,_that.completed,_that.needsWheelchair,_that.vaccinated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total,  int pending,  int medicalDone,  int arrivedHotel,  int inTransit,  int completed,  int needsWheelchair,  int vaccinated)  $default,) {final _that = this;
switch (_that) {
case _FieldOperatorStats():
return $default(_that.total,_that.pending,_that.medicalDone,_that.arrivedHotel,_that.inTransit,_that.completed,_that.needsWheelchair,_that.vaccinated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total,  int pending,  int medicalDone,  int arrivedHotel,  int inTransit,  int completed,  int needsWheelchair,  int vaccinated)?  $default,) {final _that = this;
switch (_that) {
case _FieldOperatorStats() when $default != null:
return $default(_that.total,_that.pending,_that.medicalDone,_that.arrivedHotel,_that.inTransit,_that.completed,_that.needsWheelchair,_that.vaccinated);case _:
  return null;

}
}

}

/// @nodoc


class _FieldOperatorStats extends FieldOperatorStats {
  const _FieldOperatorStats({required this.total, required this.pending, required this.medicalDone, required this.arrivedHotel, required this.inTransit, required this.completed, required this.needsWheelchair, required this.vaccinated}): super._();
  

@override final  int total;
@override final  int pending;
@override final  int medicalDone;
@override final  int arrivedHotel;
@override final  int inTransit;
@override final  int completed;
@override final  int needsWheelchair;
@override final  int vaccinated;

/// Create a copy of FieldOperatorStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldOperatorStatsCopyWith<_FieldOperatorStats> get copyWith => __$FieldOperatorStatsCopyWithImpl<_FieldOperatorStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldOperatorStats&&(identical(other.total, total) || other.total == total)&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.medicalDone, medicalDone) || other.medicalDone == medicalDone)&&(identical(other.arrivedHotel, arrivedHotel) || other.arrivedHotel == arrivedHotel)&&(identical(other.inTransit, inTransit) || other.inTransit == inTransit)&&(identical(other.completed, completed) || other.completed == completed)&&(identical(other.needsWheelchair, needsWheelchair) || other.needsWheelchair == needsWheelchair)&&(identical(other.vaccinated, vaccinated) || other.vaccinated == vaccinated));
}


@override
int get hashCode => Object.hash(runtimeType,total,pending,medicalDone,arrivedHotel,inTransit,completed,needsWheelchair,vaccinated);

@override
String toString() {
  return 'FieldOperatorStats(total: $total, pending: $pending, medicalDone: $medicalDone, arrivedHotel: $arrivedHotel, inTransit: $inTransit, completed: $completed, needsWheelchair: $needsWheelchair, vaccinated: $vaccinated)';
}


}

/// @nodoc
abstract mixin class _$FieldOperatorStatsCopyWith<$Res> implements $FieldOperatorStatsCopyWith<$Res> {
  factory _$FieldOperatorStatsCopyWith(_FieldOperatorStats value, $Res Function(_FieldOperatorStats) _then) = __$FieldOperatorStatsCopyWithImpl;
@override @useResult
$Res call({
 int total, int pending, int medicalDone, int arrivedHotel, int inTransit, int completed, int needsWheelchair, int vaccinated
});




}
/// @nodoc
class __$FieldOperatorStatsCopyWithImpl<$Res>
    implements _$FieldOperatorStatsCopyWith<$Res> {
  __$FieldOperatorStatsCopyWithImpl(this._self, this._then);

  final _FieldOperatorStats _self;
  final $Res Function(_FieldOperatorStats) _then;

/// Create a copy of FieldOperatorStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? pending = null,Object? medicalDone = null,Object? arrivedHotel = null,Object? inTransit = null,Object? completed = null,Object? needsWheelchair = null,Object? vaccinated = null,}) {
  return _then(_FieldOperatorStats(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,medicalDone: null == medicalDone ? _self.medicalDone : medicalDone // ignore: cast_nullable_to_non_nullable
as int,arrivedHotel: null == arrivedHotel ? _self.arrivedHotel : arrivedHotel // ignore: cast_nullable_to_non_nullable
as int,inTransit: null == inTransit ? _self.inTransit : inTransit // ignore: cast_nullable_to_non_nullable
as int,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,needsWheelchair: null == needsWheelchair ? _self.needsWheelchair : needsWheelchair // ignore: cast_nullable_to_non_nullable
as int,vaccinated: null == vaccinated ? _self.vaccinated : vaccinated // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

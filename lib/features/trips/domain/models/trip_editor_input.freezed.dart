// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_editor_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TripEditorInput {

 String? get id; String get type; int get seasonYear; String get name; String get status; DateTime? get startDate; DateTime? get endDate;
/// Create a copy of TripEditorInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TripEditorInputCopyWith<TripEditorInput> get copyWith => _$TripEditorInputCopyWithImpl<TripEditorInput>(this as TripEditorInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TripEditorInput&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.seasonYear, seasonYear) || other.seasonYear == seasonYear)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,seasonYear,name,status,startDate,endDate);

@override
String toString() {
  return 'TripEditorInput(id: $id, type: $type, seasonYear: $seasonYear, name: $name, status: $status, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class $TripEditorInputCopyWith<$Res>  {
  factory $TripEditorInputCopyWith(TripEditorInput value, $Res Function(TripEditorInput) _then) = _$TripEditorInputCopyWithImpl;
@useResult
$Res call({
 String? id, String type, int seasonYear, String name, String status, DateTime? startDate, DateTime? endDate
});




}
/// @nodoc
class _$TripEditorInputCopyWithImpl<$Res>
    implements $TripEditorInputCopyWith<$Res> {
  _$TripEditorInputCopyWithImpl(this._self, this._then);

  final TripEditorInput _self;
  final $Res Function(TripEditorInput) _then;

/// Create a copy of TripEditorInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? type = null,Object? seasonYear = null,Object? name = null,Object? status = null,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,seasonYear: null == seasonYear ? _self.seasonYear : seasonYear // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TripEditorInput].
extension TripEditorInputPatterns on TripEditorInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TripEditorInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TripEditorInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TripEditorInput value)  $default,){
final _that = this;
switch (_that) {
case _TripEditorInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TripEditorInput value)?  $default,){
final _that = this;
switch (_that) {
case _TripEditorInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String type,  int seasonYear,  String name,  String status,  DateTime? startDate,  DateTime? endDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TripEditorInput() when $default != null:
return $default(_that.id,_that.type,_that.seasonYear,_that.name,_that.status,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String type,  int seasonYear,  String name,  String status,  DateTime? startDate,  DateTime? endDate)  $default,) {final _that = this;
switch (_that) {
case _TripEditorInput():
return $default(_that.id,_that.type,_that.seasonYear,_that.name,_that.status,_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String type,  int seasonYear,  String name,  String status,  DateTime? startDate,  DateTime? endDate)?  $default,) {final _that = this;
switch (_that) {
case _TripEditorInput() when $default != null:
return $default(_that.id,_that.type,_that.seasonYear,_that.name,_that.status,_that.startDate,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc


class _TripEditorInput implements TripEditorInput {
  const _TripEditorInput({this.id, required this.type, required this.seasonYear, required this.name, required this.status, this.startDate, this.endDate});
  

@override final  String? id;
@override final  String type;
@override final  int seasonYear;
@override final  String name;
@override final  String status;
@override final  DateTime? startDate;
@override final  DateTime? endDate;

/// Create a copy of TripEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TripEditorInputCopyWith<_TripEditorInput> get copyWith => __$TripEditorInputCopyWithImpl<_TripEditorInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TripEditorInput&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.seasonYear, seasonYear) || other.seasonYear == seasonYear)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,seasonYear,name,status,startDate,endDate);

@override
String toString() {
  return 'TripEditorInput(id: $id, type: $type, seasonYear: $seasonYear, name: $name, status: $status, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class _$TripEditorInputCopyWith<$Res> implements $TripEditorInputCopyWith<$Res> {
  factory _$TripEditorInputCopyWith(_TripEditorInput value, $Res Function(_TripEditorInput) _then) = __$TripEditorInputCopyWithImpl;
@override @useResult
$Res call({
 String? id, String type, int seasonYear, String name, String status, DateTime? startDate, DateTime? endDate
});




}
/// @nodoc
class __$TripEditorInputCopyWithImpl<$Res>
    implements _$TripEditorInputCopyWith<$Res> {
  __$TripEditorInputCopyWithImpl(this._self, this._then);

  final _TripEditorInput _self;
  final $Res Function(_TripEditorInput) _then;

/// Create a copy of TripEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? type = null,Object? seasonYear = null,Object? name = null,Object? status = null,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(_TripEditorInput(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,seasonYear: null == seasonYear ? _self.seasonYear : seasonYear // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on

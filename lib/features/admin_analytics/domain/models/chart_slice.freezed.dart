// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chart_slice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChartSlice {

 String get label; int get value;
/// Create a copy of ChartSlice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChartSliceCopyWith<ChartSlice> get copyWith => _$ChartSliceCopyWithImpl<ChartSlice>(this as ChartSlice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChartSlice&&(identical(other.label, label) || other.label == label)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,label,value);

@override
String toString() {
  return 'ChartSlice(label: $label, value: $value)';
}


}

/// @nodoc
abstract mixin class $ChartSliceCopyWith<$Res>  {
  factory $ChartSliceCopyWith(ChartSlice value, $Res Function(ChartSlice) _then) = _$ChartSliceCopyWithImpl;
@useResult
$Res call({
 String label, int value
});




}
/// @nodoc
class _$ChartSliceCopyWithImpl<$Res>
    implements $ChartSliceCopyWith<$Res> {
  _$ChartSliceCopyWithImpl(this._self, this._then);

  final ChartSlice _self;
  final $Res Function(ChartSlice) _then;

/// Create a copy of ChartSlice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? value = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChartSlice].
extension ChartSlicePatterns on ChartSlice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChartSlice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChartSlice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChartSlice value)  $default,){
final _that = this;
switch (_that) {
case _ChartSlice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChartSlice value)?  $default,){
final _that = this;
switch (_that) {
case _ChartSlice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  int value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChartSlice() when $default != null:
return $default(_that.label,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  int value)  $default,) {final _that = this;
switch (_that) {
case _ChartSlice():
return $default(_that.label,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  int value)?  $default,) {final _that = this;
switch (_that) {
case _ChartSlice() when $default != null:
return $default(_that.label,_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _ChartSlice implements ChartSlice {
  const _ChartSlice({required this.label, required this.value});
  

@override final  String label;
@override final  int value;

/// Create a copy of ChartSlice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChartSliceCopyWith<_ChartSlice> get copyWith => __$ChartSliceCopyWithImpl<_ChartSlice>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChartSlice&&(identical(other.label, label) || other.label == label)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,label,value);

@override
String toString() {
  return 'ChartSlice(label: $label, value: $value)';
}


}

/// @nodoc
abstract mixin class _$ChartSliceCopyWith<$Res> implements $ChartSliceCopyWith<$Res> {
  factory _$ChartSliceCopyWith(_ChartSlice value, $Res Function(_ChartSlice) _then) = __$ChartSliceCopyWithImpl;
@override @useResult
$Res call({
 String label, int value
});




}
/// @nodoc
class __$ChartSliceCopyWithImpl<$Res>
    implements _$ChartSliceCopyWith<$Res> {
  __$ChartSliceCopyWithImpl(this._self, this._then);

  final _ChartSlice _self;
  final $Res Function(_ChartSlice) _then;

/// Create a copy of ChartSlice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? value = null,}) {
  return _then(_ChartSlice(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

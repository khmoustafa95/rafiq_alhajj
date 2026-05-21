// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ritual_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RitualProgress {

 String get ritualKey; bool get isCompleted; DateTime? get completedAt; bool get pendingSync;
/// Create a copy of RitualProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RitualProgressCopyWith<RitualProgress> get copyWith => _$RitualProgressCopyWithImpl<RitualProgress>(this as RitualProgress, _$identity);

  /// Serializes this RitualProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RitualProgress&&(identical(other.ritualKey, ritualKey) || other.ritualKey == ritualKey)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.pendingSync, pendingSync) || other.pendingSync == pendingSync));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ritualKey,isCompleted,completedAt,pendingSync);

@override
String toString() {
  return 'RitualProgress(ritualKey: $ritualKey, isCompleted: $isCompleted, completedAt: $completedAt, pendingSync: $pendingSync)';
}


}

/// @nodoc
abstract mixin class $RitualProgressCopyWith<$Res>  {
  factory $RitualProgressCopyWith(RitualProgress value, $Res Function(RitualProgress) _then) = _$RitualProgressCopyWithImpl;
@useResult
$Res call({
 String ritualKey, bool isCompleted, DateTime? completedAt, bool pendingSync
});




}
/// @nodoc
class _$RitualProgressCopyWithImpl<$Res>
    implements $RitualProgressCopyWith<$Res> {
  _$RitualProgressCopyWithImpl(this._self, this._then);

  final RitualProgress _self;
  final $Res Function(RitualProgress) _then;

/// Create a copy of RitualProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ritualKey = null,Object? isCompleted = null,Object? completedAt = freezed,Object? pendingSync = null,}) {
  return _then(_self.copyWith(
ritualKey: null == ritualKey ? _self.ritualKey : ritualKey // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pendingSync: null == pendingSync ? _self.pendingSync : pendingSync // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RitualProgress].
extension RitualProgressPatterns on RitualProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RitualProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RitualProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RitualProgress value)  $default,){
final _that = this;
switch (_that) {
case _RitualProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RitualProgress value)?  $default,){
final _that = this;
switch (_that) {
case _RitualProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ritualKey,  bool isCompleted,  DateTime? completedAt,  bool pendingSync)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RitualProgress() when $default != null:
return $default(_that.ritualKey,_that.isCompleted,_that.completedAt,_that.pendingSync);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ritualKey,  bool isCompleted,  DateTime? completedAt,  bool pendingSync)  $default,) {final _that = this;
switch (_that) {
case _RitualProgress():
return $default(_that.ritualKey,_that.isCompleted,_that.completedAt,_that.pendingSync);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ritualKey,  bool isCompleted,  DateTime? completedAt,  bool pendingSync)?  $default,) {final _that = this;
switch (_that) {
case _RitualProgress() when $default != null:
return $default(_that.ritualKey,_that.isCompleted,_that.completedAt,_that.pendingSync);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RitualProgress implements RitualProgress {
  const _RitualProgress({required this.ritualKey, required this.isCompleted, this.completedAt, this.pendingSync = false});
  factory _RitualProgress.fromJson(Map<String, dynamic> json) => _$RitualProgressFromJson(json);

@override final  String ritualKey;
@override final  bool isCompleted;
@override final  DateTime? completedAt;
@override@JsonKey() final  bool pendingSync;

/// Create a copy of RitualProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RitualProgressCopyWith<_RitualProgress> get copyWith => __$RitualProgressCopyWithImpl<_RitualProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RitualProgressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RitualProgress&&(identical(other.ritualKey, ritualKey) || other.ritualKey == ritualKey)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.pendingSync, pendingSync) || other.pendingSync == pendingSync));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ritualKey,isCompleted,completedAt,pendingSync);

@override
String toString() {
  return 'RitualProgress(ritualKey: $ritualKey, isCompleted: $isCompleted, completedAt: $completedAt, pendingSync: $pendingSync)';
}


}

/// @nodoc
abstract mixin class _$RitualProgressCopyWith<$Res> implements $RitualProgressCopyWith<$Res> {
  factory _$RitualProgressCopyWith(_RitualProgress value, $Res Function(_RitualProgress) _then) = __$RitualProgressCopyWithImpl;
@override @useResult
$Res call({
 String ritualKey, bool isCompleted, DateTime? completedAt, bool pendingSync
});




}
/// @nodoc
class __$RitualProgressCopyWithImpl<$Res>
    implements _$RitualProgressCopyWith<$Res> {
  __$RitualProgressCopyWithImpl(this._self, this._then);

  final _RitualProgress _self;
  final $Res Function(_RitualProgress) _then;

/// Create a copy of RitualProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ritualKey = null,Object? isCompleted = null,Object? completedAt = freezed,Object? pendingSync = null,}) {
  return _then(_RitualProgress(
ritualKey: null == ritualKey ? _self.ritualKey : ritualKey // ignore: cast_nullable_to_non_nullable
as String,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pendingSync: null == pendingSync ? _self.pendingSync : pendingSync // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

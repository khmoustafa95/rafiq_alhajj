// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ritual_step_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RitualStepStatus {

 RitualStepDefinition get definition; bool get isCompleted; DateTime? get completedAt; bool get pendingSync;
/// Create a copy of RitualStepStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RitualStepStatusCopyWith<RitualStepStatus> get copyWith => _$RitualStepStatusCopyWithImpl<RitualStepStatus>(this as RitualStepStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RitualStepStatus&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.pendingSync, pendingSync) || other.pendingSync == pendingSync));
}


@override
int get hashCode => Object.hash(runtimeType,definition,isCompleted,completedAt,pendingSync);

@override
String toString() {
  return 'RitualStepStatus(definition: $definition, isCompleted: $isCompleted, completedAt: $completedAt, pendingSync: $pendingSync)';
}


}

/// @nodoc
abstract mixin class $RitualStepStatusCopyWith<$Res>  {
  factory $RitualStepStatusCopyWith(RitualStepStatus value, $Res Function(RitualStepStatus) _then) = _$RitualStepStatusCopyWithImpl;
@useResult
$Res call({
 RitualStepDefinition definition, bool isCompleted, DateTime? completedAt, bool pendingSync
});




}
/// @nodoc
class _$RitualStepStatusCopyWithImpl<$Res>
    implements $RitualStepStatusCopyWith<$Res> {
  _$RitualStepStatusCopyWithImpl(this._self, this._then);

  final RitualStepStatus _self;
  final $Res Function(RitualStepStatus) _then;

/// Create a copy of RitualStepStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? definition = null,Object? isCompleted = null,Object? completedAt = freezed,Object? pendingSync = null,}) {
  return _then(_self.copyWith(
definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as RitualStepDefinition,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pendingSync: null == pendingSync ? _self.pendingSync : pendingSync // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RitualStepStatus].
extension RitualStepStatusPatterns on RitualStepStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RitualStepStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RitualStepStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RitualStepStatus value)  $default,){
final _that = this;
switch (_that) {
case _RitualStepStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RitualStepStatus value)?  $default,){
final _that = this;
switch (_that) {
case _RitualStepStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RitualStepDefinition definition,  bool isCompleted,  DateTime? completedAt,  bool pendingSync)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RitualStepStatus() when $default != null:
return $default(_that.definition,_that.isCompleted,_that.completedAt,_that.pendingSync);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RitualStepDefinition definition,  bool isCompleted,  DateTime? completedAt,  bool pendingSync)  $default,) {final _that = this;
switch (_that) {
case _RitualStepStatus():
return $default(_that.definition,_that.isCompleted,_that.completedAt,_that.pendingSync);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RitualStepDefinition definition,  bool isCompleted,  DateTime? completedAt,  bool pendingSync)?  $default,) {final _that = this;
switch (_that) {
case _RitualStepStatus() when $default != null:
return $default(_that.definition,_that.isCompleted,_that.completedAt,_that.pendingSync);case _:
  return null;

}
}

}

/// @nodoc


class _RitualStepStatus implements RitualStepStatus {
  const _RitualStepStatus({required this.definition, required this.isCompleted, this.completedAt, required this.pendingSync});
  

@override final  RitualStepDefinition definition;
@override final  bool isCompleted;
@override final  DateTime? completedAt;
@override final  bool pendingSync;

/// Create a copy of RitualStepStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RitualStepStatusCopyWith<_RitualStepStatus> get copyWith => __$RitualStepStatusCopyWithImpl<_RitualStepStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RitualStepStatus&&(identical(other.definition, definition) || other.definition == definition)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.pendingSync, pendingSync) || other.pendingSync == pendingSync));
}


@override
int get hashCode => Object.hash(runtimeType,definition,isCompleted,completedAt,pendingSync);

@override
String toString() {
  return 'RitualStepStatus(definition: $definition, isCompleted: $isCompleted, completedAt: $completedAt, pendingSync: $pendingSync)';
}


}

/// @nodoc
abstract mixin class _$RitualStepStatusCopyWith<$Res> implements $RitualStepStatusCopyWith<$Res> {
  factory _$RitualStepStatusCopyWith(_RitualStepStatus value, $Res Function(_RitualStepStatus) _then) = __$RitualStepStatusCopyWithImpl;
@override @useResult
$Res call({
 RitualStepDefinition definition, bool isCompleted, DateTime? completedAt, bool pendingSync
});




}
/// @nodoc
class __$RitualStepStatusCopyWithImpl<$Res>
    implements _$RitualStepStatusCopyWith<$Res> {
  __$RitualStepStatusCopyWithImpl(this._self, this._then);

  final _RitualStepStatus _self;
  final $Res Function(_RitualStepStatus) _then;

/// Create a copy of RitualStepStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? definition = null,Object? isCompleted = null,Object? completedAt = freezed,Object? pendingSync = null,}) {
  return _then(_RitualStepStatus(
definition: null == definition ? _self.definition : definition // ignore: cast_nullable_to_non_nullable
as RitualStepDefinition,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pendingSync: null == pendingSync ? _self.pendingSync : pendingSync // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pilgrim_dashboard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PilgrimDashboard {

 PilgrimDetails? get logistics; List<RitualStepStatus> get rituals; bool get hasPendingSync;
/// Create a copy of PilgrimDashboard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PilgrimDashboardCopyWith<PilgrimDashboard> get copyWith => _$PilgrimDashboardCopyWithImpl<PilgrimDashboard>(this as PilgrimDashboard, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PilgrimDashboard&&(identical(other.logistics, logistics) || other.logistics == logistics)&&const DeepCollectionEquality().equals(other.rituals, rituals)&&(identical(other.hasPendingSync, hasPendingSync) || other.hasPendingSync == hasPendingSync));
}


@override
int get hashCode => Object.hash(runtimeType,logistics,const DeepCollectionEquality().hash(rituals),hasPendingSync);

@override
String toString() {
  return 'PilgrimDashboard(logistics: $logistics, rituals: $rituals, hasPendingSync: $hasPendingSync)';
}


}

/// @nodoc
abstract mixin class $PilgrimDashboardCopyWith<$Res>  {
  factory $PilgrimDashboardCopyWith(PilgrimDashboard value, $Res Function(PilgrimDashboard) _then) = _$PilgrimDashboardCopyWithImpl;
@useResult
$Res call({
 PilgrimDetails? logistics, List<RitualStepStatus> rituals, bool hasPendingSync
});


$PilgrimDetailsCopyWith<$Res>? get logistics;

}
/// @nodoc
class _$PilgrimDashboardCopyWithImpl<$Res>
    implements $PilgrimDashboardCopyWith<$Res> {
  _$PilgrimDashboardCopyWithImpl(this._self, this._then);

  final PilgrimDashboard _self;
  final $Res Function(PilgrimDashboard) _then;

/// Create a copy of PilgrimDashboard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? logistics = freezed,Object? rituals = null,Object? hasPendingSync = null,}) {
  return _then(_self.copyWith(
logistics: freezed == logistics ? _self.logistics : logistics // ignore: cast_nullable_to_non_nullable
as PilgrimDetails?,rituals: null == rituals ? _self.rituals : rituals // ignore: cast_nullable_to_non_nullable
as List<RitualStepStatus>,hasPendingSync: null == hasPendingSync ? _self.hasPendingSync : hasPendingSync // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PilgrimDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PilgrimDetailsCopyWith<$Res>? get logistics {
    if (_self.logistics == null) {
    return null;
  }

  return $PilgrimDetailsCopyWith<$Res>(_self.logistics!, (value) {
    return _then(_self.copyWith(logistics: value));
  });
}
}


/// Adds pattern-matching-related methods to [PilgrimDashboard].
extension PilgrimDashboardPatterns on PilgrimDashboard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PilgrimDashboard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PilgrimDashboard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PilgrimDashboard value)  $default,){
final _that = this;
switch (_that) {
case _PilgrimDashboard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PilgrimDashboard value)?  $default,){
final _that = this;
switch (_that) {
case _PilgrimDashboard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PilgrimDetails? logistics,  List<RitualStepStatus> rituals,  bool hasPendingSync)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PilgrimDashboard() when $default != null:
return $default(_that.logistics,_that.rituals,_that.hasPendingSync);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PilgrimDetails? logistics,  List<RitualStepStatus> rituals,  bool hasPendingSync)  $default,) {final _that = this;
switch (_that) {
case _PilgrimDashboard():
return $default(_that.logistics,_that.rituals,_that.hasPendingSync);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PilgrimDetails? logistics,  List<RitualStepStatus> rituals,  bool hasPendingSync)?  $default,) {final _that = this;
switch (_that) {
case _PilgrimDashboard() when $default != null:
return $default(_that.logistics,_that.rituals,_that.hasPendingSync);case _:
  return null;

}
}

}

/// @nodoc


class _PilgrimDashboard extends PilgrimDashboard {
  const _PilgrimDashboard({required this.logistics, required final  List<RitualStepStatus> rituals, required this.hasPendingSync}): _rituals = rituals,super._();
  

@override final  PilgrimDetails? logistics;
 final  List<RitualStepStatus> _rituals;
@override List<RitualStepStatus> get rituals {
  if (_rituals is EqualUnmodifiableListView) return _rituals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rituals);
}

@override final  bool hasPendingSync;

/// Create a copy of PilgrimDashboard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PilgrimDashboardCopyWith<_PilgrimDashboard> get copyWith => __$PilgrimDashboardCopyWithImpl<_PilgrimDashboard>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PilgrimDashboard&&(identical(other.logistics, logistics) || other.logistics == logistics)&&const DeepCollectionEquality().equals(other._rituals, _rituals)&&(identical(other.hasPendingSync, hasPendingSync) || other.hasPendingSync == hasPendingSync));
}


@override
int get hashCode => Object.hash(runtimeType,logistics,const DeepCollectionEquality().hash(_rituals),hasPendingSync);

@override
String toString() {
  return 'PilgrimDashboard(logistics: $logistics, rituals: $rituals, hasPendingSync: $hasPendingSync)';
}


}

/// @nodoc
abstract mixin class _$PilgrimDashboardCopyWith<$Res> implements $PilgrimDashboardCopyWith<$Res> {
  factory _$PilgrimDashboardCopyWith(_PilgrimDashboard value, $Res Function(_PilgrimDashboard) _then) = __$PilgrimDashboardCopyWithImpl;
@override @useResult
$Res call({
 PilgrimDetails? logistics, List<RitualStepStatus> rituals, bool hasPendingSync
});


@override $PilgrimDetailsCopyWith<$Res>? get logistics;

}
/// @nodoc
class __$PilgrimDashboardCopyWithImpl<$Res>
    implements _$PilgrimDashboardCopyWith<$Res> {
  __$PilgrimDashboardCopyWithImpl(this._self, this._then);

  final _PilgrimDashboard _self;
  final $Res Function(_PilgrimDashboard) _then;

/// Create a copy of PilgrimDashboard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? logistics = freezed,Object? rituals = null,Object? hasPendingSync = null,}) {
  return _then(_PilgrimDashboard(
logistics: freezed == logistics ? _self.logistics : logistics // ignore: cast_nullable_to_non_nullable
as PilgrimDetails?,rituals: null == rituals ? _self._rituals : rituals // ignore: cast_nullable_to_non_nullable
as List<RitualStepStatus>,hasPendingSync: null == hasPendingSync ? _self.hasPendingSync : hasPendingSync // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PilgrimDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PilgrimDetailsCopyWith<$Res>? get logistics {
    if (_self.logistics == null) {
    return null;
  }

  return $PilgrimDetailsCopyWith<$Res>(_self.logistics!, (value) {
    return _then(_self.copyWith(logistics: value));
  });
}
}

// dart format on

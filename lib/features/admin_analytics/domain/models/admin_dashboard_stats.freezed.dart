// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_dashboard_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AdminDashboardStats {

 int get pilgrimCount; int get operatorCount; double get ritualCompletionPercent; List<ChartSlice> get pilgrimsByGroup; List<ChartSlice> get fieldStatusBreakdown; List<ChartSlice> get operatorDocumentUploads;
/// Create a copy of AdminDashboardStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminDashboardStatsCopyWith<AdminDashboardStats> get copyWith => _$AdminDashboardStatsCopyWithImpl<AdminDashboardStats>(this as AdminDashboardStats, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDashboardStats&&(identical(other.pilgrimCount, pilgrimCount) || other.pilgrimCount == pilgrimCount)&&(identical(other.operatorCount, operatorCount) || other.operatorCount == operatorCount)&&(identical(other.ritualCompletionPercent, ritualCompletionPercent) || other.ritualCompletionPercent == ritualCompletionPercent)&&const DeepCollectionEquality().equals(other.pilgrimsByGroup, pilgrimsByGroup)&&const DeepCollectionEquality().equals(other.fieldStatusBreakdown, fieldStatusBreakdown)&&const DeepCollectionEquality().equals(other.operatorDocumentUploads, operatorDocumentUploads));
}


@override
int get hashCode => Object.hash(runtimeType,pilgrimCount,operatorCount,ritualCompletionPercent,const DeepCollectionEquality().hash(pilgrimsByGroup),const DeepCollectionEquality().hash(fieldStatusBreakdown),const DeepCollectionEquality().hash(operatorDocumentUploads));

@override
String toString() {
  return 'AdminDashboardStats(pilgrimCount: $pilgrimCount, operatorCount: $operatorCount, ritualCompletionPercent: $ritualCompletionPercent, pilgrimsByGroup: $pilgrimsByGroup, fieldStatusBreakdown: $fieldStatusBreakdown, operatorDocumentUploads: $operatorDocumentUploads)';
}


}

/// @nodoc
abstract mixin class $AdminDashboardStatsCopyWith<$Res>  {
  factory $AdminDashboardStatsCopyWith(AdminDashboardStats value, $Res Function(AdminDashboardStats) _then) = _$AdminDashboardStatsCopyWithImpl;
@useResult
$Res call({
 int pilgrimCount, int operatorCount, double ritualCompletionPercent, List<ChartSlice> pilgrimsByGroup, List<ChartSlice> fieldStatusBreakdown, List<ChartSlice> operatorDocumentUploads
});




}
/// @nodoc
class _$AdminDashboardStatsCopyWithImpl<$Res>
    implements $AdminDashboardStatsCopyWith<$Res> {
  _$AdminDashboardStatsCopyWithImpl(this._self, this._then);

  final AdminDashboardStats _self;
  final $Res Function(AdminDashboardStats) _then;

/// Create a copy of AdminDashboardStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pilgrimCount = null,Object? operatorCount = null,Object? ritualCompletionPercent = null,Object? pilgrimsByGroup = null,Object? fieldStatusBreakdown = null,Object? operatorDocumentUploads = null,}) {
  return _then(_self.copyWith(
pilgrimCount: null == pilgrimCount ? _self.pilgrimCount : pilgrimCount // ignore: cast_nullable_to_non_nullable
as int,operatorCount: null == operatorCount ? _self.operatorCount : operatorCount // ignore: cast_nullable_to_non_nullable
as int,ritualCompletionPercent: null == ritualCompletionPercent ? _self.ritualCompletionPercent : ritualCompletionPercent // ignore: cast_nullable_to_non_nullable
as double,pilgrimsByGroup: null == pilgrimsByGroup ? _self.pilgrimsByGroup : pilgrimsByGroup // ignore: cast_nullable_to_non_nullable
as List<ChartSlice>,fieldStatusBreakdown: null == fieldStatusBreakdown ? _self.fieldStatusBreakdown : fieldStatusBreakdown // ignore: cast_nullable_to_non_nullable
as List<ChartSlice>,operatorDocumentUploads: null == operatorDocumentUploads ? _self.operatorDocumentUploads : operatorDocumentUploads // ignore: cast_nullable_to_non_nullable
as List<ChartSlice>,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminDashboardStats].
extension AdminDashboardStatsPatterns on AdminDashboardStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminDashboardStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminDashboardStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminDashboardStats value)  $default,){
final _that = this;
switch (_that) {
case _AdminDashboardStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminDashboardStats value)?  $default,){
final _that = this;
switch (_that) {
case _AdminDashboardStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pilgrimCount,  int operatorCount,  double ritualCompletionPercent,  List<ChartSlice> pilgrimsByGroup,  List<ChartSlice> fieldStatusBreakdown,  List<ChartSlice> operatorDocumentUploads)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminDashboardStats() when $default != null:
return $default(_that.pilgrimCount,_that.operatorCount,_that.ritualCompletionPercent,_that.pilgrimsByGroup,_that.fieldStatusBreakdown,_that.operatorDocumentUploads);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pilgrimCount,  int operatorCount,  double ritualCompletionPercent,  List<ChartSlice> pilgrimsByGroup,  List<ChartSlice> fieldStatusBreakdown,  List<ChartSlice> operatorDocumentUploads)  $default,) {final _that = this;
switch (_that) {
case _AdminDashboardStats():
return $default(_that.pilgrimCount,_that.operatorCount,_that.ritualCompletionPercent,_that.pilgrimsByGroup,_that.fieldStatusBreakdown,_that.operatorDocumentUploads);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pilgrimCount,  int operatorCount,  double ritualCompletionPercent,  List<ChartSlice> pilgrimsByGroup,  List<ChartSlice> fieldStatusBreakdown,  List<ChartSlice> operatorDocumentUploads)?  $default,) {final _that = this;
switch (_that) {
case _AdminDashboardStats() when $default != null:
return $default(_that.pilgrimCount,_that.operatorCount,_that.ritualCompletionPercent,_that.pilgrimsByGroup,_that.fieldStatusBreakdown,_that.operatorDocumentUploads);case _:
  return null;

}
}

}

/// @nodoc


class _AdminDashboardStats implements AdminDashboardStats {
  const _AdminDashboardStats({required this.pilgrimCount, required this.operatorCount, required this.ritualCompletionPercent, required final  List<ChartSlice> pilgrimsByGroup, required final  List<ChartSlice> fieldStatusBreakdown, required final  List<ChartSlice> operatorDocumentUploads}): _pilgrimsByGroup = pilgrimsByGroup,_fieldStatusBreakdown = fieldStatusBreakdown,_operatorDocumentUploads = operatorDocumentUploads;
  

@override final  int pilgrimCount;
@override final  int operatorCount;
@override final  double ritualCompletionPercent;
 final  List<ChartSlice> _pilgrimsByGroup;
@override List<ChartSlice> get pilgrimsByGroup {
  if (_pilgrimsByGroup is EqualUnmodifiableListView) return _pilgrimsByGroup;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pilgrimsByGroup);
}

 final  List<ChartSlice> _fieldStatusBreakdown;
@override List<ChartSlice> get fieldStatusBreakdown {
  if (_fieldStatusBreakdown is EqualUnmodifiableListView) return _fieldStatusBreakdown;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fieldStatusBreakdown);
}

 final  List<ChartSlice> _operatorDocumentUploads;
@override List<ChartSlice> get operatorDocumentUploads {
  if (_operatorDocumentUploads is EqualUnmodifiableListView) return _operatorDocumentUploads;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_operatorDocumentUploads);
}


/// Create a copy of AdminDashboardStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminDashboardStatsCopyWith<_AdminDashboardStats> get copyWith => __$AdminDashboardStatsCopyWithImpl<_AdminDashboardStats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminDashboardStats&&(identical(other.pilgrimCount, pilgrimCount) || other.pilgrimCount == pilgrimCount)&&(identical(other.operatorCount, operatorCount) || other.operatorCount == operatorCount)&&(identical(other.ritualCompletionPercent, ritualCompletionPercent) || other.ritualCompletionPercent == ritualCompletionPercent)&&const DeepCollectionEquality().equals(other._pilgrimsByGroup, _pilgrimsByGroup)&&const DeepCollectionEquality().equals(other._fieldStatusBreakdown, _fieldStatusBreakdown)&&const DeepCollectionEquality().equals(other._operatorDocumentUploads, _operatorDocumentUploads));
}


@override
int get hashCode => Object.hash(runtimeType,pilgrimCount,operatorCount,ritualCompletionPercent,const DeepCollectionEquality().hash(_pilgrimsByGroup),const DeepCollectionEquality().hash(_fieldStatusBreakdown),const DeepCollectionEquality().hash(_operatorDocumentUploads));

@override
String toString() {
  return 'AdminDashboardStats(pilgrimCount: $pilgrimCount, operatorCount: $operatorCount, ritualCompletionPercent: $ritualCompletionPercent, pilgrimsByGroup: $pilgrimsByGroup, fieldStatusBreakdown: $fieldStatusBreakdown, operatorDocumentUploads: $operatorDocumentUploads)';
}


}

/// @nodoc
abstract mixin class _$AdminDashboardStatsCopyWith<$Res> implements $AdminDashboardStatsCopyWith<$Res> {
  factory _$AdminDashboardStatsCopyWith(_AdminDashboardStats value, $Res Function(_AdminDashboardStats) _then) = __$AdminDashboardStatsCopyWithImpl;
@override @useResult
$Res call({
 int pilgrimCount, int operatorCount, double ritualCompletionPercent, List<ChartSlice> pilgrimsByGroup, List<ChartSlice> fieldStatusBreakdown, List<ChartSlice> operatorDocumentUploads
});




}
/// @nodoc
class __$AdminDashboardStatsCopyWithImpl<$Res>
    implements _$AdminDashboardStatsCopyWith<$Res> {
  __$AdminDashboardStatsCopyWithImpl(this._self, this._then);

  final _AdminDashboardStats _self;
  final $Res Function(_AdminDashboardStats) _then;

/// Create a copy of AdminDashboardStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pilgrimCount = null,Object? operatorCount = null,Object? ritualCompletionPercent = null,Object? pilgrimsByGroup = null,Object? fieldStatusBreakdown = null,Object? operatorDocumentUploads = null,}) {
  return _then(_AdminDashboardStats(
pilgrimCount: null == pilgrimCount ? _self.pilgrimCount : pilgrimCount // ignore: cast_nullable_to_non_nullable
as int,operatorCount: null == operatorCount ? _self.operatorCount : operatorCount // ignore: cast_nullable_to_non_nullable
as int,ritualCompletionPercent: null == ritualCompletionPercent ? _self.ritualCompletionPercent : ritualCompletionPercent // ignore: cast_nullable_to_non_nullable
as double,pilgrimsByGroup: null == pilgrimsByGroup ? _self._pilgrimsByGroup : pilgrimsByGroup // ignore: cast_nullable_to_non_nullable
as List<ChartSlice>,fieldStatusBreakdown: null == fieldStatusBreakdown ? _self._fieldStatusBreakdown : fieldStatusBreakdown // ignore: cast_nullable_to_non_nullable
as List<ChartSlice>,operatorDocumentUploads: null == operatorDocumentUploads ? _self._operatorDocumentUploads : operatorDocumentUploads // ignore: cast_nullable_to_non_nullable
as List<ChartSlice>,
  ));
}


}

// dart format on

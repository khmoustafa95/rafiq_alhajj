// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hajj_journey_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HajjJourneyStep {

 String get id; String get ritualKey; int get sortOrder; String get titleAr; String get titleEn; String get descriptionAr; String get descriptionEn; bool get isActive; List<HajjJourneyMedia> get media;
/// Create a copy of HajjJourneyStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HajjJourneyStepCopyWith<HajjJourneyStep> get copyWith => _$HajjJourneyStepCopyWithImpl<HajjJourneyStep>(this as HajjJourneyStep, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HajjJourneyStep&&(identical(other.id, id) || other.id == id)&&(identical(other.ritualKey, ritualKey) || other.ritualKey == ritualKey)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.titleAr, titleAr) || other.titleAr == titleAr)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.descriptionAr, descriptionAr) || other.descriptionAr == descriptionAr)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.media, media));
}


@override
int get hashCode => Object.hash(runtimeType,id,ritualKey,sortOrder,titleAr,titleEn,descriptionAr,descriptionEn,isActive,const DeepCollectionEquality().hash(media));

@override
String toString() {
  return 'HajjJourneyStep(id: $id, ritualKey: $ritualKey, sortOrder: $sortOrder, titleAr: $titleAr, titleEn: $titleEn, descriptionAr: $descriptionAr, descriptionEn: $descriptionEn, isActive: $isActive, media: $media)';
}


}

/// @nodoc
abstract mixin class $HajjJourneyStepCopyWith<$Res>  {
  factory $HajjJourneyStepCopyWith(HajjJourneyStep value, $Res Function(HajjJourneyStep) _then) = _$HajjJourneyStepCopyWithImpl;
@useResult
$Res call({
 String id, String ritualKey, int sortOrder, String titleAr, String titleEn, String descriptionAr, String descriptionEn, bool isActive, List<HajjJourneyMedia> media
});




}
/// @nodoc
class _$HajjJourneyStepCopyWithImpl<$Res>
    implements $HajjJourneyStepCopyWith<$Res> {
  _$HajjJourneyStepCopyWithImpl(this._self, this._then);

  final HajjJourneyStep _self;
  final $Res Function(HajjJourneyStep) _then;

/// Create a copy of HajjJourneyStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ritualKey = null,Object? sortOrder = null,Object? titleAr = null,Object? titleEn = null,Object? descriptionAr = null,Object? descriptionEn = null,Object? isActive = null,Object? media = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ritualKey: null == ritualKey ? _self.ritualKey : ritualKey // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,titleAr: null == titleAr ? _self.titleAr : titleAr // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,descriptionAr: null == descriptionAr ? _self.descriptionAr : descriptionAr // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as List<HajjJourneyMedia>,
  ));
}

}


/// Adds pattern-matching-related methods to [HajjJourneyStep].
extension HajjJourneyStepPatterns on HajjJourneyStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HajjJourneyStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HajjJourneyStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HajjJourneyStep value)  $default,){
final _that = this;
switch (_that) {
case _HajjJourneyStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HajjJourneyStep value)?  $default,){
final _that = this;
switch (_that) {
case _HajjJourneyStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ritualKey,  int sortOrder,  String titleAr,  String titleEn,  String descriptionAr,  String descriptionEn,  bool isActive,  List<HajjJourneyMedia> media)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HajjJourneyStep() when $default != null:
return $default(_that.id,_that.ritualKey,_that.sortOrder,_that.titleAr,_that.titleEn,_that.descriptionAr,_that.descriptionEn,_that.isActive,_that.media);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ritualKey,  int sortOrder,  String titleAr,  String titleEn,  String descriptionAr,  String descriptionEn,  bool isActive,  List<HajjJourneyMedia> media)  $default,) {final _that = this;
switch (_that) {
case _HajjJourneyStep():
return $default(_that.id,_that.ritualKey,_that.sortOrder,_that.titleAr,_that.titleEn,_that.descriptionAr,_that.descriptionEn,_that.isActive,_that.media);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ritualKey,  int sortOrder,  String titleAr,  String titleEn,  String descriptionAr,  String descriptionEn,  bool isActive,  List<HajjJourneyMedia> media)?  $default,) {final _that = this;
switch (_that) {
case _HajjJourneyStep() when $default != null:
return $default(_that.id,_that.ritualKey,_that.sortOrder,_that.titleAr,_that.titleEn,_that.descriptionAr,_that.descriptionEn,_that.isActive,_that.media);case _:
  return null;

}
}

}

/// @nodoc


class _HajjJourneyStep extends HajjJourneyStep {
  const _HajjJourneyStep({required this.id, required this.ritualKey, required this.sortOrder, required this.titleAr, required this.titleEn, required this.descriptionAr, required this.descriptionEn, this.isActive = true, final  List<HajjJourneyMedia> media = const []}): _media = media,super._();
  

@override final  String id;
@override final  String ritualKey;
@override final  int sortOrder;
@override final  String titleAr;
@override final  String titleEn;
@override final  String descriptionAr;
@override final  String descriptionEn;
@override@JsonKey() final  bool isActive;
 final  List<HajjJourneyMedia> _media;
@override@JsonKey() List<HajjJourneyMedia> get media {
  if (_media is EqualUnmodifiableListView) return _media;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_media);
}


/// Create a copy of HajjJourneyStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HajjJourneyStepCopyWith<_HajjJourneyStep> get copyWith => __$HajjJourneyStepCopyWithImpl<_HajjJourneyStep>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HajjJourneyStep&&(identical(other.id, id) || other.id == id)&&(identical(other.ritualKey, ritualKey) || other.ritualKey == ritualKey)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.titleAr, titleAr) || other.titleAr == titleAr)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.descriptionAr, descriptionAr) || other.descriptionAr == descriptionAr)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._media, _media));
}


@override
int get hashCode => Object.hash(runtimeType,id,ritualKey,sortOrder,titleAr,titleEn,descriptionAr,descriptionEn,isActive,const DeepCollectionEquality().hash(_media));

@override
String toString() {
  return 'HajjJourneyStep(id: $id, ritualKey: $ritualKey, sortOrder: $sortOrder, titleAr: $titleAr, titleEn: $titleEn, descriptionAr: $descriptionAr, descriptionEn: $descriptionEn, isActive: $isActive, media: $media)';
}


}

/// @nodoc
abstract mixin class _$HajjJourneyStepCopyWith<$Res> implements $HajjJourneyStepCopyWith<$Res> {
  factory _$HajjJourneyStepCopyWith(_HajjJourneyStep value, $Res Function(_HajjJourneyStep) _then) = __$HajjJourneyStepCopyWithImpl;
@override @useResult
$Res call({
 String id, String ritualKey, int sortOrder, String titleAr, String titleEn, String descriptionAr, String descriptionEn, bool isActive, List<HajjJourneyMedia> media
});




}
/// @nodoc
class __$HajjJourneyStepCopyWithImpl<$Res>
    implements _$HajjJourneyStepCopyWith<$Res> {
  __$HajjJourneyStepCopyWithImpl(this._self, this._then);

  final _HajjJourneyStep _self;
  final $Res Function(_HajjJourneyStep) _then;

/// Create a copy of HajjJourneyStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ritualKey = null,Object? sortOrder = null,Object? titleAr = null,Object? titleEn = null,Object? descriptionAr = null,Object? descriptionEn = null,Object? isActive = null,Object? media = null,}) {
  return _then(_HajjJourneyStep(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ritualKey: null == ritualKey ? _self.ritualKey : ritualKey // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,titleAr: null == titleAr ? _self.titleAr : titleAr // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,descriptionAr: null == descriptionAr ? _self.descriptionAr : descriptionAr // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,media: null == media ? _self._media : media // ignore: cast_nullable_to_non_nullable
as List<HajjJourneyMedia>,
  ));
}


}

/// @nodoc
mixin _$HajjJourneyStepWithStatus {

 HajjJourneyStep get step; bool get isCompleted; DateTime? get completedAt; bool get pendingSync;
/// Create a copy of HajjJourneyStepWithStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HajjJourneyStepWithStatusCopyWith<HajjJourneyStepWithStatus> get copyWith => _$HajjJourneyStepWithStatusCopyWithImpl<HajjJourneyStepWithStatus>(this as HajjJourneyStepWithStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HajjJourneyStepWithStatus&&(identical(other.step, step) || other.step == step)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.pendingSync, pendingSync) || other.pendingSync == pendingSync));
}


@override
int get hashCode => Object.hash(runtimeType,step,isCompleted,completedAt,pendingSync);

@override
String toString() {
  return 'HajjJourneyStepWithStatus(step: $step, isCompleted: $isCompleted, completedAt: $completedAt, pendingSync: $pendingSync)';
}


}

/// @nodoc
abstract mixin class $HajjJourneyStepWithStatusCopyWith<$Res>  {
  factory $HajjJourneyStepWithStatusCopyWith(HajjJourneyStepWithStatus value, $Res Function(HajjJourneyStepWithStatus) _then) = _$HajjJourneyStepWithStatusCopyWithImpl;
@useResult
$Res call({
 HajjJourneyStep step, bool isCompleted, DateTime? completedAt, bool pendingSync
});


$HajjJourneyStepCopyWith<$Res> get step;

}
/// @nodoc
class _$HajjJourneyStepWithStatusCopyWithImpl<$Res>
    implements $HajjJourneyStepWithStatusCopyWith<$Res> {
  _$HajjJourneyStepWithStatusCopyWithImpl(this._self, this._then);

  final HajjJourneyStepWithStatus _self;
  final $Res Function(HajjJourneyStepWithStatus) _then;

/// Create a copy of HajjJourneyStepWithStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? isCompleted = null,Object? completedAt = freezed,Object? pendingSync = null,}) {
  return _then(_self.copyWith(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as HajjJourneyStep,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pendingSync: null == pendingSync ? _self.pendingSync : pendingSync // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of HajjJourneyStepWithStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HajjJourneyStepCopyWith<$Res> get step {
  
  return $HajjJourneyStepCopyWith<$Res>(_self.step, (value) {
    return _then(_self.copyWith(step: value));
  });
}
}


/// Adds pattern-matching-related methods to [HajjJourneyStepWithStatus].
extension HajjJourneyStepWithStatusPatterns on HajjJourneyStepWithStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HajjJourneyStepWithStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HajjJourneyStepWithStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HajjJourneyStepWithStatus value)  $default,){
final _that = this;
switch (_that) {
case _HajjJourneyStepWithStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HajjJourneyStepWithStatus value)?  $default,){
final _that = this;
switch (_that) {
case _HajjJourneyStepWithStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HajjJourneyStep step,  bool isCompleted,  DateTime? completedAt,  bool pendingSync)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HajjJourneyStepWithStatus() when $default != null:
return $default(_that.step,_that.isCompleted,_that.completedAt,_that.pendingSync);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HajjJourneyStep step,  bool isCompleted,  DateTime? completedAt,  bool pendingSync)  $default,) {final _that = this;
switch (_that) {
case _HajjJourneyStepWithStatus():
return $default(_that.step,_that.isCompleted,_that.completedAt,_that.pendingSync);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HajjJourneyStep step,  bool isCompleted,  DateTime? completedAt,  bool pendingSync)?  $default,) {final _that = this;
switch (_that) {
case _HajjJourneyStepWithStatus() when $default != null:
return $default(_that.step,_that.isCompleted,_that.completedAt,_that.pendingSync);case _:
  return null;

}
}

}

/// @nodoc


class _HajjJourneyStepWithStatus implements HajjJourneyStepWithStatus {
  const _HajjJourneyStepWithStatus({required this.step, required this.isCompleted, this.completedAt, this.pendingSync = false});
  

@override final  HajjJourneyStep step;
@override final  bool isCompleted;
@override final  DateTime? completedAt;
@override@JsonKey() final  bool pendingSync;

/// Create a copy of HajjJourneyStepWithStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HajjJourneyStepWithStatusCopyWith<_HajjJourneyStepWithStatus> get copyWith => __$HajjJourneyStepWithStatusCopyWithImpl<_HajjJourneyStepWithStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HajjJourneyStepWithStatus&&(identical(other.step, step) || other.step == step)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.pendingSync, pendingSync) || other.pendingSync == pendingSync));
}


@override
int get hashCode => Object.hash(runtimeType,step,isCompleted,completedAt,pendingSync);

@override
String toString() {
  return 'HajjJourneyStepWithStatus(step: $step, isCompleted: $isCompleted, completedAt: $completedAt, pendingSync: $pendingSync)';
}


}

/// @nodoc
abstract mixin class _$HajjJourneyStepWithStatusCopyWith<$Res> implements $HajjJourneyStepWithStatusCopyWith<$Res> {
  factory _$HajjJourneyStepWithStatusCopyWith(_HajjJourneyStepWithStatus value, $Res Function(_HajjJourneyStepWithStatus) _then) = __$HajjJourneyStepWithStatusCopyWithImpl;
@override @useResult
$Res call({
 HajjJourneyStep step, bool isCompleted, DateTime? completedAt, bool pendingSync
});


@override $HajjJourneyStepCopyWith<$Res> get step;

}
/// @nodoc
class __$HajjJourneyStepWithStatusCopyWithImpl<$Res>
    implements _$HajjJourneyStepWithStatusCopyWith<$Res> {
  __$HajjJourneyStepWithStatusCopyWithImpl(this._self, this._then);

  final _HajjJourneyStepWithStatus _self;
  final $Res Function(_HajjJourneyStepWithStatus) _then;

/// Create a copy of HajjJourneyStepWithStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? isCompleted = null,Object? completedAt = freezed,Object? pendingSync = null,}) {
  return _then(_HajjJourneyStepWithStatus(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as HajjJourneyStep,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,pendingSync: null == pendingSync ? _self.pendingSync : pendingSync // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of HajjJourneyStepWithStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HajjJourneyStepCopyWith<$Res> get step {
  
  return $HajjJourneyStepCopyWith<$Res>(_self.step, (value) {
    return _then(_self.copyWith(step: value));
  });
}
}

/// @nodoc
mixin _$HajjJourneyState {

 List<HajjJourneyStepWithStatus> get steps; bool get hasPendingSync;
/// Create a copy of HajjJourneyState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HajjJourneyStateCopyWith<HajjJourneyState> get copyWith => _$HajjJourneyStateCopyWithImpl<HajjJourneyState>(this as HajjJourneyState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HajjJourneyState&&const DeepCollectionEquality().equals(other.steps, steps)&&(identical(other.hasPendingSync, hasPendingSync) || other.hasPendingSync == hasPendingSync));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(steps),hasPendingSync);

@override
String toString() {
  return 'HajjJourneyState(steps: $steps, hasPendingSync: $hasPendingSync)';
}


}

/// @nodoc
abstract mixin class $HajjJourneyStateCopyWith<$Res>  {
  factory $HajjJourneyStateCopyWith(HajjJourneyState value, $Res Function(HajjJourneyState) _then) = _$HajjJourneyStateCopyWithImpl;
@useResult
$Res call({
 List<HajjJourneyStepWithStatus> steps, bool hasPendingSync
});




}
/// @nodoc
class _$HajjJourneyStateCopyWithImpl<$Res>
    implements $HajjJourneyStateCopyWith<$Res> {
  _$HajjJourneyStateCopyWithImpl(this._self, this._then);

  final HajjJourneyState _self;
  final $Res Function(HajjJourneyState) _then;

/// Create a copy of HajjJourneyState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? steps = null,Object? hasPendingSync = null,}) {
  return _then(_self.copyWith(
steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<HajjJourneyStepWithStatus>,hasPendingSync: null == hasPendingSync ? _self.hasPendingSync : hasPendingSync // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HajjJourneyState].
extension HajjJourneyStatePatterns on HajjJourneyState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HajjJourneyState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HajjJourneyState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HajjJourneyState value)  $default,){
final _that = this;
switch (_that) {
case _HajjJourneyState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HajjJourneyState value)?  $default,){
final _that = this;
switch (_that) {
case _HajjJourneyState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HajjJourneyStepWithStatus> steps,  bool hasPendingSync)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HajjJourneyState() when $default != null:
return $default(_that.steps,_that.hasPendingSync);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HajjJourneyStepWithStatus> steps,  bool hasPendingSync)  $default,) {final _that = this;
switch (_that) {
case _HajjJourneyState():
return $default(_that.steps,_that.hasPendingSync);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HajjJourneyStepWithStatus> steps,  bool hasPendingSync)?  $default,) {final _that = this;
switch (_that) {
case _HajjJourneyState() when $default != null:
return $default(_that.steps,_that.hasPendingSync);case _:
  return null;

}
}

}

/// @nodoc


class _HajjJourneyState extends HajjJourneyState {
  const _HajjJourneyState({required final  List<HajjJourneyStepWithStatus> steps, this.hasPendingSync = false}): _steps = steps,super._();
  

 final  List<HajjJourneyStepWithStatus> _steps;
@override List<HajjJourneyStepWithStatus> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

@override@JsonKey() final  bool hasPendingSync;

/// Create a copy of HajjJourneyState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HajjJourneyStateCopyWith<_HajjJourneyState> get copyWith => __$HajjJourneyStateCopyWithImpl<_HajjJourneyState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HajjJourneyState&&const DeepCollectionEquality().equals(other._steps, _steps)&&(identical(other.hasPendingSync, hasPendingSync) || other.hasPendingSync == hasPendingSync));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_steps),hasPendingSync);

@override
String toString() {
  return 'HajjJourneyState(steps: $steps, hasPendingSync: $hasPendingSync)';
}


}

/// @nodoc
abstract mixin class _$HajjJourneyStateCopyWith<$Res> implements $HajjJourneyStateCopyWith<$Res> {
  factory _$HajjJourneyStateCopyWith(_HajjJourneyState value, $Res Function(_HajjJourneyState) _then) = __$HajjJourneyStateCopyWithImpl;
@override @useResult
$Res call({
 List<HajjJourneyStepWithStatus> steps, bool hasPendingSync
});




}
/// @nodoc
class __$HajjJourneyStateCopyWithImpl<$Res>
    implements _$HajjJourneyStateCopyWith<$Res> {
  __$HajjJourneyStateCopyWithImpl(this._self, this._then);

  final _HajjJourneyState _self;
  final $Res Function(_HajjJourneyState) _then;

/// Create a copy of HajjJourneyState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? steps = null,Object? hasPendingSync = null,}) {
  return _then(_HajjJourneyState(
steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<HajjJourneyStepWithStatus>,hasPendingSync: null == hasPendingSync ? _self.hasPendingSync : hasPendingSync // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$HajjJourneyEditorInput {

 String get ritualKey; int get sortOrder; String get titleAr; String get titleEn; String get descriptionAr; String get descriptionEn; bool get isActive;
/// Create a copy of HajjJourneyEditorInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HajjJourneyEditorInputCopyWith<HajjJourneyEditorInput> get copyWith => _$HajjJourneyEditorInputCopyWithImpl<HajjJourneyEditorInput>(this as HajjJourneyEditorInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HajjJourneyEditorInput&&(identical(other.ritualKey, ritualKey) || other.ritualKey == ritualKey)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.titleAr, titleAr) || other.titleAr == titleAr)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.descriptionAr, descriptionAr) || other.descriptionAr == descriptionAr)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,ritualKey,sortOrder,titleAr,titleEn,descriptionAr,descriptionEn,isActive);

@override
String toString() {
  return 'HajjJourneyEditorInput(ritualKey: $ritualKey, sortOrder: $sortOrder, titleAr: $titleAr, titleEn: $titleEn, descriptionAr: $descriptionAr, descriptionEn: $descriptionEn, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $HajjJourneyEditorInputCopyWith<$Res>  {
  factory $HajjJourneyEditorInputCopyWith(HajjJourneyEditorInput value, $Res Function(HajjJourneyEditorInput) _then) = _$HajjJourneyEditorInputCopyWithImpl;
@useResult
$Res call({
 String ritualKey, int sortOrder, String titleAr, String titleEn, String descriptionAr, String descriptionEn, bool isActive
});




}
/// @nodoc
class _$HajjJourneyEditorInputCopyWithImpl<$Res>
    implements $HajjJourneyEditorInputCopyWith<$Res> {
  _$HajjJourneyEditorInputCopyWithImpl(this._self, this._then);

  final HajjJourneyEditorInput _self;
  final $Res Function(HajjJourneyEditorInput) _then;

/// Create a copy of HajjJourneyEditorInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ritualKey = null,Object? sortOrder = null,Object? titleAr = null,Object? titleEn = null,Object? descriptionAr = null,Object? descriptionEn = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
ritualKey: null == ritualKey ? _self.ritualKey : ritualKey // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,titleAr: null == titleAr ? _self.titleAr : titleAr // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,descriptionAr: null == descriptionAr ? _self.descriptionAr : descriptionAr // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HajjJourneyEditorInput].
extension HajjJourneyEditorInputPatterns on HajjJourneyEditorInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HajjJourneyEditorInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HajjJourneyEditorInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HajjJourneyEditorInput value)  $default,){
final _that = this;
switch (_that) {
case _HajjJourneyEditorInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HajjJourneyEditorInput value)?  $default,){
final _that = this;
switch (_that) {
case _HajjJourneyEditorInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ritualKey,  int sortOrder,  String titleAr,  String titleEn,  String descriptionAr,  String descriptionEn,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HajjJourneyEditorInput() when $default != null:
return $default(_that.ritualKey,_that.sortOrder,_that.titleAr,_that.titleEn,_that.descriptionAr,_that.descriptionEn,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ritualKey,  int sortOrder,  String titleAr,  String titleEn,  String descriptionAr,  String descriptionEn,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _HajjJourneyEditorInput():
return $default(_that.ritualKey,_that.sortOrder,_that.titleAr,_that.titleEn,_that.descriptionAr,_that.descriptionEn,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ritualKey,  int sortOrder,  String titleAr,  String titleEn,  String descriptionAr,  String descriptionEn,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _HajjJourneyEditorInput() when $default != null:
return $default(_that.ritualKey,_that.sortOrder,_that.titleAr,_that.titleEn,_that.descriptionAr,_that.descriptionEn,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc


class _HajjJourneyEditorInput implements HajjJourneyEditorInput {
  const _HajjJourneyEditorInput({required this.ritualKey, required this.sortOrder, required this.titleAr, required this.titleEn, required this.descriptionAr, required this.descriptionEn, this.isActive = true});
  

@override final  String ritualKey;
@override final  int sortOrder;
@override final  String titleAr;
@override final  String titleEn;
@override final  String descriptionAr;
@override final  String descriptionEn;
@override@JsonKey() final  bool isActive;

/// Create a copy of HajjJourneyEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HajjJourneyEditorInputCopyWith<_HajjJourneyEditorInput> get copyWith => __$HajjJourneyEditorInputCopyWithImpl<_HajjJourneyEditorInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HajjJourneyEditorInput&&(identical(other.ritualKey, ritualKey) || other.ritualKey == ritualKey)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.titleAr, titleAr) || other.titleAr == titleAr)&&(identical(other.titleEn, titleEn) || other.titleEn == titleEn)&&(identical(other.descriptionAr, descriptionAr) || other.descriptionAr == descriptionAr)&&(identical(other.descriptionEn, descriptionEn) || other.descriptionEn == descriptionEn)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,ritualKey,sortOrder,titleAr,titleEn,descriptionAr,descriptionEn,isActive);

@override
String toString() {
  return 'HajjJourneyEditorInput(ritualKey: $ritualKey, sortOrder: $sortOrder, titleAr: $titleAr, titleEn: $titleEn, descriptionAr: $descriptionAr, descriptionEn: $descriptionEn, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$HajjJourneyEditorInputCopyWith<$Res> implements $HajjJourneyEditorInputCopyWith<$Res> {
  factory _$HajjJourneyEditorInputCopyWith(_HajjJourneyEditorInput value, $Res Function(_HajjJourneyEditorInput) _then) = __$HajjJourneyEditorInputCopyWithImpl;
@override @useResult
$Res call({
 String ritualKey, int sortOrder, String titleAr, String titleEn, String descriptionAr, String descriptionEn, bool isActive
});




}
/// @nodoc
class __$HajjJourneyEditorInputCopyWithImpl<$Res>
    implements _$HajjJourneyEditorInputCopyWith<$Res> {
  __$HajjJourneyEditorInputCopyWithImpl(this._self, this._then);

  final _HajjJourneyEditorInput _self;
  final $Res Function(_HajjJourneyEditorInput) _then;

/// Create a copy of HajjJourneyEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ritualKey = null,Object? sortOrder = null,Object? titleAr = null,Object? titleEn = null,Object? descriptionAr = null,Object? descriptionEn = null,Object? isActive = null,}) {
  return _then(_HajjJourneyEditorInput(
ritualKey: null == ritualKey ? _self.ritualKey : ritualKey // ignore: cast_nullable_to_non_nullable
as String,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,titleAr: null == titleAr ? _self.titleAr : titleAr // ignore: cast_nullable_to_non_nullable
as String,titleEn: null == titleEn ? _self.titleEn : titleEn // ignore: cast_nullable_to_non_nullable
as String,descriptionAr: null == descriptionAr ? _self.descriptionAr : descriptionAr // ignore: cast_nullable_to_non_nullable
as String,descriptionEn: null == descriptionEn ? _self.descriptionEn : descriptionEn // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$HajjJourneyMediaInput {

 HajjMediaType get mediaType; String get url; String? get title; int get sortOrder;
/// Create a copy of HajjJourneyMediaInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HajjJourneyMediaInputCopyWith<HajjJourneyMediaInput> get copyWith => _$HajjJourneyMediaInputCopyWithImpl<HajjJourneyMediaInput>(this as HajjJourneyMediaInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HajjJourneyMediaInput&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,mediaType,url,title,sortOrder);

@override
String toString() {
  return 'HajjJourneyMediaInput(mediaType: $mediaType, url: $url, title: $title, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $HajjJourneyMediaInputCopyWith<$Res>  {
  factory $HajjJourneyMediaInputCopyWith(HajjJourneyMediaInput value, $Res Function(HajjJourneyMediaInput) _then) = _$HajjJourneyMediaInputCopyWithImpl;
@useResult
$Res call({
 HajjMediaType mediaType, String url, String? title, int sortOrder
});




}
/// @nodoc
class _$HajjJourneyMediaInputCopyWithImpl<$Res>
    implements $HajjJourneyMediaInputCopyWith<$Res> {
  _$HajjJourneyMediaInputCopyWithImpl(this._self, this._then);

  final HajjJourneyMediaInput _self;
  final $Res Function(HajjJourneyMediaInput) _then;

/// Create a copy of HajjJourneyMediaInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mediaType = null,Object? url = null,Object? title = freezed,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as HajjMediaType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HajjJourneyMediaInput].
extension HajjJourneyMediaInputPatterns on HajjJourneyMediaInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HajjJourneyMediaInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HajjJourneyMediaInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HajjJourneyMediaInput value)  $default,){
final _that = this;
switch (_that) {
case _HajjJourneyMediaInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HajjJourneyMediaInput value)?  $default,){
final _that = this;
switch (_that) {
case _HajjJourneyMediaInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HajjMediaType mediaType,  String url,  String? title,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HajjJourneyMediaInput() when $default != null:
return $default(_that.mediaType,_that.url,_that.title,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HajjMediaType mediaType,  String url,  String? title,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _HajjJourneyMediaInput():
return $default(_that.mediaType,_that.url,_that.title,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HajjMediaType mediaType,  String url,  String? title,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _HajjJourneyMediaInput() when $default != null:
return $default(_that.mediaType,_that.url,_that.title,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _HajjJourneyMediaInput implements HajjJourneyMediaInput {
  const _HajjJourneyMediaInput({required this.mediaType, required this.url, this.title, this.sortOrder = 0});
  

@override final  HajjMediaType mediaType;
@override final  String url;
@override final  String? title;
@override@JsonKey() final  int sortOrder;

/// Create a copy of HajjJourneyMediaInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HajjJourneyMediaInputCopyWith<_HajjJourneyMediaInput> get copyWith => __$HajjJourneyMediaInputCopyWithImpl<_HajjJourneyMediaInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HajjJourneyMediaInput&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,mediaType,url,title,sortOrder);

@override
String toString() {
  return 'HajjJourneyMediaInput(mediaType: $mediaType, url: $url, title: $title, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$HajjJourneyMediaInputCopyWith<$Res> implements $HajjJourneyMediaInputCopyWith<$Res> {
  factory _$HajjJourneyMediaInputCopyWith(_HajjJourneyMediaInput value, $Res Function(_HajjJourneyMediaInput) _then) = __$HajjJourneyMediaInputCopyWithImpl;
@override @useResult
$Res call({
 HajjMediaType mediaType, String url, String? title, int sortOrder
});




}
/// @nodoc
class __$HajjJourneyMediaInputCopyWithImpl<$Res>
    implements _$HajjJourneyMediaInputCopyWith<$Res> {
  __$HajjJourneyMediaInputCopyWithImpl(this._self, this._then);

  final _HajjJourneyMediaInput _self;
  final $Res Function(_HajjJourneyMediaInput) _then;

/// Create a copy of HajjJourneyMediaInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mediaType = null,Object? url = null,Object? title = freezed,Object? sortOrder = null,}) {
  return _then(_HajjJourneyMediaInput(
mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as HajjMediaType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

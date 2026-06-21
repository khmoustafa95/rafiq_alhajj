// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pilgrim_intake_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PilgrimIntakeForm {

 String get fullName; String get email; String? get tripId; String? get groupId; Map<String, dynamic> get person; Map<String, dynamic> get enrollment;
/// Create a copy of PilgrimIntakeForm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PilgrimIntakeFormCopyWith<PilgrimIntakeForm> get copyWith => _$PilgrimIntakeFormCopyWithImpl<PilgrimIntakeForm>(this as PilgrimIntakeForm, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PilgrimIntakeForm&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&const DeepCollectionEquality().equals(other.person, person)&&const DeepCollectionEquality().equals(other.enrollment, enrollment));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,email,tripId,groupId,const DeepCollectionEquality().hash(person),const DeepCollectionEquality().hash(enrollment));

@override
String toString() {
  return 'PilgrimIntakeForm(fullName: $fullName, email: $email, tripId: $tripId, groupId: $groupId, person: $person, enrollment: $enrollment)';
}


}

/// @nodoc
abstract mixin class $PilgrimIntakeFormCopyWith<$Res>  {
  factory $PilgrimIntakeFormCopyWith(PilgrimIntakeForm value, $Res Function(PilgrimIntakeForm) _then) = _$PilgrimIntakeFormCopyWithImpl;
@useResult
$Res call({
 String fullName, String email, String? tripId, String? groupId, Map<String, dynamic> person, Map<String, dynamic> enrollment
});




}
/// @nodoc
class _$PilgrimIntakeFormCopyWithImpl<$Res>
    implements $PilgrimIntakeFormCopyWith<$Res> {
  _$PilgrimIntakeFormCopyWithImpl(this._self, this._then);

  final PilgrimIntakeForm _self;
  final $Res Function(PilgrimIntakeForm) _then;

/// Create a copy of PilgrimIntakeForm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? email = null,Object? tripId = freezed,Object? groupId = freezed,Object? person = null,Object? enrollment = null,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,person: null == person ? _self.person : person // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,enrollment: null == enrollment ? _self.enrollment : enrollment // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [PilgrimIntakeForm].
extension PilgrimIntakeFormPatterns on PilgrimIntakeForm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PilgrimIntakeForm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PilgrimIntakeForm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PilgrimIntakeForm value)  $default,){
final _that = this;
switch (_that) {
case _PilgrimIntakeForm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PilgrimIntakeForm value)?  $default,){
final _that = this;
switch (_that) {
case _PilgrimIntakeForm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String email,  String? tripId,  String? groupId,  Map<String, dynamic> person,  Map<String, dynamic> enrollment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PilgrimIntakeForm() when $default != null:
return $default(_that.fullName,_that.email,_that.tripId,_that.groupId,_that.person,_that.enrollment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String email,  String? tripId,  String? groupId,  Map<String, dynamic> person,  Map<String, dynamic> enrollment)  $default,) {final _that = this;
switch (_that) {
case _PilgrimIntakeForm():
return $default(_that.fullName,_that.email,_that.tripId,_that.groupId,_that.person,_that.enrollment);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String email,  String? tripId,  String? groupId,  Map<String, dynamic> person,  Map<String, dynamic> enrollment)?  $default,) {final _that = this;
switch (_that) {
case _PilgrimIntakeForm() when $default != null:
return $default(_that.fullName,_that.email,_that.tripId,_that.groupId,_that.person,_that.enrollment);case _:
  return null;

}
}

}

/// @nodoc


class _PilgrimIntakeForm implements PilgrimIntakeForm {
  const _PilgrimIntakeForm({required this.fullName, required this.email, this.tripId, this.groupId, final  Map<String, dynamic> person = const <String, dynamic>{}, final  Map<String, dynamic> enrollment = const <String, dynamic>{}}): _person = person,_enrollment = enrollment;
  

@override final  String fullName;
@override final  String email;
@override final  String? tripId;
@override final  String? groupId;
 final  Map<String, dynamic> _person;
@override@JsonKey() Map<String, dynamic> get person {
  if (_person is EqualUnmodifiableMapView) return _person;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_person);
}

 final  Map<String, dynamic> _enrollment;
@override@JsonKey() Map<String, dynamic> get enrollment {
  if (_enrollment is EqualUnmodifiableMapView) return _enrollment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_enrollment);
}


/// Create a copy of PilgrimIntakeForm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PilgrimIntakeFormCopyWith<_PilgrimIntakeForm> get copyWith => __$PilgrimIntakeFormCopyWithImpl<_PilgrimIntakeForm>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PilgrimIntakeForm&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.tripId, tripId) || other.tripId == tripId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&const DeepCollectionEquality().equals(other._person, _person)&&const DeepCollectionEquality().equals(other._enrollment, _enrollment));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,email,tripId,groupId,const DeepCollectionEquality().hash(_person),const DeepCollectionEquality().hash(_enrollment));

@override
String toString() {
  return 'PilgrimIntakeForm(fullName: $fullName, email: $email, tripId: $tripId, groupId: $groupId, person: $person, enrollment: $enrollment)';
}


}

/// @nodoc
abstract mixin class _$PilgrimIntakeFormCopyWith<$Res> implements $PilgrimIntakeFormCopyWith<$Res> {
  factory _$PilgrimIntakeFormCopyWith(_PilgrimIntakeForm value, $Res Function(_PilgrimIntakeForm) _then) = __$PilgrimIntakeFormCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String email, String? tripId, String? groupId, Map<String, dynamic> person, Map<String, dynamic> enrollment
});




}
/// @nodoc
class __$PilgrimIntakeFormCopyWithImpl<$Res>
    implements _$PilgrimIntakeFormCopyWith<$Res> {
  __$PilgrimIntakeFormCopyWithImpl(this._self, this._then);

  final _PilgrimIntakeForm _self;
  final $Res Function(_PilgrimIntakeForm) _then;

/// Create a copy of PilgrimIntakeForm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? email = null,Object? tripId = freezed,Object? groupId = freezed,Object? person = null,Object? enrollment = null,}) {
  return _then(_PilgrimIntakeForm(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,tripId: freezed == tripId ? _self.tripId : tripId // ignore: cast_nullable_to_non_nullable
as String?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,person: null == person ? _self._person : person // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,enrollment: null == enrollment ? _self._enrollment : enrollment // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on

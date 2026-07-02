// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'competition_editor_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompetitionEditorInput {

 String? get id; String get title; String? get description; DateTime get startsAt; DateTime get endsAt; bool get isActive;
/// Create a copy of CompetitionEditorInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompetitionEditorInputCopyWith<CompetitionEditorInput> get copyWith => _$CompetitionEditorInputCopyWithImpl<CompetitionEditorInput>(this as CompetitionEditorInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompetitionEditorInput&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,startsAt,endsAt,isActive);

@override
String toString() {
  return 'CompetitionEditorInput(id: $id, title: $title, description: $description, startsAt: $startsAt, endsAt: $endsAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $CompetitionEditorInputCopyWith<$Res>  {
  factory $CompetitionEditorInputCopyWith(CompetitionEditorInput value, $Res Function(CompetitionEditorInput) _then) = _$CompetitionEditorInputCopyWithImpl;
@useResult
$Res call({
 String? id, String title, String? description, DateTime startsAt, DateTime endsAt, bool isActive
});




}
/// @nodoc
class _$CompetitionEditorInputCopyWithImpl<$Res>
    implements $CompetitionEditorInputCopyWith<$Res> {
  _$CompetitionEditorInputCopyWithImpl(this._self, this._then);

  final CompetitionEditorInput _self;
  final $Res Function(CompetitionEditorInput) _then;

/// Create a copy of CompetitionEditorInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = null,Object? description = freezed,Object? startsAt = null,Object? endsAt = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CompetitionEditorInput].
extension CompetitionEditorInputPatterns on CompetitionEditorInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompetitionEditorInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompetitionEditorInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompetitionEditorInput value)  $default,){
final _that = this;
switch (_that) {
case _CompetitionEditorInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompetitionEditorInput value)?  $default,){
final _that = this;
switch (_that) {
case _CompetitionEditorInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String title,  String? description,  DateTime startsAt,  DateTime endsAt,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompetitionEditorInput() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.startsAt,_that.endsAt,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String title,  String? description,  DateTime startsAt,  DateTime endsAt,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _CompetitionEditorInput():
return $default(_that.id,_that.title,_that.description,_that.startsAt,_that.endsAt,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String title,  String? description,  DateTime startsAt,  DateTime endsAt,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _CompetitionEditorInput() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.startsAt,_that.endsAt,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc


class _CompetitionEditorInput extends CompetitionEditorInput {
  const _CompetitionEditorInput({this.id, required this.title, this.description, required this.startsAt, required this.endsAt, required this.isActive}): super._();
  

@override final  String? id;
@override final  String title;
@override final  String? description;
@override final  DateTime startsAt;
@override final  DateTime endsAt;
@override final  bool isActive;

/// Create a copy of CompetitionEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompetitionEditorInputCopyWith<_CompetitionEditorInput> get copyWith => __$CompetitionEditorInputCopyWithImpl<_CompetitionEditorInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompetitionEditorInput&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,startsAt,endsAt,isActive);

@override
String toString() {
  return 'CompetitionEditorInput(id: $id, title: $title, description: $description, startsAt: $startsAt, endsAt: $endsAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$CompetitionEditorInputCopyWith<$Res> implements $CompetitionEditorInputCopyWith<$Res> {
  factory _$CompetitionEditorInputCopyWith(_CompetitionEditorInput value, $Res Function(_CompetitionEditorInput) _then) = __$CompetitionEditorInputCopyWithImpl;
@override @useResult
$Res call({
 String? id, String title, String? description, DateTime startsAt, DateTime endsAt, bool isActive
});




}
/// @nodoc
class __$CompetitionEditorInputCopyWithImpl<$Res>
    implements _$CompetitionEditorInputCopyWith<$Res> {
  __$CompetitionEditorInputCopyWithImpl(this._self, this._then);

  final _CompetitionEditorInput _self;
  final $Res Function(_CompetitionEditorInput) _then;

/// Create a copy of CompetitionEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = null,Object? description = freezed,Object? startsAt = null,Object? endsAt = null,Object? isActive = null,}) {
  return _then(_CompetitionEditorInput(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

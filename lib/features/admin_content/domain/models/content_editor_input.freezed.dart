// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_editor_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContentEditorInput {

 String? get id; String get title; String? get description; String? get mediaUrl; ContentType get type; ContentVisibility get visibility;
/// Create a copy of ContentEditorInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentEditorInputCopyWith<ContentEditorInput> get copyWith => _$ContentEditorInputCopyWithImpl<ContentEditorInput>(this as ContentEditorInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentEditorInput&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.visibility, visibility) || other.visibility == visibility));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,mediaUrl,type,visibility);

@override
String toString() {
  return 'ContentEditorInput(id: $id, title: $title, description: $description, mediaUrl: $mediaUrl, type: $type, visibility: $visibility)';
}


}

/// @nodoc
abstract mixin class $ContentEditorInputCopyWith<$Res>  {
  factory $ContentEditorInputCopyWith(ContentEditorInput value, $Res Function(ContentEditorInput) _then) = _$ContentEditorInputCopyWithImpl;
@useResult
$Res call({
 String? id, String title, String? description, String? mediaUrl, ContentType type, ContentVisibility visibility
});




}
/// @nodoc
class _$ContentEditorInputCopyWithImpl<$Res>
    implements $ContentEditorInputCopyWith<$Res> {
  _$ContentEditorInputCopyWithImpl(this._self, this._then);

  final ContentEditorInput _self;
  final $Res Function(ContentEditorInput) _then;

/// Create a copy of ContentEditorInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = null,Object? description = freezed,Object? mediaUrl = freezed,Object? type = null,Object? visibility = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ContentType,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as ContentVisibility,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentEditorInput].
extension ContentEditorInputPatterns on ContentEditorInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentEditorInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentEditorInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentEditorInput value)  $default,){
final _that = this;
switch (_that) {
case _ContentEditorInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentEditorInput value)?  $default,){
final _that = this;
switch (_that) {
case _ContentEditorInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String title,  String? description,  String? mediaUrl,  ContentType type,  ContentVisibility visibility)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentEditorInput() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.mediaUrl,_that.type,_that.visibility);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String title,  String? description,  String? mediaUrl,  ContentType type,  ContentVisibility visibility)  $default,) {final _that = this;
switch (_that) {
case _ContentEditorInput():
return $default(_that.id,_that.title,_that.description,_that.mediaUrl,_that.type,_that.visibility);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String title,  String? description,  String? mediaUrl,  ContentType type,  ContentVisibility visibility)?  $default,) {final _that = this;
switch (_that) {
case _ContentEditorInput() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.mediaUrl,_that.type,_that.visibility);case _:
  return null;

}
}

}

/// @nodoc


class _ContentEditorInput extends ContentEditorInput {
  const _ContentEditorInput({this.id, required this.title, this.description, this.mediaUrl, required this.type, required this.visibility}): super._();
  

@override final  String? id;
@override final  String title;
@override final  String? description;
@override final  String? mediaUrl;
@override final  ContentType type;
@override final  ContentVisibility visibility;

/// Create a copy of ContentEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentEditorInputCopyWith<_ContentEditorInput> get copyWith => __$ContentEditorInputCopyWithImpl<_ContentEditorInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentEditorInput&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.visibility, visibility) || other.visibility == visibility));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,mediaUrl,type,visibility);

@override
String toString() {
  return 'ContentEditorInput(id: $id, title: $title, description: $description, mediaUrl: $mediaUrl, type: $type, visibility: $visibility)';
}


}

/// @nodoc
abstract mixin class _$ContentEditorInputCopyWith<$Res> implements $ContentEditorInputCopyWith<$Res> {
  factory _$ContentEditorInputCopyWith(_ContentEditorInput value, $Res Function(_ContentEditorInput) _then) = __$ContentEditorInputCopyWithImpl;
@override @useResult
$Res call({
 String? id, String title, String? description, String? mediaUrl, ContentType type, ContentVisibility visibility
});




}
/// @nodoc
class __$ContentEditorInputCopyWithImpl<$Res>
    implements _$ContentEditorInputCopyWith<$Res> {
  __$ContentEditorInputCopyWithImpl(this._self, this._then);

  final _ContentEditorInput _self;
  final $Res Function(_ContentEditorInput) _then;

/// Create a copy of ContentEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = null,Object? description = freezed,Object? mediaUrl = freezed,Object? type = null,Object? visibility = null,}) {
  return _then(_ContentEditorInput(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ContentType,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as ContentVisibility,
  ));
}


}

// dart format on

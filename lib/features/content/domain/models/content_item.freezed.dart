// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContentItem {

 String get id; String get title; String? get description; String? get mediaUrl; ContentType get type; ContentVisibility get visibility; DateTime get createdAt;
/// Create a copy of ContentItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentItemCopyWith<ContentItem> get copyWith => _$ContentItemCopyWithImpl<ContentItem>(this as ContentItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,mediaUrl,type,visibility,createdAt);

@override
String toString() {
  return 'ContentItem(id: $id, title: $title, description: $description, mediaUrl: $mediaUrl, type: $type, visibility: $visibility, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ContentItemCopyWith<$Res>  {
  factory $ContentItemCopyWith(ContentItem value, $Res Function(ContentItem) _then) = _$ContentItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, String? mediaUrl, ContentType type, ContentVisibility visibility, DateTime createdAt
});




}
/// @nodoc
class _$ContentItemCopyWithImpl<$Res>
    implements $ContentItemCopyWith<$Res> {
  _$ContentItemCopyWithImpl(this._self, this._then);

  final ContentItem _self;
  final $Res Function(ContentItem) _then;

/// Create a copy of ContentItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? mediaUrl = freezed,Object? type = null,Object? visibility = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ContentType,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as ContentVisibility,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentItem].
extension ContentItemPatterns on ContentItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentItem value)  $default,){
final _that = this;
switch (_that) {
case _ContentItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentItem value)?  $default,){
final _that = this;
switch (_that) {
case _ContentItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? mediaUrl,  ContentType type,  ContentVisibility visibility,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentItem() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.mediaUrl,_that.type,_that.visibility,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? mediaUrl,  ContentType type,  ContentVisibility visibility,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ContentItem():
return $default(_that.id,_that.title,_that.description,_that.mediaUrl,_that.type,_that.visibility,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  String? mediaUrl,  ContentType type,  ContentVisibility visibility,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ContentItem() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.mediaUrl,_that.type,_that.visibility,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _ContentItem implements ContentItem {
  const _ContentItem({required this.id, required this.title, required this.description, required this.mediaUrl, required this.type, required this.visibility, required this.createdAt});
  

@override final  String id;
@override final  String title;
@override final  String? description;
@override final  String? mediaUrl;
@override final  ContentType type;
@override final  ContentVisibility visibility;
@override final  DateTime createdAt;

/// Create a copy of ContentItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentItemCopyWith<_ContentItem> get copyWith => __$ContentItemCopyWithImpl<_ContentItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,mediaUrl,type,visibility,createdAt);

@override
String toString() {
  return 'ContentItem(id: $id, title: $title, description: $description, mediaUrl: $mediaUrl, type: $type, visibility: $visibility, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ContentItemCopyWith<$Res> implements $ContentItemCopyWith<$Res> {
  factory _$ContentItemCopyWith(_ContentItem value, $Res Function(_ContentItem) _then) = __$ContentItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, String? mediaUrl, ContentType type, ContentVisibility visibility, DateTime createdAt
});




}
/// @nodoc
class __$ContentItemCopyWithImpl<$Res>
    implements _$ContentItemCopyWith<$Res> {
  __$ContentItemCopyWithImpl(this._self, this._then);

  final _ContentItem _self;
  final $Res Function(_ContentItem) _then;

/// Create a copy of ContentItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? mediaUrl = freezed,Object? type = null,Object? visibility = null,Object? createdAt = null,}) {
  return _then(_ContentItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ContentType,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as ContentVisibility,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

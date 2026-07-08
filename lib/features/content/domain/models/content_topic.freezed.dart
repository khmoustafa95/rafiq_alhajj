// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_topic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContentTopicMedia {

 String get id; EducationalMediaType get mediaType; String get url; String? get title; int get sortOrder;
/// Create a copy of ContentTopicMedia
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentTopicMediaCopyWith<ContentTopicMedia> get copyWith => _$ContentTopicMediaCopyWithImpl<ContentTopicMedia>(this as ContentTopicMedia, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentTopicMedia&&(identical(other.id, id) || other.id == id)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,mediaType,url,title,sortOrder);

@override
String toString() {
  return 'ContentTopicMedia(id: $id, mediaType: $mediaType, url: $url, title: $title, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $ContentTopicMediaCopyWith<$Res>  {
  factory $ContentTopicMediaCopyWith(ContentTopicMedia value, $Res Function(ContentTopicMedia) _then) = _$ContentTopicMediaCopyWithImpl;
@useResult
$Res call({
 String id, EducationalMediaType mediaType, String url, String? title, int sortOrder
});




}
/// @nodoc
class _$ContentTopicMediaCopyWithImpl<$Res>
    implements $ContentTopicMediaCopyWith<$Res> {
  _$ContentTopicMediaCopyWithImpl(this._self, this._then);

  final ContentTopicMedia _self;
  final $Res Function(ContentTopicMedia) _then;

/// Create a copy of ContentTopicMedia
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mediaType = null,Object? url = null,Object? title = freezed,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as EducationalMediaType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentTopicMedia].
extension ContentTopicMediaPatterns on ContentTopicMedia {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentTopicMedia value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentTopicMedia() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentTopicMedia value)  $default,){
final _that = this;
switch (_that) {
case _ContentTopicMedia():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentTopicMedia value)?  $default,){
final _that = this;
switch (_that) {
case _ContentTopicMedia() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  EducationalMediaType mediaType,  String url,  String? title,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentTopicMedia() when $default != null:
return $default(_that.id,_that.mediaType,_that.url,_that.title,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  EducationalMediaType mediaType,  String url,  String? title,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _ContentTopicMedia():
return $default(_that.id,_that.mediaType,_that.url,_that.title,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  EducationalMediaType mediaType,  String url,  String? title,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _ContentTopicMedia() when $default != null:
return $default(_that.id,_that.mediaType,_that.url,_that.title,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _ContentTopicMedia extends ContentTopicMedia {
  const _ContentTopicMedia({required this.id, required this.mediaType, required this.url, this.title, this.sortOrder = 0}): super._();
  

@override final  String id;
@override final  EducationalMediaType mediaType;
@override final  String url;
@override final  String? title;
@override@JsonKey() final  int sortOrder;

/// Create a copy of ContentTopicMedia
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentTopicMediaCopyWith<_ContentTopicMedia> get copyWith => __$ContentTopicMediaCopyWithImpl<_ContentTopicMedia>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentTopicMedia&&(identical(other.id, id) || other.id == id)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,mediaType,url,title,sortOrder);

@override
String toString() {
  return 'ContentTopicMedia(id: $id, mediaType: $mediaType, url: $url, title: $title, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$ContentTopicMediaCopyWith<$Res> implements $ContentTopicMediaCopyWith<$Res> {
  factory _$ContentTopicMediaCopyWith(_ContentTopicMedia value, $Res Function(_ContentTopicMedia) _then) = __$ContentTopicMediaCopyWithImpl;
@override @useResult
$Res call({
 String id, EducationalMediaType mediaType, String url, String? title, int sortOrder
});




}
/// @nodoc
class __$ContentTopicMediaCopyWithImpl<$Res>
    implements _$ContentTopicMediaCopyWith<$Res> {
  __$ContentTopicMediaCopyWithImpl(this._self, this._then);

  final _ContentTopicMedia _self;
  final $Res Function(_ContentTopicMedia) _then;

/// Create a copy of ContentTopicMedia
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mediaType = null,Object? url = null,Object? title = freezed,Object? sortOrder = null,}) {
  return _then(_ContentTopicMedia(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as EducationalMediaType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ContentTopic {

 String get id; String get title; String? get description; String? get coverImageUrl; ContentVisibility get visibility; int get sortOrder; bool get isActive; List<ContentTopicMedia> get media; DateTime get createdAt;
/// Create a copy of ContentTopic
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentTopicCopyWith<ContentTopic> get copyWith => _$ContentTopicCopyWithImpl<ContentTopic>(this as ContentTopic, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentTopic&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.media, media)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,coverImageUrl,visibility,sortOrder,isActive,const DeepCollectionEquality().hash(media),createdAt);

@override
String toString() {
  return 'ContentTopic(id: $id, title: $title, description: $description, coverImageUrl: $coverImageUrl, visibility: $visibility, sortOrder: $sortOrder, isActive: $isActive, media: $media, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ContentTopicCopyWith<$Res>  {
  factory $ContentTopicCopyWith(ContentTopic value, $Res Function(ContentTopic) _then) = _$ContentTopicCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, String? coverImageUrl, ContentVisibility visibility, int sortOrder, bool isActive, List<ContentTopicMedia> media, DateTime createdAt
});




}
/// @nodoc
class _$ContentTopicCopyWithImpl<$Res>
    implements $ContentTopicCopyWith<$Res> {
  _$ContentTopicCopyWithImpl(this._self, this._then);

  final ContentTopic _self;
  final $Res Function(ContentTopic) _then;

/// Create a copy of ContentTopic
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? coverImageUrl = freezed,Object? visibility = null,Object? sortOrder = null,Object? isActive = null,Object? media = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as ContentVisibility,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as List<ContentTopicMedia>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentTopic].
extension ContentTopicPatterns on ContentTopic {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentTopic value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentTopic() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentTopic value)  $default,){
final _that = this;
switch (_that) {
case _ContentTopic():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentTopic value)?  $default,){
final _that = this;
switch (_that) {
case _ContentTopic() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? coverImageUrl,  ContentVisibility visibility,  int sortOrder,  bool isActive,  List<ContentTopicMedia> media,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentTopic() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.coverImageUrl,_that.visibility,_that.sortOrder,_that.isActive,_that.media,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? coverImageUrl,  ContentVisibility visibility,  int sortOrder,  bool isActive,  List<ContentTopicMedia> media,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ContentTopic():
return $default(_that.id,_that.title,_that.description,_that.coverImageUrl,_that.visibility,_that.sortOrder,_that.isActive,_that.media,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  String? coverImageUrl,  ContentVisibility visibility,  int sortOrder,  bool isActive,  List<ContentTopicMedia> media,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ContentTopic() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.coverImageUrl,_that.visibility,_that.sortOrder,_that.isActive,_that.media,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _ContentTopic extends ContentTopic {
  const _ContentTopic({required this.id, required this.title, this.description, this.coverImageUrl, required this.visibility, this.sortOrder = 0, this.isActive = true, final  List<ContentTopicMedia> media = const [], required this.createdAt}): _media = media,super._();
  

@override final  String id;
@override final  String title;
@override final  String? description;
@override final  String? coverImageUrl;
@override final  ContentVisibility visibility;
@override@JsonKey() final  int sortOrder;
@override@JsonKey() final  bool isActive;
 final  List<ContentTopicMedia> _media;
@override@JsonKey() List<ContentTopicMedia> get media {
  if (_media is EqualUnmodifiableListView) return _media;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_media);
}

@override final  DateTime createdAt;

/// Create a copy of ContentTopic
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentTopicCopyWith<_ContentTopic> get copyWith => __$ContentTopicCopyWithImpl<_ContentTopic>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentTopic&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._media, _media)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,coverImageUrl,visibility,sortOrder,isActive,const DeepCollectionEquality().hash(_media),createdAt);

@override
String toString() {
  return 'ContentTopic(id: $id, title: $title, description: $description, coverImageUrl: $coverImageUrl, visibility: $visibility, sortOrder: $sortOrder, isActive: $isActive, media: $media, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ContentTopicCopyWith<$Res> implements $ContentTopicCopyWith<$Res> {
  factory _$ContentTopicCopyWith(_ContentTopic value, $Res Function(_ContentTopic) _then) = __$ContentTopicCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, String? coverImageUrl, ContentVisibility visibility, int sortOrder, bool isActive, List<ContentTopicMedia> media, DateTime createdAt
});




}
/// @nodoc
class __$ContentTopicCopyWithImpl<$Res>
    implements _$ContentTopicCopyWith<$Res> {
  __$ContentTopicCopyWithImpl(this._self, this._then);

  final _ContentTopic _self;
  final $Res Function(_ContentTopic) _then;

/// Create a copy of ContentTopic
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? coverImageUrl = freezed,Object? visibility = null,Object? sortOrder = null,Object? isActive = null,Object? media = null,Object? createdAt = null,}) {
  return _then(_ContentTopic(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as ContentVisibility,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,media: null == media ? _self._media : media // ignore: cast_nullable_to_non_nullable
as List<ContentTopicMedia>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$ContentTopicEditorInput {

 String get title; String? get description; String? get coverImageUrl; ContentVisibility get visibility; int get sortOrder; bool get isActive;
/// Create a copy of ContentTopicEditorInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentTopicEditorInputCopyWith<ContentTopicEditorInput> get copyWith => _$ContentTopicEditorInputCopyWithImpl<ContentTopicEditorInput>(this as ContentTopicEditorInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentTopicEditorInput&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,coverImageUrl,visibility,sortOrder,isActive);

@override
String toString() {
  return 'ContentTopicEditorInput(title: $title, description: $description, coverImageUrl: $coverImageUrl, visibility: $visibility, sortOrder: $sortOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ContentTopicEditorInputCopyWith<$Res>  {
  factory $ContentTopicEditorInputCopyWith(ContentTopicEditorInput value, $Res Function(ContentTopicEditorInput) _then) = _$ContentTopicEditorInputCopyWithImpl;
@useResult
$Res call({
 String title, String? description, String? coverImageUrl, ContentVisibility visibility, int sortOrder, bool isActive
});




}
/// @nodoc
class _$ContentTopicEditorInputCopyWithImpl<$Res>
    implements $ContentTopicEditorInputCopyWith<$Res> {
  _$ContentTopicEditorInputCopyWithImpl(this._self, this._then);

  final ContentTopicEditorInput _self;
  final $Res Function(ContentTopicEditorInput) _then;

/// Create a copy of ContentTopicEditorInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = freezed,Object? coverImageUrl = freezed,Object? visibility = null,Object? sortOrder = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as ContentVisibility,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentTopicEditorInput].
extension ContentTopicEditorInputPatterns on ContentTopicEditorInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentTopicEditorInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentTopicEditorInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentTopicEditorInput value)  $default,){
final _that = this;
switch (_that) {
case _ContentTopicEditorInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentTopicEditorInput value)?  $default,){
final _that = this;
switch (_that) {
case _ContentTopicEditorInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? description,  String? coverImageUrl,  ContentVisibility visibility,  int sortOrder,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentTopicEditorInput() when $default != null:
return $default(_that.title,_that.description,_that.coverImageUrl,_that.visibility,_that.sortOrder,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? description,  String? coverImageUrl,  ContentVisibility visibility,  int sortOrder,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _ContentTopicEditorInput():
return $default(_that.title,_that.description,_that.coverImageUrl,_that.visibility,_that.sortOrder,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? description,  String? coverImageUrl,  ContentVisibility visibility,  int sortOrder,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _ContentTopicEditorInput() when $default != null:
return $default(_that.title,_that.description,_that.coverImageUrl,_that.visibility,_that.sortOrder,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc


class _ContentTopicEditorInput implements ContentTopicEditorInput {
  const _ContentTopicEditorInput({required this.title, this.description, this.coverImageUrl, required this.visibility, this.sortOrder = 0, this.isActive = true});
  

@override final  String title;
@override final  String? description;
@override final  String? coverImageUrl;
@override final  ContentVisibility visibility;
@override@JsonKey() final  int sortOrder;
@override@JsonKey() final  bool isActive;

/// Create a copy of ContentTopicEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentTopicEditorInputCopyWith<_ContentTopicEditorInput> get copyWith => __$ContentTopicEditorInputCopyWithImpl<_ContentTopicEditorInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentTopicEditorInput&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,title,description,coverImageUrl,visibility,sortOrder,isActive);

@override
String toString() {
  return 'ContentTopicEditorInput(title: $title, description: $description, coverImageUrl: $coverImageUrl, visibility: $visibility, sortOrder: $sortOrder, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ContentTopicEditorInputCopyWith<$Res> implements $ContentTopicEditorInputCopyWith<$Res> {
  factory _$ContentTopicEditorInputCopyWith(_ContentTopicEditorInput value, $Res Function(_ContentTopicEditorInput) _then) = __$ContentTopicEditorInputCopyWithImpl;
@override @useResult
$Res call({
 String title, String? description, String? coverImageUrl, ContentVisibility visibility, int sortOrder, bool isActive
});




}
/// @nodoc
class __$ContentTopicEditorInputCopyWithImpl<$Res>
    implements _$ContentTopicEditorInputCopyWith<$Res> {
  __$ContentTopicEditorInputCopyWithImpl(this._self, this._then);

  final _ContentTopicEditorInput _self;
  final $Res Function(_ContentTopicEditorInput) _then;

/// Create a copy of ContentTopicEditorInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = freezed,Object? coverImageUrl = freezed,Object? visibility = null,Object? sortOrder = null,Object? isActive = null,}) {
  return _then(_ContentTopicEditorInput(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as ContentVisibility,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ContentTopicMediaInput {

 EducationalMediaType get mediaType; String get url; String? get title; int get sortOrder;
/// Create a copy of ContentTopicMediaInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentTopicMediaInputCopyWith<ContentTopicMediaInput> get copyWith => _$ContentTopicMediaInputCopyWithImpl<ContentTopicMediaInput>(this as ContentTopicMediaInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentTopicMediaInput&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,mediaType,url,title,sortOrder);

@override
String toString() {
  return 'ContentTopicMediaInput(mediaType: $mediaType, url: $url, title: $title, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $ContentTopicMediaInputCopyWith<$Res>  {
  factory $ContentTopicMediaInputCopyWith(ContentTopicMediaInput value, $Res Function(ContentTopicMediaInput) _then) = _$ContentTopicMediaInputCopyWithImpl;
@useResult
$Res call({
 EducationalMediaType mediaType, String url, String? title, int sortOrder
});




}
/// @nodoc
class _$ContentTopicMediaInputCopyWithImpl<$Res>
    implements $ContentTopicMediaInputCopyWith<$Res> {
  _$ContentTopicMediaInputCopyWithImpl(this._self, this._then);

  final ContentTopicMediaInput _self;
  final $Res Function(ContentTopicMediaInput) _then;

/// Create a copy of ContentTopicMediaInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mediaType = null,Object? url = null,Object? title = freezed,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as EducationalMediaType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentTopicMediaInput].
extension ContentTopicMediaInputPatterns on ContentTopicMediaInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentTopicMediaInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentTopicMediaInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentTopicMediaInput value)  $default,){
final _that = this;
switch (_that) {
case _ContentTopicMediaInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentTopicMediaInput value)?  $default,){
final _that = this;
switch (_that) {
case _ContentTopicMediaInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EducationalMediaType mediaType,  String url,  String? title,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentTopicMediaInput() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EducationalMediaType mediaType,  String url,  String? title,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _ContentTopicMediaInput():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EducationalMediaType mediaType,  String url,  String? title,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _ContentTopicMediaInput() when $default != null:
return $default(_that.mediaType,_that.url,_that.title,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _ContentTopicMediaInput extends ContentTopicMediaInput {
  const _ContentTopicMediaInput({required this.mediaType, required this.url, this.title, this.sortOrder = 0}): super._();
  

@override final  EducationalMediaType mediaType;
@override final  String url;
@override final  String? title;
@override@JsonKey() final  int sortOrder;

/// Create a copy of ContentTopicMediaInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentTopicMediaInputCopyWith<_ContentTopicMediaInput> get copyWith => __$ContentTopicMediaInputCopyWithImpl<_ContentTopicMediaInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentTopicMediaInput&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,mediaType,url,title,sortOrder);

@override
String toString() {
  return 'ContentTopicMediaInput(mediaType: $mediaType, url: $url, title: $title, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$ContentTopicMediaInputCopyWith<$Res> implements $ContentTopicMediaInputCopyWith<$Res> {
  factory _$ContentTopicMediaInputCopyWith(_ContentTopicMediaInput value, $Res Function(_ContentTopicMediaInput) _then) = __$ContentTopicMediaInputCopyWithImpl;
@override @useResult
$Res call({
 EducationalMediaType mediaType, String url, String? title, int sortOrder
});




}
/// @nodoc
class __$ContentTopicMediaInputCopyWithImpl<$Res>
    implements _$ContentTopicMediaInputCopyWith<$Res> {
  __$ContentTopicMediaInputCopyWithImpl(this._self, this._then);

  final _ContentTopicMediaInput _self;
  final $Res Function(_ContentTopicMediaInput) _then;

/// Create a copy of ContentTopicMediaInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mediaType = null,Object? url = null,Object? title = freezed,Object? sortOrder = null,}) {
  return _then(_ContentTopicMediaInput(
mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as EducationalMediaType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

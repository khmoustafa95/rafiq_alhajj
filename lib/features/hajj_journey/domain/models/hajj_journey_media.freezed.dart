// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hajj_journey_media.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HajjJourneyMedia {

 String get id; HajjMediaType get mediaType; String get url; String? get title; int get sortOrder;
/// Create a copy of HajjJourneyMedia
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HajjJourneyMediaCopyWith<HajjJourneyMedia> get copyWith => _$HajjJourneyMediaCopyWithImpl<HajjJourneyMedia>(this as HajjJourneyMedia, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HajjJourneyMedia&&(identical(other.id, id) || other.id == id)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,mediaType,url,title,sortOrder);

@override
String toString() {
  return 'HajjJourneyMedia(id: $id, mediaType: $mediaType, url: $url, title: $title, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $HajjJourneyMediaCopyWith<$Res>  {
  factory $HajjJourneyMediaCopyWith(HajjJourneyMedia value, $Res Function(HajjJourneyMedia) _then) = _$HajjJourneyMediaCopyWithImpl;
@useResult
$Res call({
 String id, HajjMediaType mediaType, String url, String? title, int sortOrder
});




}
/// @nodoc
class _$HajjJourneyMediaCopyWithImpl<$Res>
    implements $HajjJourneyMediaCopyWith<$Res> {
  _$HajjJourneyMediaCopyWithImpl(this._self, this._then);

  final HajjJourneyMedia _self;
  final $Res Function(HajjJourneyMedia) _then;

/// Create a copy of HajjJourneyMedia
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? mediaType = null,Object? url = null,Object? title = freezed,Object? sortOrder = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as HajjMediaType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HajjJourneyMedia].
extension HajjJourneyMediaPatterns on HajjJourneyMedia {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HajjJourneyMedia value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HajjJourneyMedia() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HajjJourneyMedia value)  $default,){
final _that = this;
switch (_that) {
case _HajjJourneyMedia():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HajjJourneyMedia value)?  $default,){
final _that = this;
switch (_that) {
case _HajjJourneyMedia() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  HajjMediaType mediaType,  String url,  String? title,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HajjJourneyMedia() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  HajjMediaType mediaType,  String url,  String? title,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _HajjJourneyMedia():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  HajjMediaType mediaType,  String url,  String? title,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _HajjJourneyMedia() when $default != null:
return $default(_that.id,_that.mediaType,_that.url,_that.title,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _HajjJourneyMedia extends HajjJourneyMedia {
  const _HajjJourneyMedia({required this.id, required this.mediaType, required this.url, this.title, this.sortOrder = 0}): super._();
  

@override final  String id;
@override final  HajjMediaType mediaType;
@override final  String url;
@override final  String? title;
@override@JsonKey() final  int sortOrder;

/// Create a copy of HajjJourneyMedia
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HajjJourneyMediaCopyWith<_HajjJourneyMedia> get copyWith => __$HajjJourneyMediaCopyWithImpl<_HajjJourneyMedia>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HajjJourneyMedia&&(identical(other.id, id) || other.id == id)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode => Object.hash(runtimeType,id,mediaType,url,title,sortOrder);

@override
String toString() {
  return 'HajjJourneyMedia(id: $id, mediaType: $mediaType, url: $url, title: $title, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$HajjJourneyMediaCopyWith<$Res> implements $HajjJourneyMediaCopyWith<$Res> {
  factory _$HajjJourneyMediaCopyWith(_HajjJourneyMedia value, $Res Function(_HajjJourneyMedia) _then) = __$HajjJourneyMediaCopyWithImpl;
@override @useResult
$Res call({
 String id, HajjMediaType mediaType, String url, String? title, int sortOrder
});




}
/// @nodoc
class __$HajjJourneyMediaCopyWithImpl<$Res>
    implements _$HajjJourneyMediaCopyWith<$Res> {
  __$HajjJourneyMediaCopyWithImpl(this._self, this._then);

  final _HajjJourneyMedia _self;
  final $Res Function(_HajjJourneyMedia) _then;

/// Create a copy of HajjJourneyMedia
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? mediaType = null,Object? url = null,Object? title = freezed,Object? sortOrder = null,}) {
  return _then(_HajjJourneyMedia(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as HajjMediaType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

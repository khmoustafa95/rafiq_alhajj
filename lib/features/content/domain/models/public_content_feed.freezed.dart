// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'public_content_feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PublicContentFeed {

 List<ContentTopic> get topics; List<ContentItem> get newsAndAnnouncements;
/// Create a copy of PublicContentFeed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicContentFeedCopyWith<PublicContentFeed> get copyWith => _$PublicContentFeedCopyWithImpl<PublicContentFeed>(this as PublicContentFeed, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicContentFeed&&const DeepCollectionEquality().equals(other.topics, topics)&&const DeepCollectionEquality().equals(other.newsAndAnnouncements, newsAndAnnouncements));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(topics),const DeepCollectionEquality().hash(newsAndAnnouncements));

@override
String toString() {
  return 'PublicContentFeed(topics: $topics, newsAndAnnouncements: $newsAndAnnouncements)';
}


}

/// @nodoc
abstract mixin class $PublicContentFeedCopyWith<$Res>  {
  factory $PublicContentFeedCopyWith(PublicContentFeed value, $Res Function(PublicContentFeed) _then) = _$PublicContentFeedCopyWithImpl;
@useResult
$Res call({
 List<ContentTopic> topics, List<ContentItem> newsAndAnnouncements
});




}
/// @nodoc
class _$PublicContentFeedCopyWithImpl<$Res>
    implements $PublicContentFeedCopyWith<$Res> {
  _$PublicContentFeedCopyWithImpl(this._self, this._then);

  final PublicContentFeed _self;
  final $Res Function(PublicContentFeed) _then;

/// Create a copy of PublicContentFeed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topics = null,Object? newsAndAnnouncements = null,}) {
  return _then(_self.copyWith(
topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<ContentTopic>,newsAndAnnouncements: null == newsAndAnnouncements ? _self.newsAndAnnouncements : newsAndAnnouncements // ignore: cast_nullable_to_non_nullable
as List<ContentItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [PublicContentFeed].
extension PublicContentFeedPatterns on PublicContentFeed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicContentFeed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicContentFeed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicContentFeed value)  $default,){
final _that = this;
switch (_that) {
case _PublicContentFeed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicContentFeed value)?  $default,){
final _that = this;
switch (_that) {
case _PublicContentFeed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ContentTopic> topics,  List<ContentItem> newsAndAnnouncements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicContentFeed() when $default != null:
return $default(_that.topics,_that.newsAndAnnouncements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ContentTopic> topics,  List<ContentItem> newsAndAnnouncements)  $default,) {final _that = this;
switch (_that) {
case _PublicContentFeed():
return $default(_that.topics,_that.newsAndAnnouncements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ContentTopic> topics,  List<ContentItem> newsAndAnnouncements)?  $default,) {final _that = this;
switch (_that) {
case _PublicContentFeed() when $default != null:
return $default(_that.topics,_that.newsAndAnnouncements);case _:
  return null;

}
}

}

/// @nodoc


class _PublicContentFeed implements PublicContentFeed {
  const _PublicContentFeed({required final  List<ContentTopic> topics, required final  List<ContentItem> newsAndAnnouncements}): _topics = topics,_newsAndAnnouncements = newsAndAnnouncements;
  

 final  List<ContentTopic> _topics;
@override List<ContentTopic> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}

 final  List<ContentItem> _newsAndAnnouncements;
@override List<ContentItem> get newsAndAnnouncements {
  if (_newsAndAnnouncements is EqualUnmodifiableListView) return _newsAndAnnouncements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_newsAndAnnouncements);
}


/// Create a copy of PublicContentFeed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicContentFeedCopyWith<_PublicContentFeed> get copyWith => __$PublicContentFeedCopyWithImpl<_PublicContentFeed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicContentFeed&&const DeepCollectionEquality().equals(other._topics, _topics)&&const DeepCollectionEquality().equals(other._newsAndAnnouncements, _newsAndAnnouncements));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_topics),const DeepCollectionEquality().hash(_newsAndAnnouncements));

@override
String toString() {
  return 'PublicContentFeed(topics: $topics, newsAndAnnouncements: $newsAndAnnouncements)';
}


}

/// @nodoc
abstract mixin class _$PublicContentFeedCopyWith<$Res> implements $PublicContentFeedCopyWith<$Res> {
  factory _$PublicContentFeedCopyWith(_PublicContentFeed value, $Res Function(_PublicContentFeed) _then) = __$PublicContentFeedCopyWithImpl;
@override @useResult
$Res call({
 List<ContentTopic> topics, List<ContentItem> newsAndAnnouncements
});




}
/// @nodoc
class __$PublicContentFeedCopyWithImpl<$Res>
    implements _$PublicContentFeedCopyWith<$Res> {
  __$PublicContentFeedCopyWithImpl(this._self, this._then);

  final _PublicContentFeed _self;
  final $Res Function(_PublicContentFeed) _then;

/// Create a copy of PublicContentFeed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topics = null,Object? newsAndAnnouncements = null,}) {
  return _then(_PublicContentFeed(
topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<ContentTopic>,newsAndAnnouncements: null == newsAndAnnouncements ? _self._newsAndAnnouncements : newsAndAnnouncements // ignore: cast_nullable_to_non_nullable
as List<ContentItem>,
  ));
}


}

// dart format on
